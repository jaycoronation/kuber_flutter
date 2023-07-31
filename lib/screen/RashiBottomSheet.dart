

import 'dart:async';
import 'dart:convert';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/PrayerListResponseModel.dart';
import '../model/PujaListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';
import 'PujaListScreen.dart';

class RashiBottomSheet extends StatefulWidget {

  const RashiBottomSheet( {super.key});
  @override
  State<RashiBottomSheet> createState() => _RashiBottomSheetState();
}

class _RashiBottomSheetState extends State<RashiBottomSheet> {
  TextEditingController rashiMothersNameController = TextEditingController();
  TextEditingController rashiFathersNameController = TextEditingController();
  TextEditingController rashiEmailController = TextEditingController();
  TextEditingController rashiTOBController = TextEditingController();
  TextEditingController rashiPOBController = TextEditingController();
  TextEditingController rashiNotesController = TextEditingController();
  TextEditingController rashiDOBController = TextEditingController();

  SessionManager sessionManager = SessionManager();

  String prayerID = "";
  bool priest = false;
  bool _isLoading = false;
  String selectedDate = "";
  String selectdateOfBirth = "Date Of Birth";
  String selectedTime = "Pick Time";
  String pujaDescription = "";
  String pujaId = "";
  String _currentAddress = "";
  String dateTimeForShow = "";
  String dateTimeForPass = "";
  bool isWantGoods = false;
  bool isPickupPriest = false;
  bool haspermission = false;
  bool isBoy = true;
  bool isGirl = false;
  String matchMakingPrice = "";
  String astroPrice = "";
  String rashiPrice = "";
  List<Prayers> _prayerList = List<Prayers>.empty(growable: true);


  @override
  void initState() {

    rashiEmailController.text= sessionManager.getEmail().toString();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: [
          StatefulBuilder(
              builder: (context,setState){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.84,
                  decoration: const BoxDecoration(
                    color:bottomSheetBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0),
                    ),
                  ),
                  child:  _isLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.88,
                          child: const LoadingWidget()
                      )
                      : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, right: 14),
                            child: Column(
                              children: [
                                Container(
                                    width: 50,
                                    margin: const EdgeInsets.only(top: 12,right: 14,left:14),
                                    child: const Divider(
                                      height: 2,
                                      thickness: 2,
                                      color: bottomSheetline,
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 16),
                                  child: const Text(
                                    "Rashi Calculator",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900, color: darkbrown, fontSize: 18),
                                  ),
                                ),

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: rashiMothersNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Mother's Name",
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

                                /* Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiMothersNameController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Mother's Name",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: rashiFathersNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Father's Name",
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

                                /* Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiFathersNameController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Father's Name",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ),*/


                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: rashiEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Email",
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

                                /*  Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: text_dark,
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ), */


                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: () async {
                                        _setDatePicker(rashiDOBController);
                                      },
                                      controller: rashiDOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Date of Birth",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*  Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiDOBController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    readOnly: true,
                                    onTap: () async {
                                      _setDatePicker(rashiDOBController);
                                    },
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Date of Birth",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ), */


                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: () async {
                                        _setTimePicker(rashiTOBController,setState);
                                      },
                                      controller: rashiTOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Time of Birth",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),


                                /*  Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiTOBController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    readOnly: true,
                                    onTap: () async {
                                      _setTimePicker(rashiTOBController);
                                    },
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText:  "Time of Birth",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: () async {
                                        placesDialog(rashiPOBController,setState);
                                      },
                                      controller: rashiPOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        labelText: "Place of Birth",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    controller: rashiPOBController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    readOnly: true,
                                    onTap: () async {
                                      placesDialog(rashiPOBController,setState);
                                    },
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Place of Birth",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ),*/

                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      minLines: 4,
                                      maxLines: 4,
                                      controller: rashiNotesController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: const BorderSide(color: Colors.grey)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey,),
                                        ),
                                        hintText: "Leave Your Detail",
                                        hintStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: white_blue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                  child: TextField(
                                    minLines: 4,
                                    maxLines: 4,
                                    controller: rashiNotesController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: text_dark,
                                    style: const TextStyle(
                                        color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Leave Your Detail",
                                        hintStyle: TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                ),
                        ), */

                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top:16,bottom:6),
                                    child: const Text("Gender",style: TextStyle(fontWeight: FontWeight.w400,color: brown,fontSize: 16),)),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isGirl = false;
                                          isBoy = true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(top: 4, right: 5,bottom: 8),
                                              child: isBoy ?
                                              const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                              const Image(image: AssetImage("assets/images/ic_radio_unselected.png"),  width: 20, height: 20, color:title,)
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 4),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Boy", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isGirl = true;
                                          isBoy = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(top: 4, right: 5,bottom: 8,left:10),
                                              child: isGirl ?
                                              const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                              const Image(image: AssetImage("assets/images/ic_radio_unselected.png"), width: 20, height: 20, color: title)
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 4),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Girl", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                Container(height: 22,),
                                TextButton(
                                  onPressed: (){
                                    if(rashiMothersNameController.text.isEmpty)
                                    {
                                      showToast('Please enter mother name', context);
                                    }
                                    else if(rashiFathersNameController.text.isEmpty)
                                    {
                                      showToast("Please enter father name", context);
                                    }
                                    else if(rashiEmailController.text.isEmpty)
                                    {
                                      showToast("Please enter email", context);
                                    }
                                    else if(rashiDOBController.text.isEmpty)
                                    {
                                      showToast("Please enter birth date ", context);
                                    }
                                    else if(rashiPOBController.text.isEmpty)
                                    {
                                      showToast("Please enter a place of birth", context);
                                    }
                                    else if(rashiTOBController.text.isEmpty)
                                    {
                                      showToast("Please enter your birth time", context);
                                    }
                                    else
                                    {
                                      reviewRashiDialog();
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: light_yellow, width: 0.5)),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(light_yellow),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Text('Review Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 22,),
                              ],
                            ),
                          ),

                          /*   Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: (){
                                if(rashiMothersNameController.text.isEmpty)
                                {
                                  showToast('Please enter mother name', context);
                                }
                                else if(rashiFathersNameController.text.isEmpty)
                                {
                                  showToast("Please enter father name", context);
                                }
                                else if(rashiEmailController.text.isEmpty)
                                {
                                  showToast("Please enter email", context);
                                }
                                else if(rashiDOBController.text.isEmpty)
                                {
                                  showToast("Please enter birth date ", context);
                                }
                                else if(rashiPOBController.text.isEmpty)
                                {
                                  showToast("Please enter a place of birth", context);
                                }
                                else if(rashiTOBController.text.isEmpty)
                                {
                                  showToast("Please enter your birth time", context);
                                }
                                else
                                {
                                  reviewRashiDialog();
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: light_yellow,
                                  elevation: 10,
                                  child: const Padding(
                                    padding: EdgeInsets.all(14.0,),
                                    child: Text("Review Request",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: title,
                                          fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ) */

                        ],
                      ),
                    ),
                  ),
                );
              }),
        ]);
  }


  _setDatePicker(TextEditingController controller){
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != selectedDate) {
                  setState(()
                  {
                    String formattedDate = DateFormat('MMMM dd, yyyy').format(value);
                    controller.text = formattedDate;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: int.parse(getCurrentYear()),
            ),
          );
        }
    );
  }

  _setPickDate(TextEditingController controller, StateSetter setState){
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedDate) {
                  setState(()
                  {
                    String formattedDate = DateFormat('MMM dd, yyyy').format(value);
                    // controller.text = formattedDate;
                    selectedDate = formattedDate;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2023,
              maximumYear: 2035,
            ),
          );
        }
    );
  }

  _setTimePicker(TextEditingController controller, StateSetter setState){
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedTime) {
                  setState(() {
                    selectedTime = ("${value.hour}:${value.minute}${value.timeZoneName}").toString();
                    selectedTime = DateFormat("h:mm a").format(value);
                    print(selectedTime);
                    controller.text =  DateFormat("h:mm a").format(value);
                  });
                }
              },
              initialDateTime: DateTime.now(),
              use24hFormat: false,
            ),
          );
        }
    );
  }

  Future<void> placesDialog(TextEditingController controller, StateSetter updateState) async {
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

    if (prediction != null) {

      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(prediction.placeId!);
      controller.text = prediction.description.toString();
      updateState((){});
    }
  }

  void reviewRashiDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return  Container(
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    )),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 12),
                            child: const Divider(
                              height: 1.5,
                              thickness: 1.5,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        "Confirm Rashi Calculator",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: title,
                            fontSize: 18),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color:sky_blue),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Mother Name",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiMothersNameController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Father Name",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiFathersNameController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Date of Birth",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiDOBController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiEmailController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Time of Birth",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiTOBController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Place of Birth",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiPOBController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Gender of Baby",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      isBoy ? "Boy" : "Girl" ,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14
                                      )
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible:  rashiNotesController.value.text.isNotEmpty,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      "Notes",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                        rashiNotesController.value.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: title,
                                            fontSize: 14
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: light_yellow,
                              elevation: 10,
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  "Edit Request",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: title,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Container(width: 8,),
                          GestureDetector(
                            onTap: (){
                              /*Navigator.pop(context);
                              saveRashiRequestApi();*/
                              saveRashiRequestApi("");
                              /*Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => UsePaypal(
                                      sandboxMode: true,
                                      clientId: PAYPAL_CLIENT_ID,
                                      secretKey:PAYPAL_CLIENT_SECRET,
                                      returnURL: "https://panditbookings.com/return",
                                      cancelURL: "http://panditbookings.com/cancel",
                                      transactions: [
                                        {
                                          "amount": {
                                            "total": rashiPrice,
                                            "currency": "USD",
                                            "details": const {
                                              "subtotal": '1',
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description":
                                          "The payment transaction description.",
                                          // "payment_options": {
                                          //   "allowed_payment_method":
                                          //       "INSTANT_FUNDING_SOURCE"
                                          // },
                                          "item_list": {
                                            "items": const [
                                              {
                                                "name": "Rashi Request",
                                                "quantity": 1,
                                                "price": '1',
                                                "currency": "USD"
                                              }
                                            ],
                                            // shipping address is not required though
                                            "shipping_address": {
                                              "recipient_name": "${sessionManager.getName()} ${sessionManager.getLastName()}",
                                              "line1": "2 Gila Crescent",
                                              "line2": "",
                                              "city": "Johannesburg",
                                              "country_code": "SA",
                                              "postal_code": "2090",
                                              "phone": "+00000000",
                                              "state": 'Gauteng'
                                            },
                                          }
                                        }
                                      ],
                                      note: "Contact us for any questions on your order.",
                                      onSuccess: (Map params) async {
                                        print("onSuccess: $params");
                                        print(params['paymentId']);
                                        String paymentId = "";
                                        paymentId = params['paymentId'];
                                        saveRashiRequestApi(paymentId);
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                      },
                                      onCancel: (params) {
                                        print('cancelled: $params');
                                      }
                                      ),
                                ),
                              );*/
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: light_yellow,
                              elevation: 10,
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  "Submit Request",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: title,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          }
          );
        }
    );
  }

  void saveRashiRequestApi(String paymentId) async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + saveRashiRequest);

    /*@Field("mother_name") mother_name:String,
    @Field("father_name") father_name:String,
    @Field("date_of_birth") date_of_birth:String,
    @Field("time_of_birth") time_of_birth:String,
    @Field("place_of_birth") place_of_birth:String,
    @Field("user_id") user_id:String,
    @Field("country") country:String,
    @Field("state") state:String,
    @Field("city") city:String,
    @Field("child_gender") child_gender:Int,
    @Field("email") email:String,
    @Field("notes") note:String,*/

    Map<String, dynamic> jsonBody = {
      'mother_name' : rashiMothersNameController.value.text,
      'father_name' : rashiFathersNameController.value.text,
      'date_of_birth' : universalDateConverter("MMMM dd, yyyy", "dd-MM-yyyy", rashiDOBController.value.text),
      'time_of_birth' : rashiTOBController.value.text,
      'place_of_birth' : rashiPOBController.value.text,
      'user_id' : sessionManager.getUserId().toString(),
      'child_gender' : isBoy ? "0" : "1" ,
      'email' : rashiEmailController.value.text,
      'notes' : rashiNotesController.value.text,
      'payment_id' : paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      afterMethod();
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

  _showAlertDialog(String image, String text) {
    Widget okButton = Image.asset(image,height: 160,width:160);

    AlertDialog alert = AlertDialog(
      content: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
              children: [
                okButton,
                Container(height: 12,),
                Text(text,style: const TextStyle(fontSize: 18,color: text_new,fontWeight: FontWeight.w900),textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
    },);
  }

  void afterMethod() {
    Navigator.pop(context, true);
  }

  
}

