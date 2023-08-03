import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CityResponseModel.dart';
import 'package:kuber/model/CountryResponseModel.dart';
import 'package:kuber/model/StateResponseModel.dart';
import 'package:kuber/screen/MyAccountScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../model/CountryListResponseModel.dart';

class SelectionScreen extends StatefulWidget {
 final String isFor;
  final String id;

  SelectionScreen(this.isFor, this.id,{Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreen();
}

class _SelectionScreen extends State<SelectionScreen> {
  bool _isLoading = false;
  String appBarTitle = "";
  List<Countries> _countryList = List<Countries>.empty(growable: true);
  List<States> _stateList = List<States>.empty(growable: true);
  List<Cities> _cityList = List<Cities>.empty(growable: true);
  final List<String> _listQualification = List<String>.empty(growable: true);
  final List<String> listExperience = List<String>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    if (widget.isFor == COUNTRY) {
      _getCountryList();
      appBarTitle = "Select Country";
    }
    else if (widget.isFor == STATE)
    {
      _getStateList();
      appBarTitle = "Select State";
    }
    else if (widget.isFor == QULIFICATION)
      {
        appBarTitle = "Select Qualification";
        _listQualification.add("Astrologer");
        _listQualification.add("Palm reader");
        _listQualification.add("Face reader");
        _listQualification.add("Tarot card reader");
        _listQualification.add("Vedacharya");
        _listQualification.add("Puranacharya");
        _listQualification.add("Others");
      }
    else if (widget.isFor == EXPRIENCE)
      {
        appBarTitle = "Select Experience";
        listExperience.add("Started");
        listExperience.add("Completed");
        listExperience.add("Experienced");
      }
    else
    {
      appBarTitle = "Select City";
      _getCityList();
    }
  }

  List<Countries> listSearchCountryName = [];
  List<States> listSearchStateName = [];
  List<Cities> listSearchCityName = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: bg_skin,
            appBar: AppBar(
              // systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 55,
              automaticallyImplyLeading: false,
              backgroundColor: bg_skin,
              elevation: 0,
              leading: IconButton(
                icon: Image.asset("assets/images/ic_back_arrow.png",
                    width: 18, height: 18),
                iconSize: 28,
                onPressed: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAccountScreen()));
                },
              ),
              title:  Text(
                appBarTitle,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: black),
                textAlign: TextAlign.center,
              ),
            ),
            body: _isLoading
                ? const LoadingWidget()
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
                        child:  TextField(
                          onChanged: (s){
                            setState((){
                              if(widget.isFor  == COUNTRY){
                                if (_countryList.isNotEmpty)
                                {
                                  listSearchCountryName = [];

                                  for (var i=0; i < _countryList.length; i++)
                                  {
                                    if (_countryList[i].name.toString().toLowerCase().contains(s.toString().toLowerCase()))
                                    {
                                      listSearchCountryName.add(_countryList[i]);
                                      print(listSearchCountryName.length);
                                    }
                                  }
                                }
                              }
                              else if (widget.isFor == STATE)
                              {
                                if (_stateList.isNotEmpty)
                                {
                                  listSearchStateName = [];

                                  for (var i=0; i < _stateList.length; i++)
                                  {
                                    if (_stateList[i].name.toString().toLowerCase().contains(s.toString().toLowerCase()))
                                    {
                                      listSearchStateName.add(_stateList[i]);
                                      print(listSearchStateName.length);
                                    }
                                  }
                                }
                              }
                              else if(widget.isFor==CITY)
                              {
                                if (_cityList.isNotEmpty)
                                {
                                  listSearchCityName = [];

                                  for (var i=0; i < _cityList.length; i++)
                                  {
                                    if (_cityList[i].name.toString().toLowerCase().contains(s.toString().toLowerCase()))
                                    {
                                      listSearchCityName.add(_cityList[i]);
                                      print(listSearchCityName.length);
                                    }
                                  }
                                }
                              }
                            });
                          },
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: "Search",
                              focusColor: black,
                              labelStyle: TextStyle(color: black)),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child:selection(widget.isFor) ,
                        ),
                      )
                    ],
                  )),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        });
  }

  ListView selection(String isFor) {
    if (isFor == COUNTRY)
      {
        return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listSearchCountryName.isNotEmpty ? listSearchCountryName.length:_countryList.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                child: Container(
                  margin:
                  const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(listSearchCountryName.isNotEmpty ? listSearchCountryName[i].name.toString():_countryList[i].name.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: text_light,
                                    thickness: 0.5,
                                    // thickness of the line
                                    height: 20,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, (listSearchCountryName.isNotEmpty ? listSearchCountryName[i] : _countryList[i]));
                },
              );
            });
      }
    else if (isFor == STATE)
      {
        return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listSearchStateName.isNotEmpty ? listSearchStateName.length:_stateList.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                child: Container(
                  margin:
                  const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(listSearchStateName.isNotEmpty ? listSearchStateName[i].name.toString():_stateList[i].name.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: text_light,
                                    thickness: 0.5,
                                    // thickness of the line
                                    height: 20,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context,  listSearchStateName.isNotEmpty? listSearchStateName[i]:_stateList[i]);
                },
              );
            });
      }
    else if (isFor == CITY)
      {
        return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listSearchCityName.isNotEmpty ? listSearchCityName.length : _cityList.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                child: Container(
                  margin:
                  const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                   padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(listSearchCityName.isNotEmpty ? listSearchCityName[i].name.toString() :_cityList[i].name.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black), textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: text_light,
                                    thickness: 0.5,
                                    // thickness of the line
                                    height: 20,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, listSearchCityName.isNotEmpty?listSearchCityName[i]: _cityList[i]);
                },
              );
            });
      }
    else if (isFor == QULIFICATION)
      {
        return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _listQualification.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                child: Container(
                  margin:
                  const EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.all(4),
                                    margin: const EdgeInsets.only(
                                        right: 6, left: 8),
                                    child: Text(_listQualification[i].toString(),
                                        style:
                                        const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                            color: Colors.black),
                                        textAlign:
                                        TextAlign.center),
                                  ),
                                  const Divider(
                                    color: text_light,
                                    thickness: 0.5,
                                    height: 20,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, _listQualification[i]);
                },
              );
            });
      }
    else
    {
      return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: listExperience.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              child: Container(
                margin:
                const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                  const EdgeInsets.all(4),
                                  margin: const EdgeInsets.only(
                                      right: 6, left: 8),
                                  child: Text(listExperience[i].toString(),
                                      style:
                                      const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight
                                              .w600,
                                          color: Colors
                                              .black),
                                      textAlign:
                                      TextAlign.center),
                                ),
                                const Divider(
                                  color: text_light,
                                  thickness: 0.5,
                                  // thickness of the line
                                  height: 20,
                                )
                              ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context, listExperience[i]);
              },
            );
          });
    }

  }
  _getCountryList() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getCountry);

    Map<String, String> jsonBody = {};

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CountryResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.countries != null) {
        _countryList = dataResponse.countries!;
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _getStateList() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getState);

    Map<String, String> jsonBody = {
      "country_id": widget.id
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = StateResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.states != null) {
        _stateList = dataResponse.states!;
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _getCityList() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getCity);

    Map<String, String> jsonBody = {
    "state_id": widget.id
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CityResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.cities != null) {
        _cityList = dataResponse.cities!;
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
