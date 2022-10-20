
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CityResponseModel.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/model/CountryResponseModel.dart';
import 'package:kuber/model/StateResponseModel.dart';
import 'package:kuber/model/VerifyOtpResponseModel.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/MyAccountScreen.dart';
import 'package:kuber/screen/SelectionScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import '../model/CountryListResponseModel.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

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
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pathshalaController = TextEditingController();
  TextEditingController gurukulController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  SessionManager sessionManager = SessionManager();
  var countryId = "";
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
  var profilepicName="";
  String selectedDate = "Date of birth";
  var kGoogleApiKey = "AIzaSyB9HMvtsM0RcwXMLleDydO1_95KoZBi_jI";
  final TextEditingController textControllerForState = TextEditingController();
  final TextEditingController textControllerForCity = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCountryData();
   _getUserProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                        child: const Text("Profile Details",style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 20),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 18,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        child: TextField(
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                          cursorColor: title,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'First name',
                              hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        child:  TextField(
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                          cursorColor: title,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'Last name',
                              hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: title,
                          readOnly: sessionManager.getEmail().toString().length>0 ,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
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
                              onTap:(){
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
                                      hintText: "Mobile number",
                                      hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ))),
                            )
                          ],
                        ),
                      ),
                      Visibility(visible: sessionManager.getIsTemple() ?? false ? false : true,child: setUpTextDate()),
                      Container(
                        margin: const EdgeInsets.only(top: 14,right: 14,left: 14,bottom: 14),
                        alignment: Alignment.topLeft,
                        child: const Text("Address",style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 20),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
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
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: title,),
                                counterText: "",
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                hintText: "Select country",
                                hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ))
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        child:  TextField(
                            controller: stateController,
                            onTap: (){
                              if(selectedCountry.isEmpty)
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
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: title,
                                ),
                                counterText: "",
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                hintText: "Select state",
                                hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ))
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        child:  TextField(
                            controller: cityController,
                            onTap: (){
                              if(selectedState.isEmpty)
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
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons .keyboard_arrow_down_rounded,
                                  color: title,
                                ),
                                counterText: "",
                                border: InputBorder.none,
                                alignLabelWithHint: true,
                                hintText: "Select city",
                                hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ))
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
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
                                apiKey: kGoogleApiKey,
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
                          },
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900)),
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
                              margin: const EdgeInsets.only(top: 18,right: 10,left: 10),
                              padding: const EdgeInsets.only(left: 14, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
                              child:   TextField(
                                controller: pathshalaController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: 'Pathshala',
                                    hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                              padding: const EdgeInsets.only(left: 14, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
                              child: TextField(
                                controller: gurukulController,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: 'Gurukul',
                                    hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                              padding: const EdgeInsets.only(left: 14, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
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
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(
                                        Icons .keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      hintText: "Qualification",
                                      hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ))
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                              padding: const EdgeInsets.only(left: 14, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
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
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(
                                        Icons .keyboard_arrow_down_rounded,
                                        color: title,
                                      ),
                                      counterText: "",
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      hintText: "Experience",
                                      hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ))
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
                              padding: const EdgeInsets.only(left: 14, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
                              child:  TextField(
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                cursorColor: title,
                                onTap: (){
                                  pickFileForCertificate();
                                },
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: 'Certificate',
                                    hintStyle: TextStyle(
                                        color: text_dark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
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
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 44, bottom: 20, right: 14, left: 14),
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                            ),
                            onPressed: () {
                              if(emailController.text.isEmpty)
                                {
                                  showToast('Please enter email address', context);
                                }
                              else if(!isValidEmail(emailController.text.toString()))
                                {
                                  showToast("Please enter valid email address", context);
                                }
                              else if(countryController.text.isEmpty)
                                {
                                showToast("Please select your country", context);
                              }
                              else if(stateController.text.isEmpty)
                              {
                                showToast("Please select your state", context);
                              }
                              else if(cityController.text.isEmpty)
                              {
                                showToast("Please select your city", context);
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
                          )),
                    ],
                  ),
                ),),
        onWillPop: () {
        Navigator.pop(context,true);
        return Future.value(true);
      },
    );
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      addressController.text = p.description.toString();
    }
  }

  Widget setUpTextDate() {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 10),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: white_blue),
      child: TextField(
        readOnly: true,
        controller: bdyController,
        keyboardType: TextInputType.number,
        cursorColor: title,
        style: const TextStyle(
            color: title,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: 'Date of birth',
            hintStyle: TextStyle(
                color: title,
                fontSize: 14,
                fontWeight: FontWeight.w900)),
        onTap: () async {
             _setDatePicker(bdyController);
        },
      ),
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
              pickFile();
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
                  pickFile();
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {

      if(kIsWeb){
        fileBytes = result.files.first.bytes;
        profilePicNew = "";
        profilePic = result.files.single.path!;
        profilePath = result.files.first.path as File;
      }
      else{

        profilePath = File(result.files.single.path!);
        profilePicNew = "";
        profilePic = result.files.single.path!;
        print("Data Response Profile"+ profilePic.trimRight());

      }
    });
        _callProfileUpdateWithImage();

  }

  _callProfileUpdateWithImage() async {
    setState(() {
      _isLoading = true;
    });

    if (sessionManager.getIsPujrai() ?? false)
    {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(MAIN_URL + updateProfilePicPujari);
      var request = MultipartRequest("POST", url);
      request.fields['user_id'] = sessionManager.getUserId().toString();
      request.fields['from_app'] = "true";
      request.files.add(await MultipartFile.fromPath('profile_pic', profilePath.path));

      var response = await request.send();

      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = CommonResponseModel.fromJson(user);

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
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(MAIN_URL + updateProfilePicTemple);

      var request = MultipartRequest("POST", url);
      request.fields['user_id'] =sessionManager.getUserId().toString();
      request.fields['from_app'] = "true";
      request.files.add(await MultipartFile.fromPath('profile_pic', profilePath.path));

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

      var request = MultipartRequest("POST", url);
      request.fields['user_id'] = sessionManager.getUserId().toString();
      request.fields['from_app'] = "true";
      request.files.add(await MultipartFile.fromPath('profile_pic', profilePath.path));

      var response = await request.send();
      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = CommonResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {
        _getUserProfileDetails();
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

  void pickFileForCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],allowMultiple: false);
    if (result == null) return;

    if(kIsWeb) {
      fileBytes = result.files.first.bytes;
    }else {
      setState((){
        certificatePath = File(result.files.single.path!);
        certificateName = result.files.single.name;
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
      leading: IconButton(
        icon: Image.asset("assets/images/ic_back_arrow.png",
            width: 18, height: 18),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context,true);
        },
      ),
      title: const Text(
        "My Profile",
        style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
        textAlign: TextAlign.center,
      ),
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
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(MAIN_URL + updateProfileForPriest);

        Map<String, String> jsonBody = {
          "id": sessionManager.getUserId().toString(),
          "first_name": firstNameController.value.text,
          "last_name": lastNameController.value.text,
          "email": emailController.value.text,
          "mobile": numberController.value.text,
          "country": countryController.value.text,
          "state": stateController.value.text,
          "city": cityController.value.text,
          "address": addressController.value.text,
          "birthdate":universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd",bdyController.value.text),
          "birthplace":"",
          "gender":"1",
          "qualification":"",
          "experiance":"",
          "qualification_other":"",
          "experience_other":"",
          "pathshala":"",
          "gurukul":"",
          "profile_pic_name":""
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommonResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {

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
          "state":stateId,
          "city":cityId,
          "address":addressController.value.text,
          "birthdate": universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", bdyController.value.text),
          "birthplace":addressController.value.text,
          "profile_pic_name":profilepicName
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommonResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
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

  void _getUserProfileDetails() async {
    setState(() {
      _isLoading = true;
    });
    if (sessionManager.getIsPujrai() ?? false)
      {
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
        var dataResponse = VerifyOtpResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1)
          {
            var getSet = dataResponse.profile;
            firstNameController.text = getSet?.firstName.toString() ?? "";
            lastNameController.text = getSet?.lastName.toString() ?? "";
            numberController.text = getSet?.mobile.toString() ?? "";
            emailController.text = getSet?.email.toString() ?? "";
            bdyController.text = universalDateConverter( "yyyy-MM-dd","dd MMM,yyyy", getSet?.birthdate.toString() ?? "");
            addressController.text = getSet?.address.toString() ?? "";
            countryController.text = getSet?.countryName ?? "";
            stateController.text = getSet?.stateName ?? "";
            cityController.text = getSet?.cityName ?? "";
            profilePic = getSet?.profilePic ?? "";
            countryId = getSet?.country ?? "";
            stateId = getSet?.state ?? "";
            cityId = getSet?.city ?? "";
            profilepicName = getSet?.profilePicName??"";

          setState(() {
            _isLoading = false;
          });
        }
        else
          {
          setState(() {
            _isLoading = false;
          });
          showToast(dataResponse.message, context);
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
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;

        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = VerifyOtpResponseModel.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1)
        {
          var getSet = dataResponse.profile!;
          firstNameController.text = getSet.firstName.toString() ?? "";
          lastNameController.text = getSet.lastName.toString() ?? "";
          numberController.text = getSet.mobile.toString() ?? "";
          emailController.text = getSet.email.toString() ?? "";
          bdyController.text = universalDateConverter("yyyy-MM-dd","dd MMM,yyyy",getSet.birthdate.toString() ?? "");
          addressController.text = getSet.address.toString() ?? "";
          countryController.text = getSet.countryName.toString() ?? "";
          stateController.text = getSet.stateName.toString() ?? "";
          cityController.text = getSet.cityName.toString() ?? "";
          profilePic = getSet.profilePic ?? "";
          countryId = getSet.country ?? "";
          stateId = getSet.state ?? "";
          cityId = getSet.city ?? "";
          profilepicName = getSet.profilePicName ?? "";

          var getSetData = Profile();
          getSetData.id = getSet.id;
          getSetData.mobile = getSet.mobile;
          getSetData.profilePic = getSet.profilePic;
          getSetData.city = getSet.cityName;
          getSetData.state = getSet.stateName;
          getSetData.country = getSet.countryName;
          getSetData.countryId = getSet.countryId;
          getSetData.stateId = getSet.stateId;
          getSetData.cityId = getSet.stateId;
          getSetData.email = getSet.email;
          getSet.firstName = getSet.firstName;
          getSetData.lastName = getSet.lastName;
          getSetData.profilePicName= getSet.profilePicName;

          await sessionManager.createLoginSession(getSet);

          setState(() {
            _isLoading = false;
          });
        }
        else
        {
          setState(() {
            _isLoading = false;
          });
          showSnackBar(dataResponse.message, context);
        }
      }
  }

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog() {
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
                            setState((){
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
      dial_code = data[i]['dial_code'] != null ? data[i]['dial_code'] : "";
      listCountryCode.add(CountryListResponseModel(name: name, dialCode: dial_code, code: code));
    }
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
                if (value != null && value != selectedDate) {
                  setState(()
                  {
                    String formattedDate = DateFormat('dd MMM,yyyy').format(value);
                    controller.text = formattedDate;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 1900,
              maximumYear: 2022,
            ),
          );
        }
    );
  }

}
