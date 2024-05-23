import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/AddressListResponseModel.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/common_widget.dart';
import '../utils/app_utils.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  State<MyAddresses> createState() => _MyAddresses();
}

class _MyAddresses extends State<MyAddresses> {
  bool _isLoading = false;
  bool _isNoDataVisible = false;
  final SessionManager _sessionManager = SessionManager();
  TextEditingController addressController = TextEditingController();
  List<Address> _listAddress = [];
  String addressString = "";

  @override
  void initState() {
    getAddressListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bg_skin,
          appBar: AppBar(
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
            title: getTitle("My Addresses"),
            actions: [
              IconButton(
                icon: Image.asset("assets/images/ic_add.png", width: 18, height: 18),
                iconSize: 24,
                onPressed: () {
                 placesDialog();
                },
              )
            ],
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: Text("No Address Found",style: TextStyle(color: text_dark,fontWeight: FontWeight.w600,fontSize: 18),))
                  ],
                )
              : SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _listAddress.length,
                    itemBuilder: (context, i){
                      return Container(
                        margin: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          color: white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_listAddress[i].address1.toString(),style: const TextStyle(color: text_light,fontWeight: FontWeight.w500,fontSize: 14),),
                                Container(height: 8,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit, size: 18,),
                                            Container(width: 8,),
                                            const Text("Edit",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: title),)
                                          ],
                                        ),
                                        onTap: ()
                                        {
                                          addressController.text = _listAddress[i].address1.toString();
                                          openAddAddressDialog(_listAddress[i]);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          showDeleteAddressDialog(_listAddress[i]);
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.delete, size: 18,),
                                            Container(width: 8,),
                                            const Text("Delete",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: title),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              )
        ),
        onWillPop:  () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  getAddressListApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getAddressList);

    Map<String, String> jsonBody = {
      'user_id' : _sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AddressListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      _listAddress = [];
      _listAddress = dataResponse.address ?? [];

      if (_listAddress.isNotEmpty)
      {
          _isNoDataVisible = false;
        }
      else
        {
          _isNoDataVisible = true;
          placesDialog();
        }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isNoDataVisible = true;
      });
      placesDialog();
      showToast(dataResponse.message, context);
    }
  }

  Future<void> placesDialog() async {
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
      language: "en",);

    displayPrediction(prediction,context);
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {

      addressString = p.description.toString();
      openAddAddressDialog(Address(addressId: ""));
    }
  }

  void openAddAddressDialog(Address getSet) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder: (context,setState){
                return Wrap(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.only(left: 14,right: 14),
                          child: Column(
                            children: [
                              Container(
                                  width: 50,
                                  margin: const EdgeInsets.only(top: 12),
                                  child: const Divider(
                                    height: 1.5,
                                    thickness: 1.5,
                                    color: Colors.grey,
                                  )),
                              Container(height: 8,),
                              Row(
                                children: [
                                  Image.asset("assets/images/ic_location.png",height: 24,width: 24,),
                                  Container(width: 8,),
                                  Expanded(child: Text(addressString,style: const TextStyle(fontWeight: FontWeight.w600,color: black,fontSize: 14),)),
                                  InkWell(
                                    onTap: (){
                                      addressString = "";
                                      addressController.text = "";
                                      Navigator.pop(context);
                                      placesDialog();
                                    },
                                      child: const Text("CHANGE",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),)
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 12,bottom: 12),
                                child: TextField(
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  style: const TextStyle(color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                                    fillColor: white_blue,
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                    ),
                                    filled: true,
                                    hintText: "House / Flat / Block No.",
                                    hintStyle: const TextStyle(
                                      color: text_dark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      onPressed: (){
                                        if (addressController.value.text.isEmpty)
                                          {
                                            showToast("Please enter house / flat / block no", context);
                                          }
                                        else
                                          {
                                            if (getSet.addressId.toString().isNotEmpty)
                                              {
                                                updateAddressApi(getSet);
                                              }
                                            else
                                              {
                                                addAddressApi();
                                              }
                                          }
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                            ),
                                          ),
                                          backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                                      ),
                                      child: const Text("Save", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: text_dark),)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  addAddressApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    Navigator.pop(context);
    final url = Uri.parse(MAIN_URL + addAddress);

    /*@Field("user_id") user_id: String,
    @Field("address1") address1: String,
    @Field("landmark") landmark: String,
    @Field("country") country: String,
    @Field("state") state: String,
    @Field("city") city: String,
    @Field("zipcode") zipcode: String*/

    Map<String, String> jsonBody = {
      'user_id': _sessionManager.getUserId().toString(),
      'address1': addressController.value.text + " " + addressString,
      'landmark': "",
      'country': "India",
      'state': "Gujarat",
      'city': "Ahmedabad",
      'zipcode': "380015",
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      getAddressListApi();
      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

  updateAddressApi(Address getSet) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + updateAddress);

    Map<String, String> jsonBody = {
      'user_id': _sessionManager.getUserId().toString(),
      'address1': addressController.value.text + " " + addressString,
      'address_id':getSet.addressId.toString() ,
      'landmark': "",
      'country': "",
      'state': "",
      'city': "",
      'zipcode': "",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      getAddressListApi();
      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

  void showDeleteAddressDialog(Address getSet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      width: 60,
                      margin: const EdgeInsets.only(top: 12),
                      child: const Divider(height: 1.5, thickness: 1.5,color: Colors.grey,)),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Delete Address", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to delete this Address?", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 15),textAlign: TextAlign.center,),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(12),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(orange)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "No",
                                style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(12),
                          child: TextButton(
                            onPressed: () {
                              deleteAddressApi(getSet);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Yes",
                                style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  deleteAddressApi(Address getSet) async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deleteAddress);

    Map<String, String> jsonBody = {
      'address_id': getSet.addressId.toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showToast(dataResponse.message, context);

      getAddressListApi();

      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

}