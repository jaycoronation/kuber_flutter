import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CityResponseModel.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/model/CountryResponseModel.dart';
import 'package:kuber/model/StateResponseModel.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/SelectionScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/common_widget.dart';
import '../model/CountryListResponseModel.dart';
import '../model/PujariResponseModel.dart';
import '../model/QualificationResponseModel.dart';
import '../model/UserProfileResponseModel.dart';
import '../model/VerifyOtpResponseModel.dart' as verify;
import '../utils/responsive.dart';
import 'DashboardForWeb.dart';
import 'PujariDashboard.dart';

class MyProfileScreen extends StatefulWidget {
  final bool isFromLogin;
  const MyProfileScreen(this.isFromLogin, {Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {

  bool _isLoading = false;
  TextEditingController bdyController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController gotraController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pathshalaController = TextEditingController();
  TextEditingController gurukulController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController workCountryController = TextEditingController();
  TextEditingController workStateController = TextEditingController();
  TextEditingController workCityController = TextEditingController();
  TextEditingController workSuburbController = TextEditingController();
  SessionManager sessionManager = SessionManager();
  var countryId = "";
  String workCountryId = "";
  String workCityId = "";
  var stateId ="";
  var cityId = "";
  var profilePic = "";
  var selectedCountry = "";
  var selectedCity = "";
  var selectedState = "";
  var profilePath = File("");
  var profileName = "";
  var profilePicNew = "";
  var certificatePath = File("");
  var certificateName = "";
  var certificatePathOnline = "";

  var documentPath = File("");
  var documentPathOnline = '';
  var documentName = "";

  PujariGetSet getSetPujari = PujariGetSet();

  var profilepicName="";
  double width = 700;
  String selectedDate = "Date of birth";
  final TextEditingController textControllerForState = TextEditingController();
  final TextEditingController textControllerForCity = TextEditingController();
  final List<QualificationResponseModel> _listQualification = List<QualificationResponseModel>.empty(growable: true);

  @override
  void initState() {
    print("IS RUNNIGN NEW");
    _getUserProfileDetails(false);
    countryCode = sessionManager.getCountryCode().toString();
    getCountryData();

    _listQualification.add(QualificationResponseModel(qualification: "Astrologer",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Palm reader",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Face reader",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Tarot card reader",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Vedacharya",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Puranacharya",isSelected: false));
    _listQualification.add(QualificationResponseModel(qualification: "Others",isSelected: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
      ? WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bg_skin,
          appBar: setUpNavigationBar(),
          body: _isLoading
              ? const LoadingWidget()
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      cardProfileImage(),

                      Container(
                        margin: const EdgeInsets.only(top: 16,right: 14,left: 14),
                        alignment: Alignment.topLeft,
                        child:  Text("Profile Details",
                            style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 20) ),
                      ),

                      Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: TextField(
                            onTap: (){
                            },
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
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
                              labelStyle: const TextStyle(color: darkbrown),
                            ),
                          )
                      ),

                      Visibility(
                        visible: sessionManager.getIsPujrai() ?? false,
                        child: Container(
                            margin: const EdgeInsets.only(top: 14),
                            child: TextField(
                              controller: middleNameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: "Middle Name",
                                labelStyle: const TextStyle(color: darkbrown),
                              ),
                            )
                        ),
                      ),

                      Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: TextField(
                            onTap: (){
                            },
                            controller: lastNameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
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
                              labelStyle: const TextStyle(color: darkbrown),
                            ),
                          )
                      ),
                      Visibility(
                        visible: sessionManager.getIsPujrai() ?? false,
                        child: Container(
                            margin: const EdgeInsets.only(top: 14),
                            child: TextField(
                              controller: gotraController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: "Gotra",
                                labelStyle: const TextStyle(color: darkbrown),
                              ),
                            )
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 14),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            readOnly: sessionManager.getEmail().toString().isNotEmpty ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.grey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.grey,),
                              ),
                              labelText: "Email Address",
                              labelStyle: const TextStyle(color: darkbrown),
                            ),
                          )
                      ),

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
                                      fontSize: 14)
                              ),
                              onTap:(){
                                print("IS DONE === ");
                                countryDialog();
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
                                controller: numberController,
                                maxLength: 12,
                                keyboardType: TextInputType.number,
                                cursorColor: text_dark,
                                readOnly: numberController.value.text.isEmpty ? false : true,
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left:15,top:20,bottom:20),
                                  fillColor: bottomSheetBg,
                                  counterText: "",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                  filled: true,
                                  hintText: "Mobile Number",
                                  labelStyle: const TextStyle(
                                    color: darkbrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: sessionManager.getIsTemple() ?? false ? false : true,
                          child: setUpTextDate()
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16,right: 14,left: 14,bottom: 16),
                        alignment: Alignment.topLeft,
                        child: Text("Address",style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 20)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),),
                        child:  TextField(
                            controller: countryController,
                            onTap: () async {
                              _goForCountrySelection(context);
                            },
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            cursorColor: title,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:  const BorderSide(color: Colors.grey)
                                ),
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: title,
                                ),
                                counterText: "",
                                // border: InputBorder.none,
                                alignLabelWithHint: true,
                                labelText: "Select country",
                                labelStyle: const TextStyle(
                                  color: darkbrown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )
                            )
                        ),
                      ),
                      Container(height: 12,),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),),
                        child:  TextField(
                            controller: stateController,
                            onTap: (){
                              if(countryId.isEmpty)
                              {
                                showToast("Select your country first", context);
                              }
                              else
                              {
                                _goForStateSelection(context);
                              }
                            },
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            cursorColor: title,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  const BorderSide(color: Colors.grey,),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:  const BorderSide(color: Colors.grey)
                                ),
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: title,
                                ),
                                counterText: "",
                                alignLabelWithHint: true,
                                labelText: "Select state",
                                labelStyle: const TextStyle(
                                  color: darkbrown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )
                            )
                        ),
                      ),
                      Container(height: 12,),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child:  TextField(
                            controller: cityController,
                            onTap: (){
                              if(stateId.isEmpty)
                              {
                                showToast("Select your state first", context);
                              }else{
                                _goForCitySelection(context);

                              }
                            },
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            cursorColor: title,
                            style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  const BorderSide(color: Colors.grey,),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:  const BorderSide(color: Colors.grey)
                                ),
                                suffixIcon: const Icon(
                                  Icons .keyboard_arrow_down_rounded,
                                  color: title,
                                ),
                                counterText: "",
                                // border: InputBorder.none,
                                alignLabelWithHint: true,
                                labelText: "Select city",
                                labelStyle: const TextStyle(
                                  color: darkbrown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))
                        ),
                      ),
                      Container(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),),
                        child:  TextField(
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          cursorColor: title,
                          readOnly: true,
                          minLines: 3,
                          maxLines: 4,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          onTap: () async {
                            Prediction? prediction = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: API_KEY,
                              mode: Mode.fullscreen,
                              components: [],
                              strictbounds: false,
                              region: "",
                              decoration: const InputDecoration(
                                labelText: 'Search',
                              ),
                              types: [],
                              language: "en",
                            );
                            displayPrediction(prediction,context);
                          },

                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:  const BorderSide(color: Colors.grey,),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  const BorderSide(color: Colors.grey)
                              ),
                              counterText: "",
                              // border: InputBorder.none,
                              labelText: 'Address',
                              labelStyle: const TextStyle(
                                  color: darkbrown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                      ),
                      Visibility(
                        visible: sessionManager.getIsPujrai() ?? false,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 16,right: 14,left: 14),
                              alignment: Alignment.topLeft,
                              child: const Text("Professional Details",style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 20),),
                            ),

                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 18,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: workSuburbController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration:  InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    // border: InputBorder.none,
                                    labelText: 'Preferred Suburb',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 18,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: workCountryController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                readOnly: true,
                                onTap: () {
                                  _goForCountrySelectionWork(context);
                                },
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration:  InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons .keyboard_arrow_down_rounded,
                                      color: title,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    // border: InputBorder.none,
                                    labelText: 'Preferred Country of Work',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 18,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: workCityController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                readOnly: true,
                                onTap: () {
                                  _goForCitySelectionWork(context);
                                },
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration:  InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons .keyboard_arrow_down_rounded,
                                      color: title,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    // border: InputBorder.none,
                                    labelText: 'Preferred City of Work',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),


                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 18,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: pathshalaController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration:  InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    // border: InputBorder.none,
                                    labelText: 'Pathshala',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                controller: gurukulController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                style: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600
                                ),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    labelText: 'Gurukul',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child:  TextField(
                                  controller: qualificationController,
                                  readOnly: true,
                                  onTap: (){
                                    selectQualification();
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  style: const TextStyle(
                                      color: text_dark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey,),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide:   const BorderSide(color: Colors.grey)
                                      ),
                                      suffixIcon: const Icon(
                                        Icons .keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      alignLabelWithHint: true,
                                      labelText: "Qualification",
                                      labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ))
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child:  TextField(
                                  controller: experienceController,
                                  onTap: (){
                                    _goForExprienceSelection(context);
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  readOnly: true,
                                  style: const TextStyle(
                                      color: text_dark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),
                                  decoration:  InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey,),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide:   const BorderSide(color: Colors.grey)
                                      ),
                                      suffixIcon: const Icon(
                                        Icons .keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      alignLabelWithHint: true,
                                      labelText: "Experience",
                                      labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ))
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child:  TextField(
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                onTap: (){
                                  pickFileForCertificate("Certificate");
                                },
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    labelText: 'Certificate',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Visibility(
                              visible: (certificatePath.path.isNotEmpty) || (certificatePathOnline.isNotEmpty),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  if (await canLaunchUrl(Uri.parse(certificatePathOnline)))
                                    {
                                      launchUrl(Uri.parse(certificatePathOnline),mode: LaunchMode.externalNonBrowserApplication);
                                    }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 14, right: 14,top: 14),
                                  decoration:  BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 1,color: text_dark),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                      color: Colors.transparent
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/ic_file.png", width: 36, height: 36,),
                                        Container(width: 8,),
                                        Flexible(child: Text(certificateName, style: const TextStyle(color: text_dark,fontSize: 14,fontWeight: FontWeight.w600),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextField(
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                onTap: (){
                                  pickFileForCertificate("ID");
                                },
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:   const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:   const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    labelText: 'Government Approved ID',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Visibility(
                              visible: (documentPath.path.isNotEmpty) || (documentPathOnline.isNotEmpty),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  print('ASDASD');
                                  if (await canLaunchUrl(Uri.parse(documentPathOnline)))
                                    {
                                      print('ASDASD 2 TIEMS');
                                      await launchUrl(Uri.parse(documentPathOnline),mode: LaunchMode.externalNonBrowserApplication);
                                    }
                                  else
                                    {
                                      print(documentPathOnline);
                                      showSnackBar("Error", context);
                                    }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 14, right: 14,top: 14),
                                  decoration:  BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 1,color: text_dark),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                      color: Colors.transparent
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/ic_file.png", width: 36, height: 36,),
                                        Container(width: 8,),
                                        Flexible(child: Text(documentName, style: const TextStyle(color: text_dark,fontSize: 14,fontWeight: FontWeight.w600),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 22),
                        child: getCommonButton("Update Profile", () {
                          if(firstNameController.text.isEmpty)
                          {
                            showToast('Please enter first name', context);
                          }
                          else if(lastNameController.text.isEmpty)
                          {
                            showToast('Please enter last name', context);
                          }
                          else if(emailController.text.isEmpty)
                          {
                            showToast('Please enter email address', context);
                          }
                          else if(!isValidEmail(emailController.text.toString()))
                          {
                            showToast("Please enter valid email address", context);
                          }
                          else if(numberController.text.isEmpty)
                          {
                            showToast("Please enter contact number", context);
                          }
                          else
                          {
                            _updateProfileDetails();
                          }
                        }),
                      ),

                      Visibility(
                        visible: false,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 20, top: 22),
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                              ),
                              onPressed: () {
                                if(firstNameController.text.isEmpty)
                                {
                                  showToast('Please enter first name', context);
                                }
                                else if(lastNameController.text.isEmpty)
                                {
                                  showToast('Please enter last name', context);
                                }
                                else if(emailController.text.isEmpty)
                                {
                                  showToast('Please enter email address', context);
                                }
                                else if(!isValidEmail(emailController.text.toString()))
                                {
                                  showToast("Please enter valid email address", context);
                                }
                                else if(numberController.text.isEmpty)
                                {
                                  showToast("Please enter contact number", context);
                                }
                                else
                                {
                                  _updateProfileDetails();
                                }
                              },
                              child: const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child:  Text("Update Profile",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: text_dark,
                                        fontWeight: FontWeight.w600)),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        onWillPop: () {
          if(widget.isFromLogin)
          {
            showToast("Please update profile first", context);
          }
          else
          {
            Navigator.pop(context,true);
          }
          return Future.value(true);
        },
      )
      : WillPopScope(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: bg_skin,
            appBar: setUpNavigationBar(),
            body: _isLoading
                ? const LoadingWidget()
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Center(
                      child: Container(
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            cardProfileImage(),

                            Container(
                              margin: const EdgeInsets.only(top: 16,right: 14,left: 14),
                              alignment: Alignment.topLeft,
                              child:  Text("Profile Details",
                                  style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 20)
                              ),
                            ),

                            Container(
                                margin: const EdgeInsets.only(top: 14),
                                child: TextField(
                                  onTap: (){
                                  },
                                  controller: firstNameController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: Colors.grey,),
                                    ),
                                    labelText: "First Name",
                                    labelStyle: const TextStyle(color: darkbrown),
                                  ),
                                )
                            ),

                            Container(
                                margin: const EdgeInsets.only(top: 14),
                                child: TextField(
                                  onTap: (){
                                  },
                                  controller: lastNameController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: Colors.grey,),
                                    ),
                                    labelText: "Last Name",
                                    labelStyle: const TextStyle(color: darkbrown),
                                  ),
                                )
                            ),

                            /* Container(
                                        margin: const EdgeInsets.only(top: 14),
                                        child: TextField(
                                          onTap: (){
                                          },
                                          controller: emailController,
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.grey,
                                          readOnly: sessionManager.getEmail().toString().length>0 ,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                                borderSide: const BorderSide(color: Colors.grey)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: const BorderSide(color: Colors.grey,),
                                            ),
                                            labelText: "Email Address",
                                            labelStyle: const TextStyle(color: text_new),                                     ),
                                        )
                                    ),*/


                            Container(
                                margin: const EdgeInsets.only(top: 14),
                                child: TextField(
                                  onTap: (){
                                  },
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.grey,
                                  readOnly: sessionManager.getEmail().toString().isNotEmpty ,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: Colors.grey,),
                                    ),
                                    labelText: "Email Address",
                                    labelStyle: const TextStyle(color: darkbrown),                                     ),
                                )
                            ),

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
                                            fontSize: 14)
                                    ),
                                    onTap:(){
                                      print("IS DONE === ");
                                      countryDialog();
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
                                      controller: numberController,
                                      maxLength: 12,
                                      keyboardType: TextInputType.number,
                                      cursorColor: text_dark,
                                      readOnly: numberController.value.text.isEmpty ? false : true,
                                      style: const TextStyle(
                                          color: black,
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
                                        labelText: "Mobile Number",
                                        labelStyle: const TextStyle(
                                          color: darkbrown,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),


                            /*
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 10, right: 10, left: 10),
                                      padding: const EdgeInsets.only(left: 14, right: 14),
                                      decoration: const BoxDecoration(
                                        color: white_blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap:(){
                                              print("IS DONE === ");
                                              countryDialog();
                                            },
                                            child: Text(countryCode,
                                                style: const TextStyle(
                                                    color: text_dark,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10,right:10),
                                            height: 20,
                                            width: 1,
                                            color: text_light,
                                          ),
                                          Flexible(
                                            child: TextField(
                                                controller: numberController,
                                                keyboardType: TextInputType.number,
                                                cursorColor: text_dark,
                                                maxLength: 12,
                                                readOnly: numberController.value.text.isEmpty ? false : true,
                                                style: const TextStyle(
                                                  color: text_dark,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: const InputDecoration(
                                                    counterText: "",
                                                    border: InputBorder.none,
                                                    labelText: "Mobile number",
                                                    labelStyle: TextStyle(
                                                      color: text_dark,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ))),
                                          )
                                        ],
                                      ),
                                    ),
          */
                            Visibility(
                                visible: sessionManager.getIsTemple() ?? false ? false : true,
                                child: setUpTextDate()
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16,right: 14,left: 14,bottom: 16),
                              alignment: Alignment.topLeft,
                              child: Text("Address",style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 20)),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),),
                              child:  TextField(
                                  controller: countryController,
                                  onTap: () async {
                                    _goForCountrySelection(context);
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  style: const TextStyle(
                                    color: darkbrown,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey,),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide:  const BorderSide(color: Colors.grey)
                                      ),
                                      suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      // border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      labelText: "Select country",
                                      labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )
                                  )
                              ),
                            ),
                            Container(height: 12,),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),),
                              child:  TextField(
                                  controller: stateController,
                                  onTap: (){
                                    if(countryId.isEmpty)
                                    {
                                      showToast("Select your country first", context);
                                    }
                                    else
                                    {
                                      _goForStateSelection(context);
                                    }
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  style: const TextStyle(
                                    color: darkbrown,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide:  const BorderSide(color: Colors.grey,),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide:  const BorderSide(color: Colors.grey)
                                      ),
                                      suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      alignLabelWithHint: true,
                                      labelText: "Select state",
                                      labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )
                                  )
                              ),
                            ),
                            Container(height: 12,),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0)),
                              child:  TextField(
                                  controller: cityController,
                                  onTap: (){
                                    if(stateId.isEmpty)
                                    {
                                      showToast("Select your state first", context);
                                    }else{
                                      _goForCitySelection(context);

                                    }
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  style: const TextStyle(
                                    color: darkbrown,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide:  const BorderSide(color: Colors.grey,),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide:  const BorderSide(color: Colors.grey)
                                      ),
                                      suffixIcon: const Icon(
                                        Icons .keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      // border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      labelText: "Select city",
                                      labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ))
                              ),
                            ),
                            Container(height: 12,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),),
                              child:  TextField(
                                controller: addressController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                readOnly: true,
                                minLines: 3,
                                maxLines: 4,
                                onTap: () async {
                                  Prediction? prediction = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: API_KEY,
                                    mode: Mode.fullscreen,
                                    components: [],
                                    strictbounds: false,
                                    region: "",
                                    decoration: const InputDecoration(
                                      labelText: 'Search',
                                    ),
                                    types: [],
                                    language: "en",
                                  );
                                  displayPrediction(prediction,context);
                                },
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:  const BorderSide(color: Colors.grey,),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide:  const BorderSide(color: Colors.grey)
                                    ),
                                    counterText: "",
                                    // border: InputBorder.none,
                                    labelText: 'Address',
                                    labelStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                            ),
                            Visibility(
                              visible: sessionManager.getIsPujrai() ?? false,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 16,right: 14,left: 14),
                                    alignment: Alignment.topLeft,
                                    child: const Text("Professional Details",style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 20),),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 18,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child:   TextField(
                                      controller: pathshalaController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: title,
                                      style: const TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration:  InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide:   const BorderSide(color: Colors.grey,),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:   const BorderSide(color: Colors.grey)
                                          ),
                                          counterText: "",
                                          // border: InputBorder.none,
                                          labelText: 'Pathshala',
                                          labelStyle: const TextStyle(
                                              color: darkbrown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: TextField(
                                      controller: gurukulController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: title,
                                      style: const TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide:   const BorderSide(color: Colors.grey,),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:   const BorderSide(color: Colors.grey)
                                          ),
                                          counterText: "",
                                          labelText: 'Gurukul',
                                          labelStyle: const TextStyle(
                                              color: darkbrown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child:  TextField(
                                        controller: qualificationController,
                                        onTap: (){
                                          _goForQulificationSelection(context);
                                        },
                                        keyboardType: TextInputType.text,
                                        cursorColor: title,
                                        style: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:   const BorderSide(color: Colors.grey,),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(14),
                                                borderSide:   const BorderSide(color: Colors.grey)
                                            ),
                                            suffixIcon: const Icon(
                                              Icons .keyboard_arrow_down_rounded,
                                              color: title,
                                            ),
                                            counterText: "",
                                            alignLabelWithHint: true,
                                            labelText: "Qualification",
                                            labelStyle: const TextStyle(
                                              color: darkbrown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ))
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child:  TextField(
                                        controller: experienceController,
                                        onTap: (){
                                          _goForExprienceSelection(context);
                                        },
                                        keyboardType: TextInputType.text,
                                        cursorColor: title,
                                        readOnly: true,
                                        style: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration:  InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:   const BorderSide(color: Colors.grey,),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(14),
                                                borderSide:   const BorderSide(color: Colors.grey)
                                            ),
                                            suffixIcon: const Icon(
                                              Icons .keyboard_arrow_down_rounded,
                                              color: title,
                                            ),
                                            counterText: "",
                                            alignLabelWithHint: true,
                                            labelText: "Experience",
                                            labelStyle: const TextStyle(
                                              color: darkbrown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ))
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child:  TextField(
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      cursorColor: title,
                                      onTap: (){
                                        pickFileForCertificate("Certificate");
                                      },
                                      style: const TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide:   const BorderSide(color: Colors.grey,),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:   const BorderSide(color: Colors.grey)
                                          ),
                                          counterText: "",
                                          labelText: 'Certificate',
                                          labelStyle: const TextStyle(
                                              color: darkbrown,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: certificatePath.path.isNotEmpty,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 14, right: 14,top: 14),
                                      decoration:  BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(width: 1,color: text_dark),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(14.0),
                                          ),
                                          color: Colors.transparent
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/images/ic_file.png", width: 36, height: 36,),
                                            Container(width: 8,),
                                            Flexible(child: Text(certificateName, style: const TextStyle(color: text_dark,fontSize: 14,fontWeight: FontWeight.w600),))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 20, top: 22),
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14.0),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                                  ),
                                  onPressed: () {
                                    if(firstNameController.text.isEmpty)
                                    {
                                      showToast('Please enter first name', context);
                                    }
                                    else if(lastNameController.text.isEmpty)
                                    {
                                      showToast('Please enter last name', context);
                                    }
                                    else if(emailController.text.isEmpty)
                                    {
                                      showToast('Please enter email address', context);
                                    }
                                    else if(!isValidEmail(emailController.text.toString()))
                                    {
                                      showToast("Please enter valid email address", context);
                                    }
                                    else if(numberController.text.isEmpty)
                                    {
                                      showToast("Please enter contact number", context);
                                    }
                                    else
                                    {
                                      _updateProfileDetails();
                                    }
                                  },
                                  child: const Padding(
                                    padding:  EdgeInsets.only(top: 14.0, bottom: 14),
                                    child:  Text("Update Profile",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: text_dark,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          onWillPop: () {
            if(widget.isFromLogin)
            {
              showToast("Please update profile first", context);
            }
            else
            {
              Navigator.pop(context,true);
            }
            return Future.value(true);
          },
        );
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)

      addressController.text = p.description.toString();
    }
  }

  Widget setUpTextDate() {
    return Container(
      margin: const EdgeInsets.only(top: 10,),
      child: ResponsiveWidget.isSmallScreen(context)
        ? TextField(
        readOnly: true,
        controller: bdyController,
        keyboardType: TextInputType.number,
        cursorColor: title,
        style: const TextStyle(
            color: text_dark,
            fontSize: 14,
            fontWeight: FontWeight.w600
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.grey,),
          ),
          labelText: "Date of birth",
          labelStyle: const TextStyle(color: darkbrown, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        onTap: () async {
          _setDatePicker(bdyController);
        },
      )
        : TextField(
            readOnly: true,
            controller: bdyController,
            keyboardType: TextInputType.number,
            cursorColor: title,
            style: const TextStyle(
                color: black,
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.grey)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.grey,),
              ),
              labelText: "Date of birth",
              labelStyle: const TextStyle(color: darkbrown, fontWeight: FontWeight.w500, fontSize: 16),
            ),
            // onTap: () async {
            //   _setDatePicker(bdyController);
            // },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now(),
                    helpText: 'Preferred Move Date',
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                    //you can implement different kind of Date Format here according to your requirement
                    setState(() {
                      selectedDate = formattedDate;
                      bdyController.text = formattedDate;
                    });
                  }
                },
          )
          );
  }

  Widget cardProfileImage() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              _showBottomSheetForImagePicker();
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
                // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                color: Colors.white,
                width: 130,
                height: 130,
                child: profilePath.path.isNotEmpty
                    ? Image.file(profilePath,fit: BoxFit.cover)
                    : sessionManager.getImagePic().toString().isNotEmpty
                    ? FadeInImage.assetNetwork(image:sessionManager.getImagePic().toString(),fit:BoxFit.cover,
                      placeholder:"assets/images/ic_user_placeholder.png")
                    : Image.asset("assets/images/ic_user_placeholder.png",fit: BoxFit.cover,)
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: white),
              height: 30.0,
              width: 30.0,
              child:IconButton(
                icon:Image.asset("assets/images/ic_fill_pen.png", width: 30, height: 30, color: text_dark,),
                iconSize: 30,
                onPressed: () {
                  _showBottomSheetForImagePicker();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  File fileNew = File("");
  dynamic fileBytes;

  void pickFile() async {
    await Permission.storage.request();
    var status = await Permission.storage.request();
    if (status.isDenied)
      {
        Permission.storage.request();
        showSnackBar("Please grant storage permission to upload the profile picture", context);
      }
    else if (status.isPermanentlyDenied)
      {
        Permission.storage.request();
        showSnackBar("Please grant storage permission to upload the profile picture", context);
      }
    else if (status.isGranted)
      {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;

        setState(() {
          profilePath = File(result.files.single.path!);
          profilePicNew = "";
          profilePic = result.files.single.path!;
          print("Data Response Profile === ${profilePic.trimRight()}");
        });

      }

  }

  _showBottomSheetForImagePicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: SizedBox(
                    width: 50,
                    child: Divider(color: Colors.grey,height: 1.5,thickness: 1.5,),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 14,bottom: 8),
                  child: Text('Select Image From?', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Image.asset("assets/images/ic_camera.png",width: 24,height: 24,),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text('Camera', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.start,)
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    pickImageFromCamera();
                  },
                ),
                const Divider(thickness: 0.5,color: Colors.black,),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Image.asset("assets/images/ic_gallery.png",width: 24,height: 24,),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text('Gallery', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),)
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    pickImageFromGallery();
                  },
                ),
                Container(height: 12)
              ],
            )

          ],
        );
      },
    );
  }

  Future<void> pickImageFromCamera() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 0,);
      if(pickedfiles != null)
      {
        final filePath = pickedfiles.path;
        File tempFile = File(filePath);

        setState(() {
          profilePath = File(filePath);
          profilePicNew = "";
          profilePic = filePath;
        });
        print("_pickImage picImgPath ====>$profilePic");
        //_makeUploadProfilePic();
        _callProfileUpdateWithImage();
      }
      else
      {
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      var pickedfiles = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 0);
      if(pickedfiles != null){
        final filePath = pickedfiles.path;

        setState(() {
          profilePath = File(filePath);
          profilePicNew = "";
          profilePic = filePath;
        });
        _callProfileUpdateWithImage();

      }else{
        print("No image is selected.");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  _callProfileUpdateWithImage() async {
    setState(() {
      _isLoading = true;
    });

    if (sessionManager.getIsPujrai() ?? false)
    {
      HttpWithMiddleware httpLogger = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(MAIN_URL + updateProfilePicPujari);
      var request = http.MultipartRequest("POST", url);
      request.fields['user_id'] = sessionManager.getUserId().toString();
      request.fields['from_app'] = "true";
      request.files.add(await http.MultipartFile.fromPath('profile_pic', profilePic));

      print(request.fields);
      print(request.url);

      var response = await request.send();

      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = CommonResponseModel.fromJson(user);

      print(jsonEncode(dataResponse));

      if (statusCode == 200 && dataResponse.success == 1) {
        if (dataResponse.success != null) {

        }
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(dataResponse.message, context);
      }
    }
    else if (sessionManager.getIsTemple() ?? false)
    {
      HttpWithMiddleware httpLogger = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(MAIN_URL + updateProfilePicTemple);

      var request = http.MultipartRequest("POST", url);
      request.fields['user_id'] =sessionManager.getUserId().toString();
      request.fields['from_app'] = "true";
      request.files.add(await http.MultipartFile.fromPath('profile_pic', profilePath.path));

      var response = await request.send();

      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = CommonResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(dataResponse.message, context);
      }
    }
    else
    {
      final url = Uri.parse(MAIN_URL + updateProfilePic);

      var request = http.MultipartRequest("POST", url);
      request.fields['user_id'] = sessionManager.getUserId().toString();
      request.fields['type'] = "User";
      request.fields['from_app'] = "true";
      request.files.add(await http.MultipartFile.fromPath('profile_pic', profilePic));
      print(profilePath.path);
      print(request.fields);
      print(request.files);
      print(request.url);
      var response = await request.send();
      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      print(responseString);
      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = CommonResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {
        _getUserProfileDetails(false);
      }
      else
      {
        print(dataResponse.message);
        setState(()
        {
          _isLoading = false;
        });
        showSnackBar(dataResponse.message, context);
      }
    }
  }

  void pickFileForCertificate(String isFor) async {

    FilePickerResult? result = await FilePicker
        .platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
        allowMultiple: false,
        allowCompression: true
    );

    if (result == null) return;

    if(kIsWeb)
      {
        fileBytes = result.files.first.bytes;
      }
    else
      {
        setState((){
          if (isFor == "ID")
            {
              documentPath = File(result.files.single.path ?? '');
              documentName = result.files.single.name;
            }
          else
            {
              certificatePath = File(result.files.single.path!);
              certificateName = result.files.single.name;
            }
        });
      }

    print('File Name: ${result.files.single.name}');
    print('File Size: ${result.files.single.size}');
    print('File Extension: ${result.files.single.extension}');
    // print('File Path: $fileNew');
  }

  PreferredSizeWidget setUpNavigationBar() {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      backgroundColor: bg_skin,
      elevation: 0,
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if(widget.isFromLogin)
          {
            showToast("Please update profile first", context);
          }
          else
          {
            Navigator.pop(context,true);
          }
        },
        child: getBackArrow(),
      ),
      title: const Text(
        "My Profile",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
        textAlign: TextAlign.center,
      ),
      titleSpacing: 0,
    );
  }

  Future<void> _goForCountrySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(COUNTRY,"")),
    ) as Countries;

    List<CountryListResponseModel> listSearchCountryName = [];

    print("result ID :  ===== ${result.name}");
    selectedCountry = result.id!;

    if (result.toString().isNotEmpty)
    {
      countryId  = result.id.toString();
      countryController.text = result.name.toString();
      selectedState ="";
      stateController.text ="";
      cityController.text = "";
    }

  }

  Future<void> _goForCountrySelectionWork(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(COUNTRY,"")),
    ) as Countries;

    List<CountryListResponseModel> listSearchCountryName = [];

    print("result ID :  ===== ${result.name}");
    if (result.toString().isNotEmpty)
    {
      workCountryId  = result.id.toString();
      workCountryController.text = result.name.toString();
      workCityController.text = "";
    }
  }

  Future<void> _goForStateSelection(BuildContext context) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(STATE,countryId)),
    ) as States;
    print("result ID :  ===== ${result.name}");

    selectedState= result.id!;
    if (result.toString().isNotEmpty)
    {
      stateId  = result.id.toString();
      stateController.text = result.name.toString();
      selectedCity = "";
      cityController.text = "";
    }
  }

  Future<void> _goForCitySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(CITY,stateId)),
    ) as Cities;

    print("result ID :  ===== ${result.name}");

    if (result.toString().isNotEmpty)
    {
      cityId  = result.id.toString();
      cityController.text = result.name.toString();
    }
  }

  Future<void> _goForCitySelectionWork(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(CITY_WORK,workCountryId)),
    ) as Cities;

    print("result ID :  ===== ${result.name}");

    if (result.toString().isNotEmpty)
    {
      workCityId = result.id.toString();
      workCityController.text = result.name.toString();
    }
  }

  Future<void> _goForQulificationSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(QULIFICATION,"")),
    ) as String;

    print("result ID :  ===== ${result}");

    if (result.toString().isNotEmpty)
    {
      qualificationController.text = result.toString();
    }
  }

  Future<void> _goForExprienceSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen(EXPRIENCE,"")),
    ) as String;

    print("result ID :  ===== ${result}");

    if (result.toString().isNotEmpty)
    {
      experienceController.text = result.toString();
    }
  }

  _updateProfileDetails() async {
    setState(() {
      _isLoading = true;
    });

    if (sessionManager.getIsPujrai() ?? false)
      {
        HttpWithMiddleware httpLogger = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(MAIN_URL + updateProfileForPriest);

        Map<String, String> jsonBody = {
          "id": sessionManager.getUserId().toString(),
          "first_name": firstNameController.value.text,
          "middle_name": middleNameController.value.text,
          "last_name": lastNameController.value.text,
          "email": emailController.value.text,
          "mobile": numberController.value.text,
          "gotra": gotraController.value.text,
          "country": countryController.value.text,
          "country_id": countryId,
          "country_code": countryCode,
          "state" : stateController.value.text,
          "state_id" : stateId,
          "city" : cityController.value.text,
          "city_id" : cityId,
          "address" : addressController.value.text,
          "birthdate" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd",bdyController.value.text),
          "birthplace":"",
          "gender":"1",
          "qualification":qualificationController.value.text,
          "experiance":experienceController.value.text,
          "qualification_other":"",
          "experience_other":"",
          "pathshala":pathshalaController.value.text,
          "gurukul":gurukulController.value.text,
          "profile_pic_name": getSetPujari.profilePicName ?? '',
          "certificate_name": getSetPujari.certificateName ?? '',
          "work_city": workCityId,
          "work_country": workCountryId,
          "work_city_name": workCityController.value.text,
          "work_country_name": workCountryController.value.text,
          "work_suburb": workSuburbController.value.text,
        };

        print(jsonBody);

        http.MultipartRequest request = http.MultipartRequest('POST', url,);
        if (certificatePath.path.isNotEmpty)
        {
          request.files.add(await http.MultipartFile.fromPath('certificate', certificatePath.path));
        }
        else
          {
            request.fields['certificate'] = '';
          }

        if (documentPath.path.isNotEmpty)
          {
            request.files.add(await http.MultipartFile.fromPath('document', documentPath.path));
          }
        else
          {
            request.fields['document'] = '';
          }

        request.fields.addAll(jsonBody);

        http.StreamedResponse response = await request.send();
        var responseBytes = await response.stream.toBytes();
        var responseString = utf8.decode(responseBytes);
        print("responseString == $responseString");
        final statusCode = response.statusCode;

        print(statusCode);

        Map<String, dynamic> user = jsonDecode(responseString);
        print(jsonEncode(user));
        var dataResponse = CommonResponseModel.fromJson(user);

        print(jsonEncode(dataResponse));

        if (statusCode == 200 && dataResponse.success == 1) {
           _getUserProfileDetails(true);

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
      else if (sessionManager.getIsTemple() ?? false)
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(MAIN_URL + updateProfileForTemple);

        Map<String, String> jsonBody = {
          "id": sessionManager.getUserId().toString(),
          "first_name":"",
          "last_name":"",
          "email":"",
          "mobile":"",
          "country":"",
          "state":"",
          "city":"",
          "address":"",
          "birthdate":"",
          "birthplace":"",
          "profile_pic_name":""
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommonResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          if (dataResponse.success != null) {
            // _countryList = dataResponse.countries!;
          }
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
    else
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);


        final url = Uri.parse(MAIN_URL + updateProfileForUser);

        Map<String, String> jsonBody = {
          "id": sessionManager.getUserId().toString(),
          "first_name":firstNameController.value.text,
          "last_name":lastNameController.value.text,
          "email":emailController.value.text,
          "mobile":numberController.value.text,
          "country":countryId,
          "country_code":countryCode,
          "state":stateId,
          "city":cityId,
          "address":addressController.value.text,
          "birthdate": universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", bdyController.value.text),
          "birthplace":addressController.value.text,
          "profile_pic_name":profilepicName,
          "type": sessionManager.getType().toString()
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommonResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          _getUserProfileDetails(true);
          if (dataResponse.success != null) {
            // _countryList = dataResponse.countries!;
          }
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
  }

  void _getUserProfileDetails(bool isSaveData) async {
    setState(() {
      //_isLoading = true;
    });
    print("TYPE ==== ${sessionManager.getIsPujrai()}");
    if (sessionManager.getIsPujrai() ?? false)
      {
        try {
          HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

          final url = Uri.parse(MAIN_URL + getUserProfilePujari);

          Map<String, String> jsonBody = {
            "id": sessionManager.getUserId().toString(),
          };

          final response = await http.post(url, body: jsonBody);

          final statusCode = response.statusCode;

          final body = response.body;
          Map<String, dynamic> user = jsonDecode(body);
          print("body ==== ${user}");
          var dataResponse = PujariResponseModel.fromJson(user);
          print("dataResponse ==== ${dataResponse}");

          if (statusCode == 200 && dataResponse.success == 1)
            {
              var getSet = dataResponse.profile ?? PujariGetSet();

              getSetPujari = getSet;

              setState(() {
                certificateName = getSet.certificateName ?? '';
                documentName = getSet.document ?? '';

                certificatePathOnline = getSet.certificate ?? '';
                documentPathOnline = getSet.document ?? '';

                firstNameController.text = getSet.firstName ?? "";
                lastNameController.text = getSet.lastName ?? "";
                numberController.text = getSet.mobile ?? "";
                emailController.text = getSet.email ?? "";
                middleNameController.text = getSet.middleName ?? '';
                gotraController.text = getSet.gotra ?? '';
                bdyController.text = universalDateConverter("yyyy-MM-dd","dd MMM,yyyy", getSet.birthdate.toString() ?? "");
                addressController.text = getSet.address.toString() ?? "";
                countryController.text = getSet.countryName == null ? "" : getSet.countryName ?? "";
                stateController.text = getSet.stateName == null ? "" : getSet.stateName ?? "";
                cityController.text = getSet.cityName == null ? "" : getSet.cityName ?? "";
                profilePic = getSet.profilePic ?? "";
                pathshalaController.text = getSet.pathshala ?? '';
                gurukulController.text = getSet.gurukul ?? '';
                qualificationController.text = getSet.qualificationOther ?? '';
                experienceController.text = getSet.experience ?? '';
                countryCode = getSet.countryCode ?? '';
                countryId = getSet.country ?? '';
                stateId = getSet.state ?? '';
                cityId = getSet.city ?? '';

                workCountryId = getSet.workCountry ?? '';
                workCityId = getSet.workCity ?? '';

                workSuburbController.text = getSet.workSuburb ?? '';
                workCountryController.text = getSet.workCountryName ?? '';
                workCityController.text = getSet.workCityName ?? '';

                if (countryCode.isEmpty)
                  {
                    countryCode = "Select";
                  }
              });

              verify.Profile getSetData = verify.Profile();

              getSetData.userId = dataResponse.profile?.id ?? '';
              getSetData.mobile = dataResponse.profile?.mobile;
              getSetData.profilePic = dataResponse.profile?.profilePic;
              getSetData.countryId = dataResponse.profile?.country;
              getSetData.stateId = dataResponse.profile?.state;
              getSetData.cityId = dataResponse.profile?.state;
              getSetData.email = dataResponse.profile?.email;
              getSetData.firstName = dataResponse.profile?.firstName;
              getSetData.lastName = dataResponse.profile?.lastName;
              getSetData.countryCode = dataResponse.profile?.countryCode;
              getSetData.type = "Pujari";

              await sessionManager.createLoginSession(getSetData);
              stopLoader();
          }
          else
            {
              stopLoader();
              showToast(dataResponse.message, context);
            }

          if(isSaveData)
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PujariDashboard()), (route) => false);
          }
        } on Exception catch (e) {
          print("ERROR === $e");
        }
      }
    else if (sessionManager.getIsTemple() ?? false)
      {

      }
    else
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(MAIN_URL + getUserProfileUser);

        Map<String, String> jsonBody = {
          "id": sessionManager.getUserId().toString(),
          'type' : sessionManager.getType().toString()
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = UserProfileResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1)
        {
          stopLoader();
          var getSet = dataResponse.profile!;
          firstNameController.text = getSet.firstName.toString() ?? "";
          lastNameController.text = getSet.lastName.toString() ?? "";
          numberController.text = getSet.mobile.toString() ?? "";
          emailController.text = getSet.email.toString() ?? "";
          bdyController.text = universalDateConverter("yyyy-MM-dd","dd MMM,yyyy",getSet.birthdate.toString() ?? "");
          addressController.text = getSet.address.toString() ?? "";
          countryController.text = getSet.countryName ?? "";
          stateController.text = getSet.stateName ?? "";
          cityController.text = getSet.cityName ?? "";
          countryCode = getSet.countryCode ?? "";
          profilePic = getSet.profilePic ?? "";
          countryId = getSet.countryId ?? '';
          stateId = getSet.stateId ?? '';
          cityId = getSet.cityId ?? '';

          var getSetData = Profile();
          getSetData.id = getSet.id;
          getSetData.mobile = getSet.mobile;
          getSetData.profilePic = getSet.profilePic;
          getSetData.countryId = getSet.countryId;
          getSetData.stateId = getSet.stateId;
          getSetData.cityId = getSet.stateId;
          getSetData.email = getSet.email;
          getSet.firstName = getSet.firstName;
          getSetData.lastName = getSet.lastName;
          getSetData.countryCode = getSet.countryCode;

          sessionManager.setEmail(getSet.email ?? '');
          sessionManager.setPhone(getSet.mobile ?? '');
          sessionManager.setName(getSet.firstName ?? '');
          sessionManager.setLastName(getSet.lastName ?? '');
          sessionManager.setImage(getSet.profilePic ?? '');
          sessionManager.setType("User");

          stopLoader();
        }
        else
        {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(dataResponse.message, context);
        }
        stopLoader();
        if(isSaveData)
        {
          if (ResponsiveWidget.isSmallScreen(context))
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
          }
          else
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardForWeb()), (route) => false);
          }
        }
      }

    setState(() {
      _isLoading = false;
    });

  }

  void stopLoader(){
    print("ISRunning");
    setState(() {
      _isLoading = false;
    });

  }

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: white,
        builder: (context){
          return StatefulBuilder(
              builder:(context, updateState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: const BoxDecoration(
                    color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      )
                  ),
                  child: Column(
                    children:  [
                      Container(
                          width: 50,
                          margin: const EdgeInsets.only(top: 12),
                          child: const Divider(
                            height: 1.5,
                            thickness: 1.5,
                            color: Colors.grey,
                          )
                      ),
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
                              updateState((){
                                if (listCountryCode.isNotEmpty)
                                {
                                  listSearchCountryName = [];

                                  for (var i=0; i < listCountryCode.length; i++)
                                  {
                                    if (listCountryCode[i].name.toLowerCase().contains(editable.toString().toLowerCase()))
                                    {
                                      listSearchCountryName.add(listCountryCode[i]);
                                      print(listSearchCountryName.length);
                                    }
                                  }
                                }
                              });
                            },
                          decoration: InputDecoration(
                            fillColor: white_blue,
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)
                            ),
                            filled: true,
                            labelText: "Search",
                            labelStyle: const TextStyle(
                              color: text_dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
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
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  List data = [];

  Future<void> getCountryData() async {
    var jsonText = await rootBundle.loadString('assets/countries.json');
    setState(() => data = json.decode(jsonText));
    var name = "";
    var code = "";
    var dial_code = "";
    for (var i=0; i < data.length; i++)
    {
      name = data[i]['name'];
      code = data[i]['code'];
      dial_code = data[i]['dial_code'] ?? "";
      listCountryCode.add(CountryListResponseModel(name: name, dialCode: dial_code, code: code));
    }
  }

  _setDatePicker(TextEditingController controller) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != DateTime.parse(selectedDate)) {
                  setState(()
                  {
                    String formattedDate = DateFormat('dd MMM,yyyy').format(value);
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

  selectQualification() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: white,
        builder: (context){
          return Wrap(
            children: [
              StatefulBuilder(
                  builder:(context, updateState) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          )
                      ),
                      child: Column(
                        children:  [
                          Container(
                              width: 50,
                              margin: const EdgeInsets.only(top: 12),
                              child: const Divider(
                                height: 1.5,
                                thickness: 1.5,
                                color: Colors.grey,
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Select Qualification",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: title,
                                  fontSize: 18),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _listQualification.length,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                  onTap: (){
                                    updateState(() {
                                      if (_listQualification[i].isSelected ?? false)
                                        {
                                          _listQualification[i].isSelected = false;
                                        }
                                      else
                                        {
                                          _listQualification[i].isSelected = true;
                                        }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 14, right: 14),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              _listQualification[i].isSelected ?? false
                                                  ? Image.asset("assets/images/ic_check.png", width: 20, height: 20, )
                                                  : Image.asset("assets/images/ic_uncheckbox_blue.png",  width: 20, height: 20,),
                                              Container(width: 12,),
                                              Flexible(child: Text( _listQualification[i].qualification ?? '',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w200,color: title), textAlign: TextAlign.start,)),
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
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(bottom: 20, left: 12,right: 12),
                              child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                                ),
                                onPressed: () {
                                  qualificationController.text = "";
                                  for (var i=0; i < _listQualification.length; i++)
                                    {
                                      if (_listQualification[i].isSelected ?? false)
                                        {
                                          if (qualificationController.value.text.isEmpty)
                                            {
                                              qualificationController.text = _listQualification[i].qualification ?? '';
                                            }
                                          else
                                            {
                                              qualificationController.text = "${qualificationController.value.text}, ${_listQualification[i].qualification ?? ''}";
                                            }
                                        }
                                    }
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Text("Select",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: text_dark,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                          ),
                        ],
                      ),
                    );
                  }
              ),
            ],
          );
        });
  }

}
