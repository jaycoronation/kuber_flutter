import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/AstrologyResponseModel.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/api_end_point.dart';
import '../model/AstrologyResponseModel.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
import '../widget/loading.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../widget/no_data_new.dart';

class AstrologyScreen extends StatefulWidget {
  const AstrologyScreen({Key? key}) : super(key: key);

  @override
  State<AstrologyScreen> createState() => _AstrologyScreen();
}

class _AstrologyScreen extends State<AstrologyScreen> {

  TextEditingController astroFnameController = TextEditingController();
  TextEditingController astroLnameController = TextEditingController();
  TextEditingController astroEmailController = TextEditingController();
  TextEditingController astroMobileNumberController = TextEditingController();
  TextEditingController astroBirthTimeController = TextEditingController();
  TextEditingController astroBirthPlaceController = TextEditingController();
  TextEditingController astroNotesController = TextEditingController();
  TextEditingController astroGirlBirthDateController = TextEditingController();
  bool _isLoading = false;
  bool _isNoDataVisible = false;
  SessionManager sessionManager = SessionManager();
  List<Astrology> _listAstrology = [];

  String selectedDate = "Pick Date";
  String selectdateOfBirth = "Date Of Birth";
  String selectedTime = "Pick Time";
  String astroId = " ";

  @override
  void initState() {
    getAstrologyApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ?  WillPopScope(
        child: Scaffold(
          backgroundColor: bg_skin,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading:IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ) ,
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_astrology_list.png', titleMSG: 'No Astrology Request Found')
              : Column(
            children:  [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 12,right: 12),
                  child: Text("Astrology",style: getTitleFontStyle())
              ),
              Container(
                  margin: const EdgeInsets.only(left: 12,top: 8,right: 12),
                  child: Text("Astrology is a Language. If you understand this language, The Sky Speaks to You.",
                      style: getSecondaryTitleFontStyle())
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _listAstrology.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          color: astro_light,
                          elevation: 2,
                          child: InkWell(
                            onTap: (){
                              _openAstrologyDialog(_listAstrology[i]);
                              astroId = _listAstrology[i].astrologyId;
                              print(_listAstrology.length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                      Expanded(child: Text("${_listAstrology[i].firstName} ${_listAstrology[i].lastName}", style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Date", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                      Expanded(child: Text(_listAstrology[i].birthDate, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Time", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                      Expanded(child: Text(_listAstrology[i].birthTime, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Place", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                      Expanded(child: Text(_listAstrology[i].address, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: _listAstrology[i].notes.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Note",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                                            Text(_listAstrology[i].notes,style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    );
                  },
                ),
              )
            ],
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    )
        : WillPopScope(
        child: Scaffold(
          backgroundColor: bg_skin,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading:IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ) ,
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_astrology_list.png', titleMSG: 'No Astrology Request Found')
              : Column(
            children:  [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 12,right: 12),
                  child: Text("Astrology",style: getTitleFontStyle())
              ),
              Container(
                  margin: const EdgeInsets.only(left: 12,top: 8,right: 12),
                  child: Text("Astrology is a Language. If you understand this language, The Sky Speaks to You.",
                      style: getSecondaryTitleFontStyle())
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _listAstrology.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          color: astro_light,
                          elevation: 2,
                          child: InkWell(
                            onTap: (){
                              _openAstrologyDialog(_listAstrology[i]);
                              astroId = _listAstrology[i].astrologyId;
                              print(_listAstrology.length);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text("${_listAstrology[i].firstName} ${_listAstrology[i].lastName}", style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Date", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(_listAstrology[i].birthDate, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Time", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(_listAstrology[i].birthTime, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Place", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(_listAstrology[i].address, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Visibility(
                                      visible: _listAstrology[i].notes.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Note",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                                            Container(height: 8,),
                                            Text(_listAstrology[i].notes,style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    );
                  },
                ),
              )
            ],
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );

  }

  _openAstrologyDialog(Astrology getSet) {

    astroFnameController.text = getSet.firstName;
    astroLnameController.text = getSet.lastName;
    astroEmailController.text = getSet.email;
    astroMobileNumberController.text = getSet.mobile;
    astroGirlBirthDateController.text = getSet.birthDate;
    astroBirthTimeController.text = getSet.birthTime;
    astroBirthPlaceController.text = getSet.address;
    astroNotesController.text = getSet.notes;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder:(context,setState)
        {
          return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  )),
              child:Column(
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
                      "Astrology",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: title,
                          fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child:Container(
                          margin: const EdgeInsets.only(left: 14,right:14,),
                          child: Column(
                              children:[
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top:14,bottom: 14),
                                    child: const Text("Basic Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:black),)),
                                TextField(
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
                                ),
                                Container(height: 10),
                                TextField(
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
                                ),
                                Container(height: 10),
                                TextField(
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
                                ),
                                Container(height: 10),
                                Container(
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
                                            style: TextStyle(
                                                color: text_dark,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)
                                        ),
                                        onTap: (){
                                          countryDialog(setState);
                                        },
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
                                ),
                                Container(height: 10),
                                TextField(
                                  onTap: () async {
                                    _setDatePicker(astroGirlBirthDateController);

                            /*        FocusScope.of(context).requestFocus(FocusNode());

                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                        builder: (BuildContext context, Widget? child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme: const ColorScheme.dark(
                                                primary: text_light,
                                                onPrimary: white,
                                                surface: text_light,
                                                onSurface: black,
                                              ),
                                              dialogBackgroundColor: white,
                                            ),
                                            child: child!,
                                          );
                                        });
                                    if (pickedDate != null) {

                                      String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                                      print(formattedDate);
                                      //you can implement different kind of Date Format here according to your requirement
                                      setState(() {
                                        astroGirlBirthDateController.text = formattedDate;
                                      });
                                    }*/
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
                                ),
                                Container(height: 10),
                                TextField(
                                  controller: astroBirthTimeController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  readOnly: true,
                                  onTap: () async {
                                    _setTimePicker(astroBirthTimeController);

                                   /* FocusScope.of(context).requestFocus(FocusNode());
                                    final TimeOfDay? picked_s = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (BuildContext context, Widget? child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme: const ColorScheme.dark(
                                                primary: white,
                                                onPrimary: white,
                                                surface: text_light,
                                                onSurface: black,
                                              ),
                                              dialogBackgroundColor: white,
                                            ),
                                            child: child!,
                                          );
                                        });

                                    if (picked_s != null && picked_s != TimeOfDay ) {
                                      setState(() {
                                        selectedTime = ("${picked_s.hour}:${picked_s.minute} ${picked_s.period.name}").toString();
                                        astroBirthTimeController.text = selectedTime;
                                      });
                                    }*/

                                  },
                                  style: const TextStyle(
                                      color: title,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    fillColor: white_blue,
                                    counterText: "",
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
                                ),
                                Container(height: 10),
                                TextField(
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
                                ),
                                Container(height: 10),
                                TextField(
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
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: text_light,
                                  endIndent: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            color: light_yellow,
                                            elevation: 10,
                                            child: const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text("Delete Request",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: title,
                                                    fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.pop(context);
                                          showDeleteDialog(getSet);
                                        },
                                      ),
                                      Container(width: 12,),
                                      InkWell(
                                        onTap: (){
                                          _validation(getSet);
                                        },
                                        child: Card(
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
                                      )
                                    ],
                                  ),
                                )
                              ]
                          ),
                        )
                    ),
                  )
                ],
              )
          );
        });
      },
    );
  }

  _validation(Astrology getSet){
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
      callAstrologySaveApi(getSet);
    }
  }

  callAstrologySaveApi(Astrology getSet) async {

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
      "astrology_id": getSet.astrologyId.toString(),
      "email": astroEmailController.value.text,
      "mobile": astroMobileNumberController.value.text,
      "notes": astroNotesController.value.text,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var astroResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && astroResponse.success == 1) {
      showSnackBar(astroResponse.message, context);
      getAstrologyApi();

      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(astroResponse.message, context);
    }
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        margin: const EdgeInsets.only(bottom: 10,left: 14,right: 14),
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

                              }
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
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: listCountryCode.length,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                  onTap: (){
                                    setState((){
                                      countryCode = listCountryCode[i].dialCode;
                                    });
                                    updateState((){});
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 14,left: 14,top: 6,bottom: 6),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(child: Text(listCountryCode[i].name.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w200,color: title), textAlign: TextAlign.start,)),
                                              Text(listCountryCode[i].dialCode.toString(),style: const TextStyle(fontWeight: FontWeight.w300,color: text_new,fontSize: 16),)
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

  getAstrologyApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getAstrologyList);

    Map<String, String> jsonBody = {
      'user_id' : sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AstrologyListResponseModel.fromJson(user);

    if (statusCode == 200) {
      _listAstrology = [];
      _listAstrology = dataResponse.astrology;
      _listAstrology.reversed.toList();

      if (_listAstrology.isNotEmpty)
      {
        _isNoDataVisible = false;
      }
      else
      {
        _isNoDataVisible = true;
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isNoDataVisible = false;
      });
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

  _setTimePicker(TextEditingController controller){
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedTime)
                  setState(()
                  {
                    selectedTime = ("${value.hour}:${value.minute}${value.timeZoneName}").toString();
                    selectedTime = DateFormat("h:mm a").format(value);
                    print(selectedTime);
                    controller.text =  DateFormat("h:mm a").format(value);
                  });
              },
              initialDateTime: DateTime.now(),
              use24hFormat: false,
            ),
          );
        }
    );
  }

  Future<void> showDeleteDialog(Astrology getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + astrodelete);

    Map<String, String> jsonBody = {
      'astrology_id' : getSet.astrologyId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var prayerResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && prayerResponse.success == 1) {
     getAstrologyApi();
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(prayerResponse.message, context);
    }
  }

}