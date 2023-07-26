

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
import '../model/CountryListResponseModel.dart';
import '../model/PrayerListResponseModel.dart';
import '../model/PujaListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';
import 'PujaListScreen.dart';

class MatchaMakingBottomSheet extends StatefulWidget {

  const MatchaMakingBottomSheet( {super.key});
  @override
  State<MatchaMakingBottomSheet> createState() => _MatchaMakingBottomSheetState();
}

class _MatchaMakingBottomSheetState extends State<MatchaMakingBottomSheet> {
  TextEditingController matchFnameController = TextEditingController();
  TextEditingController matchLnameController = TextEditingController();
  TextEditingController matchEmailcontroller = TextEditingController();
  TextEditingController matchNumberController = TextEditingController();
  TextEditingController matchGirlFnameController = TextEditingController();
  TextEditingController matchGirlLNameController = TextEditingController();
  TextEditingController matchGirlBirthDateController = TextEditingController();
  TextEditingController matchGirlBirthTimeController = TextEditingController();
  TextEditingController matchGirlBirthPlaceController = TextEditingController();
  TextEditingController matchBoyFNameController = TextEditingController();
  TextEditingController matchBoyLNameController = TextEditingController();
  TextEditingController matchBoyBirthDateController = TextEditingController();
  TextEditingController matchBoyBirthTimeController = TextEditingController();
  TextEditingController matchBoyBirthPlaceController = TextEditingController();
  TextEditingController matchNoteController = TextEditingController();

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: const BoxDecoration(
                      color: bottomSheetBg,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.0),
                        topRight: Radius.circular(22.0),
                      )),
                  child:  _isLoading
                      ? Expanded(child: const LoadingWidget())
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
                                    margin: const EdgeInsets.only(top: 12),
                                    child: const Divider(
                                      height: 2,
                                      thickness: 2,
                                      color: bottomSheetline,
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                    "Match Making",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: darkbrown, fontSize: 18),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 20,bottom:14),
                                    child: const Text(
                                      "Yajman's details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: text_new,
                                          fontSize: 16),
                                    )),

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: matchFnameController,
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
                                        labelText: "First Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),


                                /* TextField(
                        controller: matchFnameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "First Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      controller: matchLnameController,
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
                                        labelText: "Last Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        controller: matchLnameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                fillColor: white_blue,
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Last Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      controller: matchEmailcontroller,
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
                                        labelText: "Email",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        controller: matchEmailcontroller,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                fillColor: white_blue,
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(left: 14, right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),

                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: Text(countryCode,
                                            style: const TextStyle(
                                                color: text_dark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        onTap: (){
                                          countryDialog(setState);
                                        },
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 20,
                                        width: 1,
                                        color: text_light,
                                      ),
                                      Flexible(
                                        child:TextField(
                                          controller: matchNumberController,
                                          maxLength: 12,
                                          keyboardType: TextInputType.number,
                                          cursorColor: text_dark,
                                          style: const TextStyle(
                                              color: title,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(left:15,top:20,bottom:20),
                                            fillColor: bottomSheetBg,
                                            counterText: "",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(14.0),
                                                borderSide: const BorderSide(
                                                    width: 0, style: BorderStyle.none)),
                                            filled: true,
                                            hintText: "Mobile Number",
                                            hintStyle: const TextStyle(
                                              color: text_dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                /* Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: const BoxDecoration(
                                color: white_blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                        ),
                        child: Row(
                                children: [
                                  GestureDetector(
                                    child:  Text(countryCode,
                                        style: const TextStyle(
                                            color: text_dark,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)),
                                    onTap: (){
                                      countryDialog(setState);
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 20,
                                    width: 1,
                                    color: text_light,
                                  ),
                                  Flexible(
                                    child:TextField(
                                      controller: matchNumberController,
                                      maxLength: 12,
                                      keyboardType: TextInputType.number,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: title,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 0, style: BorderStyle.none)),
                                        filled: true,
                                        hintText: "Mobile Number",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      ), */
                                Container(height: 12,),
                                Container(
                                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "Girl's details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: text_new,
                                          fontSize: 16),
                                    )),

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: matchGirlFnameController,
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
                                        labelText: "First Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        controller: matchGirlFnameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                fillColor: white_blue,
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "First Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: matchGirlLNameController,
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
                                        labelText: "Last Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*   TextField(
                        controller: matchGirlLNameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                fillColor: white_blue,
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Last Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: () async {
                                        _setDatePicker(matchGirlBirthDateController);
                                      },
                                      readOnly: true,
                                      controller: matchGirlBirthDateController,
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
                                        labelText: "Birth date",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        onTap: () async {
                                _setDatePicker(matchGirlBirthDateController);
                        },
                        controller: matchGirlBirthDateController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        readOnly: true,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                counterText: "",
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth date",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: () async {
                                        _setTimePicker(matchGirlBirthTimeController,setState);
                                      },
                                      readOnly:true,
                                      controller: matchGirlBirthTimeController,
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
                                        labelText: "Birth time",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        onTap: () async {
                                _setTimePicker(matchGirlBirthTimeController);
                        },
                        readOnly:true,
                        controller: matchGirlBirthTimeController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth time",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */
                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: (){
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        placesDialog(matchGirlBirthPlaceController, setState);
                                      },
                                      controller: matchGirlBirthPlaceController,
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
                                        labelText: "Birth Place",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*  TextField(
                        controller: matchGirlBirthPlaceController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        readOnly: true,
                        onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                placesDialog(matchGirlBirthPlaceController, setState);
                        },
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth Place",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10, right: 14),
                                    child: const Text(
                                      "Boy's details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: text_new,
                                          fontSize: 16),
                                    )),

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      controller: matchBoyFNameController,
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
                                        labelText: "First Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        controller: matchBoyFNameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "First Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */
                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      controller: matchBoyLNameController,
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
                                        labelText: "Last Name",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        controller: matchBoyLNameController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                counterText: "",
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Last Name",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: () async {
                                        _setDatePicker(matchBoyBirthDateController);
                                      },
                                      readOnly: true,
                                      controller: matchBoyBirthDateController,
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
                                        labelText: "Birth date",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        onTap: () async {
                                _setDatePicker(matchBoyBirthDateController);
                        },
                        controller: matchBoyBirthDateController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        readOnly: true,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                counterText: "",
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth date",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: () async {
                                        _setTimePicker(matchBoyBirthTimeController,setState);
                                      },
                                      controller: matchBoyBirthTimeController,
                                      readOnly: true,
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
                                        labelText: "Birth time",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* TextField(
                        onTap: () async {
                                _setTimePicker(matchBoyBirthTimeController);
                        },
                        controller: matchBoyBirthTimeController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        readOnly: true,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                counterText: "",
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth time",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 14),
                                    child: TextField(
                                      onTap: (){
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        placesDialog(matchBoyBirthPlaceController, setState);
                                      },
                                      controller: matchBoyBirthPlaceController,
                                      readOnly: true,
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
                                        labelText: "BirthPlace",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*  TextField(
                        controller: matchBoyBirthPlaceController,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        readOnly: true,
                        onTap: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                placesDialog(matchBoyBirthPlaceController, setState);
                        },
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                counterText: "",
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "BirthPlace",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */
                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      minLines: 4,
                                      maxLines: 4,
                                      controller: matchNoteController,
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
                                        labelText: "Note",
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*   TextField(
                        controller: matchNoteController,
                        minLines: 4,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        cursorColor: text_dark,
                        style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                                fillColor: white_blue,
                                contentPadding: const EdgeInsets.only(left:15,top:5,bottom:5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Note",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                        ),
                      ), */
                                Container(
                                  margin: const EdgeInsets.only(left:14,right:14,top:10),
                                  child: const Divider(
                                    thickness: 1,
                                    color: text_light,
                                    endIndent: 1,
                                  ),
                                ),


                                Container(height: 22,),
                                TextButton(
                                  onPressed: () {
                                    if (matchFnameController.text.isEmpty)
                                    {
                                      showToast('Please enter first name', context);
                                    }
                                    else if (matchLnameController.text.isEmpty)
                                    {
                                      showToast('Please enter last name', context);
                                    }
                                    else if (matchEmailcontroller.text.isEmpty)
                                    {
                                      showToast("Please enter email", context);
                                    }
                                    else if (matchNumberController.text.isEmpty)
                                    {
                                      showToast("Please enter phone number", context);
                                    }
                                    else if (matchGirlFnameController.text.isEmpty)
                                    {
                                      showToast("Please enter girl first name", context);
                                    }
                                    else if (matchGirlLNameController.text.isEmpty)
                                    {
                                      showToast("Please enter girl last name", context);
                                    }
                                    else if (matchGirlBirthDateController.text.isEmpty)
                                    {
                                      showToast("Please enter girl birth", context);
                                    }
                                    else if (matchGirlBirthTimeController.text.isEmpty)
                                    {
                                      showToast("Please enter girl birth time", context);
                                    }
                                    else if (matchGirlBirthPlaceController.text.isEmpty)
                                    {
                                      showToast("Please enter girl birth place", context);
                                    }
                                    else if (matchBoyFNameController.text.isEmpty)
                                    {
                                      showToast("Please enter boy first name", context);
                                    }
                                    else if (matchBoyLNameController.text.isEmpty)
                                    {
                                      showToast("Please enter boy last name", context);
                                    }
                                    else if (matchBoyBirthPlaceController.text.isEmpty)
                                    {
                                      showToast("Please enter boy birthplace", context);
                                    }
                                    else if (matchBoyBirthDateController.text.isEmpty)
                                    {
                                      showToast("Please enter boy birth date", context);
                                    }
                                    else
                                    {
                                      _confirmMatchMaking();
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
                          /* InkWell(
                        onTap: () {
                          if (matchFnameController.text.isEmpty)
                          {
                            showToast('Please enter first name', context);
                          }
                          else if (matchLnameController.text.isEmpty)
                          {
                            showToast('Please enter last name', context);
                          }
                          else if (matchEmailcontroller.text.isEmpty)
                          {
                            showToast("Please enter email", context);
                          }
                          else if (matchNumberController.text.isEmpty)
                          {
                            showToast("Please enter phone number", context);
                          }
                          else if (matchGirlFnameController.text.isEmpty)
                          {
                            showToast("Please enter girl first name", context);
                          }
                          else if (matchGirlLNameController.text.isEmpty)
                          {
                            showToast("Please enter girl last name", context);
                          }
                          else if (matchGirlBirthDateController.text.isEmpty)
                          {
                            showToast("Please enter girl birth", context);
                          }
                          else if (matchGirlBirthTimeController.text.isEmpty)
                          {
                            showToast("Please enter girl birth time", context);
                          }
                          else if (matchGirlBirthPlaceController.text.isEmpty)
                          {
                            showToast("Please enter girl birth place", context);
                          }
                          else if (matchBoyFNameController.text.isEmpty)
                          {
                            showToast("Please enter boy first name", context);
                          }
                          else if (matchBoyLNameController.text.isEmpty)
                          {
                            showToast("Please enter boy last name", context);
                          }
                          else if (matchBoyBirthPlaceController.text.isEmpty)
                          {
                            showToast("Please enter boy birthplace", context);
                          }
                          else if (matchBoyBirthDateController.text.isEmpty)
                          {
                            showToast("Please enter boy birth date", context);
                          }
                          else
                          {
                            _confirmMatchMaking();
                          }
                        },
                        child: Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
                          child:  Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: light_yellow,
                            elevation: 10,
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text("Review Request",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: title,
                                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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


            ),
          ]),
    );
  }


  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog(StateSetter updateState) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder:(context, setState)
              {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      )),
                  child: Column(
                    children:  [
                      Container(
                          width: 50,
                          margin: const EdgeInsets.only(top: 12),
                          child: const Divider(
                            height: 1.5,
                            thickness: 1.5,
                            color: Colors.grey,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          "Select Country Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: title,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20,bottom: 10,left: 14,right: 14),
                        child: TextField(
                          controller: countryCodeSeachController,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                              color: title,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          onChanged: (editable){
                            if (listCountryCode != null && listCountryCode.length > 0)
                            {
                              listSearchCountryName = [];

                              if (editable.length > 0)
                              {
                                for (var i=0; i < listCountryCode.length; i++)
                                {
                                  if (listCountryCode[i].name.toLowerCase().contains(editable.toString().toLowerCase()))
                                  {
                                    listSearchCountryName.add(listCountryCode[i]);
                                  }
                                }
                              }
                              else
                              {
                                listSearchCountryName = [];
                              }
                              setState((){});
                              /*adapterCountry = AdapterCountry(activity, listSearchCountryName, dialog)
                              rvCountry.adapter = adapterCountry*/
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: white_blue,
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                            filled: true,
                            hintText: "Search",
                            hintStyle: const TextStyle(
                              color: text_dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: listSearchCountryName.isNotEmpty ? listSearchCountryName.length : listCountryCode.length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: (){
                                  setState((){
                                    countryCode = listSearchCountryName.isNotEmpty ? listSearchCountryName[i].dialCode : listCountryCode[i].dialCode;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 14, right: 14),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(child: Text( listSearchCountryName.isNotEmpty ? listSearchCountryName[i].name : listCountryCode[i].name.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w200,color: title), textAlign: TextAlign.start,)),
                                            Text(listSearchCountryName.isNotEmpty ? listSearchCountryName[i].dialCode : listCountryCode[i].dialCode.toString(),style: const TextStyle(fontWeight: FontWeight.w300,color: text_new,fontSize: 16),)
                                          ],
                                        ),
                                      ),
                                      const Divider(height: 1,color: text_light,indent: 1,)
                                    ],
                                  ),

                                ),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
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

  void _confirmMatchMaking() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return  Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    )),
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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "Confirm Match Making",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: title,
                            fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color:sky_blue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 10),
                                  child: const Text("Yajman's Details",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: title),)),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchFnameController.value.text,
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
                                        "Last Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchLnameController.value.text,
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
                                        matchEmailcontroller.value.text,
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
                                        "Mobile Number",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "$countryCode ${matchNumberController.value.text}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: title,
                                            fontSize: 14)),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 10),
                                  child: const Text("Girls's Details",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: title),)),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchGirlFnameController.value.text,
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
                                        "Last Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchGirlLNameController.value.text,
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
                                        "Birth date",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchGirlBirthDateController.value.text,
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
                                        "Birth time",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchGirlBirthTimeController.value.text,
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
                                        "Birth Place",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchGirlBirthPlaceController.value.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: title,
                                            fontSize: 14)),
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 10),
                                  child: const Text("Boy's Details",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: title),)),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchBoyFNameController.value.text,
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
                                        "Last Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchBoyLNameController.value.text,
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
                                        "Birth date",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchBoyBirthDateController.value.text,
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
                                        "Birth time",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchBoyBirthTimeController.value.text,
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
                                        "Birth Place",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: text_light),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        matchBoyBirthPlaceController.value.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: title,
                                            fontSize: 14)),
                                  )
                                ],
                              ),
                              Visibility(
                                  visible: matchNoteController.value.text.isNotEmpty,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Notes",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: text_light),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            matchNoteController.value.text,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: title,
                                                fontSize: 14)),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child:GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(top: 20,bottom: 20,left: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: light_yellow,
                                elevation: 10,
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text("Edit Request",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: title,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: const EdgeInsets.only(top: 20,bottom: 20,right: 10),
                          child: GestureDetector(
                            onTap: (){
                              _callsaveMatchdataAPI("");
                              /* Navigator.of(context).push(
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
                                          "total": matchMakingPrice,
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
                                              "name": "Match Making Request",
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
                                      String paymentId = "";
                                      paymentId = params['paymentId'];
                                      _callsaveMatchdataAPI(paymentId);
                                    },
                                    onError: (error) {
                                      print("onError: $error");
                                    },
                                    onCancel: (params) {
                                      print('cancelled: $params');
                                    }
                                ),
                              ),
                            );
                              */
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
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ));
          });
        });
  }

  _callsaveMatchdataAPI(String paymentId) async {
    setState(() {
      _isLoading = true;
    });

    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + matchmakingsave);

    Map<String, String> jsonBody = {
      "user_id": sessionManager.getUserId().toString(),
      "bride_name": matchGirlLNameController.value.text,
      "bride_surname": matchGirlLNameController.value.text,
      "bride_birth_date": universalDateConverter("MMMM dd, yyyy","dd-MM-yyyy", matchGirlBirthDateController.value.text),
      "bride_birth_time": matchGirlBirthTimeController.value.text,
      "bride_address": matchGirlBirthPlaceController.value.text,
      "groom_name": matchBoyFNameController.value.text,
      "groom_surname": matchBoyLNameController.value.text,
      "groom_birth_date": universalDateConverter("MMMM dd, yyyy","dd-MM-yyyy", matchBoyBirthDateController.value.text),
      "groom_birth_time": matchBoyBirthTimeController.value.text,
      "groom_address": matchBoyBirthPlaceController.value.text,
      "comments": matchNoteController.value.text,
      "first_name": matchFnameController.value.text,
      "last_name": matchLnameController.value.text,
      "email": matchEmailcontroller.value.text,
      "mobile": matchNumberController.value.text,
      "match_id": "",
      'payment_id' :paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      afterMethod();
      setState(()
      {
        _isLoading = false;
      });
    } else
    {
      setState(()
      {
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

  void afterMethod() {
    Navigator.pop(context, true );
  }


}

