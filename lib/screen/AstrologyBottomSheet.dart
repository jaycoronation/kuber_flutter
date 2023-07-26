

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

class AstrologyBottomSheet extends StatefulWidget {

  const AstrologyBottomSheet( {super.key});
  @override
  State<AstrologyBottomSheet> createState() => _AstrologyBottomSheetState();
}

class _AstrologyBottomSheetState extends State<AstrologyBottomSheet> {

  TextEditingController astroFnameController = TextEditingController();
  TextEditingController astroLnameController = TextEditingController();
  TextEditingController astroEmailController = TextEditingController();
  TextEditingController astroMobileNumberController = TextEditingController();
  TextEditingController astroBirthTimeController = TextEditingController();
  TextEditingController astroBirthPlaceController = TextEditingController();
  TextEditingController astroNotesController = TextEditingController();
  TextEditingController astroGirlBirthDateController = TextEditingController();
  TextEditingController pickDateController = TextEditingController();
  TextEditingController pickTimeController = TextEditingController();

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


  @override
  void initState() {

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
                      ? Expanded(child: const LoadingWidget())
                      :SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              "Astrology",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, color: darkbrown, fontSize: 18),
                            ),
                          ),
                          Container(height: 12,),
                          Container(
                            margin: const EdgeInsets.only(left: 14,right:14,),
                            child: Column(
                                children:[
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(top:14,bottom: 14),
                                      child: const Text("Basic Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:brown),)
                                  ),

                                  Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: TextField(
                                        controller: astroFnameController,
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
                              controller: astroFnameController,
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
                                    borderRadius: BorderRadius.circular(14.0),
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
                                        controller: astroLnameController,
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

                                  /*  TextField(
                              controller: astroLnameController,
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
                                        onTap: (){
                                        },
                                        controller: astroEmailController,
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
                              controller: astroEmailController,
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
                                            controller: astroMobileNumberController,
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


                                  /*  Container(
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
                                  InkWell(
                                    child: Text(countryCode,
                                        style: const TextStyle(
                                            color: text_dark,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)
                                    ),
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
                                    child: TextField(
                                      controller: astroMobileNumberController,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
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
                                  Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: TextField(
                                        onTap: () async {
                                          _setDatePicker(astroGirlBirthDateController);
                                        },
                                        readOnly: true,
                                        controller: astroGirlBirthDateController,
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

                                  /*  TextField(
                              onTap: () async {
                                _setDatePicker(astroGirlBirthDateController);
                              },
                              controller: astroGirlBirthDateController,
                              keyboardType: TextInputType.text,
                              readOnly: true,
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
                                          _setTimePicker(astroBirthTimeController,setState);
                                        },
                                        readOnly: true,
                                        controller: astroBirthTimeController,
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
                                          labelText: "Birth Time",
                                          labelStyle: const TextStyle(color: text_new),                                     ),
                                      )
                                  ),

                                  /* TextField(
                              controller: astroBirthTimeController,
                              keyboardType: TextInputType.text,
                              cursorColor: text_dark,
                              readOnly: true,
                              onTap: () async {
                                _setTimePicker(astroBirthTimeController);
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Birth Time",
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
                                          placesDialog(astroBirthPlaceController, setState);
                                        },
                                        readOnly: true,
                                        controller: astroBirthPlaceController,
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

                                  /* TextField(
                              readOnly: true,
                              controller: astroBirthPlaceController,
                              keyboardType: TextInputType.text,
                              cursorColor: text_dark,
                              onTap: (){
                                placesDialog(astroBirthPlaceController, setState);
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
                                    borderRadius: BorderRadius.circular(10.0),
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
                                      margin: const EdgeInsets.only(top: 14),
                                      child: TextField(
                                        minLines: 4,
                                        maxLines: 4,
                                        controller: astroNotesController,
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
                                          labelText: "Notes",
                                          labelStyle: const TextStyle(color: text_new),                                     ),
                                      )
                                  ),
                                  /*  TextField(
                              minLines: 4,
                              maxLines: 4,
                              controller: astroNotesController,
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
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: "Notes",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ), */
                                  Container(height: 10),
                                  const Divider(
                                    thickness: 1,
                                    color: text_light,
                                    endIndent: 1,
                                  ),

                                  /* InkWell(
                              onTap:(){
                                if(astroFnameController.text.isEmpty)
                                {
                                  showToast("Please enter first name", context);
                                }
                                else if(astroLnameController.text.isEmpty)
                                {
                                  showToast("Please enter last name", context);
                                }
                                else if(astroEmailController.text.isEmpty)
                                {
                                  showToast("Please enter email address", context);
                                }
                                else if(astroMobileNumberController.text.isEmpty)
                                {
                                  showToast("Please enter mobile number", context);
                                }
                                else if(astroGirlBirthDateController.text.isEmpty)
                                {
                                  showToast("Please enter birth date", context);
                                }
                                else if (astroBirthTimeController.text.isEmpty)
                                {
                                  showToast("Please enter birth time ", context);
                                }
                                else if(astroBirthPlaceController.text.isEmpty)
                                {
                                  showToast("Please enter birth place", context);
                                }
                                else
                                {
                                  _confirmAstrology();
                                }
                              },
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: light_yellow,
                                  elevation: 10,
                                  child: const Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      "Review Request",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: title,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ), */

                                  Container(height: 22,),
                                  TextButton(
                                    onPressed:(){
                                      if(astroFnameController.text.isEmpty)
                                      {
                                        showToast("Please enter first name", context);
                                      }
                                      else if(astroLnameController.text.isEmpty)
                                      {
                                        showToast("Please enter last name", context);
                                      }
                                      else if(astroEmailController.text.isEmpty)
                                      {
                                        showToast("Please enter email address", context);
                                      }
                                      else if(astroMobileNumberController.text.isEmpty)
                                      {
                                        showToast("Please enter mobile number", context);
                                      }
                                      else if(astroGirlBirthDateController.text.isEmpty)
                                      {
                                        showToast("Please enter birth date", context);
                                      }
                                      else if (astroBirthTimeController.text.isEmpty)
                                      {
                                        showToast("Please enter birth time ", context);
                                      }
                                      else if(astroBirthPlaceController.text.isEmpty)
                                      {
                                        showToast("Please enter birth place", context);
                                      }
                                      else
                                      {
                                        _confirmAstrology();
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
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ]);
  }

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

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

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

  void _confirmAstrology() {
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
                            alignment: Alignment.center,
                            width: 50,
                            margin: const EdgeInsets.only(top: 12),
                            child: const Divider(
                              height: 1.5,
                              thickness: 1.5,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            "Confirm Astrology",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: title,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color:sky_blue),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                      astroFnameController.value.text,
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
                                      astroLnameController.value.text,
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
                                      astroGirlBirthDateController.value.text,
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
                                      astroBirthTimeController.value.text,
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
                                      astroEmailController.value.text,
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
                                      "$countryCode ${astroMobileNumberController.value.text}",
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
                                      "BirthPlace",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      astroBirthPlaceController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
                            ),
                            Visibility(
                                visible: astroNotesController.value.text.isNotEmpty,
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
                                          astroNotesController.value.text,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 20,bottom: 20),
                            child: GestureDetector(
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
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            callAstrologySaveApi("");

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
                                        "total": astroPrice,
                                        "currency": "USD",
                                        "details": const {
                                          "subtotal": '1',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description": "The payment transaction description.",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": const [
                                          {
                                            "name": "Astrology Request",
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
                                    callAstrologySaveApi(paymentId);
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
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(top: 20,bottom: 20),
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

  callAstrologySaveApi(String paymentId) async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + astrologySave);

    Map<String, String> jsonBody = {
      "first_name": astroFnameController.value.text,
      "last_name": astroLnameController.value.text,
      "birth_date": astroGirlBirthDateController.value.text,
      "birth_time": astroBirthTimeController.value.text,
      "address": astroBirthPlaceController.value.text,
      "comments": astroNotesController.value.text,
      "user_id": sessionManager.getUserId().toString(),
      "astrology_id": "",
      "email": astroEmailController.value.text,
      "mobile": astroMobileNumberController.value.text,
      "notes": astroNotesController.value.text,
      'payment_id' :paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var astroResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && astroResponse.success == 1) {
      Navigator.pop(context, true);
      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(astroResponse.message, context);
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

}

