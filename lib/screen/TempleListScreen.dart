import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:kuber/model/TempleListResponseModel.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/places_autocomplete.dart';
import 'package:kuber/utils/full_screen_image.dart';
import 'package:kuber/widget/loading_more.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/common_widget.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
import '../widget/loading.dart';

class TempleListScreen extends StatefulWidget {
  const TempleListScreen(List<Results> listTemples, {Key? key}) : super(key: key);

  @override
  State<TempleListScreen> createState() => _TempleListScreen();

}

class _TempleListScreen extends State<TempleListScreen> {

  bool _isLoading = false;
  double long = 0.0, lat = 0.0;
  bool haspermission = false;
  late GoogleGeocoding googleGeocoding;
  late LocationPermission permission;
  late Position position;
  List<Results> _listTemples = [];
  ScrollController _scrollViewController = ScrollController();
  bool _isNoDataVisible = false;
  bool isScrollingDown = false;
  bool _isLastPage = false;
  bool _isVisible = false;
  bool _isLoadingMore = false;
  String nextPageToken = '';
  String test = '';
  List<Suggestion> suggestion = [];

  @override
  void initState() {
    checkPermission();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      pagination();
    });
    super.initState();
  }

  void pagination() {
    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent)) {
        setState(() {
          _isLoadingMore = true;
          getTempleList(false);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: bg_skin,
            appBar:AppBar(
              // systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              backgroundColor: bg_skin,
              elevation: 0,
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackArrow(),
              ),
              title: getTitle("Temple List"),
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Prediction? prediction = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: API_KEY,
                      mode: Mode.fullscreen,
                      components: [],
                      strictbounds: false,
                      region: "",
                      decoration: const InputDecoration(
                        hintText: 'Search',
                      ),
                      types: [],
                      language: "en",
                    );
                    displayPrediction(prediction);
                  },
                  child: Image.asset("assets/images/ic_search.png",height: 24,width: 24),
                ),
                Container(width: 12,)
              ],
              centerTitle: true,
            ),
            body: _isLoading
                ? const LoadingWidget()
                : Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollViewController,
                      child: Container(
                        margin: const EdgeInsets.only(left: 14,right: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text('Temple visit is spiritual experience that makes a person better.',style: TextStyle(fontWeight: FontWeight.w500,color: black,fontSize: 14),)
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,bottom: 20),
                              padding: const EdgeInsets.only(left: 14,right: 14),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: light_yellow,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _isLoading
                                        ? "0 Temple found"
                                        : _listTemples.isEmpty
                                        ? "0 Temple found"
                                        : "${_listTemples.length} Temple found",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: title,
                                        fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount:_listTemples.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Card(
                                    margin: const EdgeInsets.only( top: 6, bottom: 6),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    color:  priest_light,
                                    child: Column(
                                      children: [
                                        Visibility(
                                          visible:_listTemples[i].photos != null ,
                                          child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${_listTemples[i].photos?[0].photoReference}&key=$API_KEY", [], 0)));
                                              },
                                              child: FadeInImage.assetNetwork( width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,placeholder: "assets/images/placeholder.png", image: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${_listTemples[i].photos?[0].photoReference}&key=$API_KEY")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(_listTemples[i].name.toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: Colors.black),
                                                          textAlign: TextAlign.start
                                                      ),
                                                      Text(_listTemples[i].vicinity.toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: Colors.black
                                                          ),
                                                          textAlign: TextAlign.start
                                                      ),
                                                    ]),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=Google&query_place_id=${_listTemples[i].placeId}"),mode: LaunchMode.externalApplication );
                                                },
                                                child: Container(
                                                    width: 38,
                                                    height: 38,
                                                    padding: const EdgeInsets.all(4.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        color: black
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Image.asset("assets/images/ic_right_arrow.png",width: 14,height:14,color:white),
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                )
                          ],
                        ),
                      ),
                    )
                ),
                Visibility(
                    visible: _isLoadingMore,
                    child: const LoadingMoreWidget()
                )
              ],
            )
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        })
        : WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: bg_skin,
            appBar:AppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              backgroundColor: bg_skin,
              elevation: 0,
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackArrow(),
              ),
              title: Text("Temple List $test",
                style: const TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  child: Image.asset("assets/images/ic_search.png",height: 24,width: 24),
                ),
                Container(width: 12,)
              ],
              centerTitle: true,
            ),
            body: _isLoading
                ? const LoadingWidget()
                : Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Container(
                              margin: const EdgeInsets.only(left: 14,right: 14),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: const Text('Temple visit is spiritual experience that makes a person better.',style: TextStyle(fontWeight: FontWeight.w500,color: black,fontSize: 14),)
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10,bottom: 20),
                                    padding: const EdgeInsets.only(left: 14,right: 14),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      color: light_yellow,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          _isLoading
                                              ? "0 Temple found"
                                              : _listTemples.isEmpty
                                              ? "0 Temple found"
                                              : "${_listTemples.length} Temple found",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: title,
                                              fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount:_listTemples.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return Card(
                                          margin: const EdgeInsets.only( top: 6, bottom: 6),
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          color:  priest_light,
                                          child: Column(
                                            children: [
                                              Visibility(
                                                visible:_listTemples[i].photos != null ,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${_listTemples[i].photos?[0].photoReference}&key=$API_KEY", [], 0)));
                                                  },
                                                  child: FadeInImage.assetNetwork( width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,placeholder: "assets/images/placeholder.png", image: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${_listTemples[i].photos?[0].photoReference}&key=$API_KEY")),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(_listTemples[i].name.toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    color: Colors.black),
                                                                textAlign: TextAlign.start
                                                            ),
                                                            Container(height: 8,),
                                                            Text(_listTemples[i].vicinity.toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight.w500,
                                                                  color: Colors.black
                                                              ),
                                                              textAlign: TextAlign.start
                                                            ),
                                                          ]),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=Google&query_place_id=${_listTemples[i].placeId}"),mode: LaunchMode.externalApplication );
                                                      },
                                                      child: Container(
                                                          width: 38,
                                                          height: 38,
                                                          padding: const EdgeInsets.all(4.0),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              color: black
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(6.0),
                                                            child: Image.asset("assets/images/ic_right_arrow.png",width: 14,height:14,color:white),
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          )
                      ),
                      Visibility(
                          visible: _isLoadingMore,
                          child: const LoadingMoreWidget()
                      )
                    ],
            )
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        });

  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId!);
      final latitude = detail.result?.geometry!.location.lat;
      final longitude = detail.result?.geometry!.location.lng;

      lat = latitude!;
      long = longitude!;
      nextPageToken = "";

      getTempleList(true);
    }
  }

  void checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied)
    {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
      {
        showToast('Location permissions are denied', context);
      }
      else if(permission == LocationPermission.deniedForever)
      {
        showToast("Location permissions are permanently denied", context);
      }
      else
      {
        haspermission = true;
      }
    }
    else
    {
      haspermission = true;
    }

    if (!haspermission)
    {
      //openAppSettings();
      permission = await Geolocator.requestPermission();
    }
    else
    {
      setState(() {
        _isLoading = true;
      });
      getLocation();
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
    getTempleList(true);
    var location = "$lat,$long";
    print("Test$location");
    //_makeSearchPlaceRequest(location);
  }

  void getTempleList(bool isFirstTime) async {

    if (isFirstTime) {
      setState(() {
        _isLoading = true;
        _isLoadingMore = false;
        _isLastPage = false;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var location = "$lat,$long";
    print("Test$location");

    Map<String, dynamic> jsonBody = {
      'location': location,
      'rankby': "distance",
      'keyword': "hindu temple",
      'pagetoken' : nextPageToken,
      'key' : API_KEY
    };

    // var uri = Uri.https('cors-anywhere.herokuapp.com', '/https://maps.googleapis.com/maps/api/place/nearbysearch/json', jsonBody);
    var uri = Uri.https('maps.googleapis.com', '/maps/api/place/nearbysearch/json', jsonBody);

    var response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded; charset=UTF-8',
    });

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = TempleListResponseModel.fromJson(user);

    if (isFirstTime) {
      if (_listTemples.isNotEmpty) {
        _listTemples = [];
      }
    }

    if (statusCode == 200)
    {
      List<Results>? _tempList = [];
      _tempList = dataResponse.results;
      _listTemples.addAll(_tempList!);
      nextPageToken = dataResponse.nextPageToken ?? '';

      _listTemples.reversed.toList();

      if (_listTemples.isNotEmpty)
      {
        _isNoDataVisible = false;
      }
      else
      {
        _isNoDataVisible = true;
      }

      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
    else
    {
      setState(()
      {
        _isLoading = false;
        _isLoadingMore = false;
        _isNoDataVisible = false;
      });
    }
  }

}