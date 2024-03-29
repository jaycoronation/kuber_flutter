import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/model/PrayerListResponseModel.dart';
import 'package:kuber/model/PrayerRequestListResponseModel.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/common_widget.dart';
import '../model/CountryListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
import '../widget/loading.dart';
import '../widget/no_data_new.dart';

class PrayerRequestScreen extends StatefulWidget {
  const PrayerRequestScreen({Key? key}) : super(key: key);

  @override
  State<PrayerRequestScreen> createState() => _PrayerRequestScreen();
}

class _PrayerRequestScreen extends State<PrayerRequestScreen> {
  bool _isLoading = false;
  bool _isNoDataVisible = false;
  final SessionManager _sessionManager = SessionManager();
  List<Requests> _listPrayers = [];

  TextEditingController prayerFNameController = TextEditingController();
  TextEditingController prayerLNameController = TextEditingController();
  TextEditingController prayerDOBController = TextEditingController();
  TextEditingController prayerEmailController = TextEditingController();
  TextEditingController pPrayerForController = TextEditingController();
  TextEditingController prayerNotesController = TextEditingController();
  TextEditingController prayerNumberController = TextEditingController();
  SessionManager sessionManager = SessionManager();

  List<Prayers> _prayerList = List<Prayers>.empty(growable: true);
  String prayerID = "";
  String selectedDate = "Pick Date";
  String selectedTime = "Pick Time";
  String selectdateOfBirth = "Date Of Birth";

  @override
  void initState() {
    prayerNumberController.text= sessionManager.getPhone().toString();
    prayerDOBController.text= sessionManager.getDob().toString();
    getCountryData();
    getPrayerListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? WillPopScope(
        child: Scaffold(
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
            centerTitle: true,
            title: getTitle('Prayer Request'),
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_prayer_request.png', titleMSG: 'No Prayer Request Found')
              : SingleChildScrollView(
                child: Column(
                  children:  [
                    Container(
                        margin: const EdgeInsets.only(left: 12,top: 8,right: 12),
                        child: Text("In your difficult time, illness, accidents, children exam time you may request prayer, for your loved one.",
                            style: getSecondaryTitleFontStyle())
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      itemCount: _listPrayers.length,
                      itemBuilder: (context, i) {
                        return Container(
                            margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              color:  prayer_light,
                              elevation: 2,
                              child: InkWell(
                                onTap: (){
                                  _openRequestPrayerBottomSheet(_listPrayers[i]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Requested prayer for ${_listPrayers[i].prayer}", style: const TextStyle(color: black,fontSize: 14, fontWeight: FontWeight.w900)),
                                      Container(height: 8,),
                                      Row(
                                        children: [
                                          const Expanded(child: Text(" Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                          const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                          Expanded(child: Text(_listPrayers[i].name, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(child: Text("Email", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                          const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                          Expanded(child: Text(_listPrayers[i].email, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(child: Text("Birth Date", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                          const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                          Expanded(child: Text(universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy",   _listPrayers[i].dateOfBirth), style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Note",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                                          Text(_listPrayers[i].notes,style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        );
                      },
                    )
                  ],
                ),
              ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    )
        :  WillPopScope(
        child: Scaffold(
          backgroundColor: bg_skin,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading:GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_prayer_request.png', titleMSG: 'No Prayer Request Found')
              : SingleChildScrollView(
            child: Column(
              children:  [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 12,right: 12),
                    child: Text("Prayer Request",style: getTitleFontStyle())
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.only(left: 12,top: 8,right: 12),
                      child: Text("In your difficult time, illness, accidents, children exam time you may request prayer, for your loved one.",
                          style: getSecondaryTitleFontStyle())
                  ),
                ),
                Container(height: 12,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _listPrayers.length,
                  itemBuilder: (context, i) {
                    return Container(
                        margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          color:  prayer_light,
                          elevation: 2,
                          child: InkWell(
                            onTap: (){
                              _openRequestPrayerBottomSheet(_listPrayers[i]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Requested prayer for ${_listPrayers[i].prayer}", style: const TextStyle(color: darkbrown,fontSize: 14, fontWeight: FontWeight.w900)),
                                  Container(height: 14,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text(" Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(_listPrayers[i].name, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Email", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(_listPrayers[i].email, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Row(
                                    children: [
                                      const Expanded(child: Text("Birth Date", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                      Expanded(child: const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),)),
                                      Expanded(child: Text(universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy",   _listPrayers[i].dateOfBirth), style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                    ],
                                  ),
                                  Container(height: 12,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Note",style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w600),),
                                      Container(height: 8,),
                                      Text(_listPrayers[i].notes,style: const TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    );
                  },
                )
              ],
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );

  }

  getPrayerListApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getPrayerRequestList);

    Map<String, String> jsonBody = {
      'user_id' : _sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PrayerRequestListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      _listPrayers = [];
      _listPrayers = dataResponse.requests;
      if (!kIsWeb)
        {
          _listPrayers = _listPrayers.reversed.toList();
        }

      if (_listPrayers.isNotEmpty)
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
        _isNoDataVisible = true;
      });
      showSnackBar(dataResponse.message, context);
    }
    _callListPrayer();
  }

  void _openRequestPrayerBottomSheet(Requests getSet) {

    prayerFNameController.text = getSet.name;
    prayerLNameController.text = getSet.surname;
    prayerEmailController.text = getSet.email;
    prayerNumberController.text =getSet.mobile;
    prayerDOBController.text = universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", getSet.dateOfBirth);
    pPrayerForController.text = getSet.prayer;
    prayerID = getSet.prayerId;
    prayerNotesController.text = getSet.notes;
    countryCode = getSet.countryCode;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder: (context,updateState){
                return Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 14,right: 14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      child: SingleChildScrollView(
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
                              margin: const EdgeInsets.only(top:20,bottom: 20),
                              child: const Text(
                                "Request a Prayer",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: title, fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: prayerFNameController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'First name',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: prayerLNameController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Last name',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
                            ),

                            ResponsiveWidget.isSmallScreen(context)
                            ? Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  readOnly: true,
                                  controller:prayerDOBController,
                                  cursorColor: text_dark,
                                  onTap: () async {
                                    _setDatePicker(prayerDOBController);
                                  },
                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600
                                  ),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      border: InputBorder.none,
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900
                                      )
                                  ),
                                ),
                              ),
                            )
                            : Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  readOnly: true,
                                  controller:prayerDOBController,
                                  cursorColor: text_dark,
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
                                        prayerDOBController.text = formattedDate;
                                      });
                                    }
                                  },

                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600
                                  ),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      border: InputBorder.none,
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900
                                      )
                                  ),
                                ),
                              ),
                            ),



                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: prayerEmailController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
                            ),
                            Container(height: 10,),
                            Container(
                              alignment: Alignment.center,
                              padding:
                              const EdgeInsets.only(left: 14, right: 10),
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
                                            fontSize: 14
                                        )
                                    ),
                                    onTap: () {
                                      countryDialog(updateState);
                                    },
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: prayerNumberController,
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
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none)),
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

                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue),
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: pPrayerForController,
                                  onTap: (){
                                    _openPrayerTypeBottomSheet(setState);
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  cursorColor: text_dark,
                                  style: const TextStyle(
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Prayer For',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white_blue),
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: prayerNotesController,
                                  minLines: 4,
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  cursorColor: title,
                                  style:  const TextStyle(
                                      color: title, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Leave Your Detail',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
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
                                  Padding(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: InkWell(
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
                                            child: Text("Review Request",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: title,
                                                  fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        if (prayerFNameController.value.text.isEmpty)
                                        {
                                          showToast("Please enter first name", context);
                                        }
                                        else if (prayerLNameController.value.text.isEmpty)
                                        {
                                          showToast("Please enter last name", context);
                                        }
                                        else if (prayerDOBController.value.text.isEmpty)
                                        {
                                          showToast("Please enter date of birth", context);
                                        }
                                        else if (prayerEmailController.value.text.isEmpty)
                                        {
                                          showToast("Please enter email", context);
                                        }
                                        else if (pPrayerForController.value.text.isEmpty)
                                        {
                                          showToast("Please enter prayer type", context);
                                        }
                                        else
                                        {
                                          _confirmPrayerRequest(getSet);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  void showDeleteDialog(Requests getSet) {
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
                    child: const Text("Delete Prayer Request", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to delete this request", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 15),textAlign: TextAlign.justify,),
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
                              Navigator.pop(context);
                              callDeletePrayerRequestAPI(getSet);
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
                                style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.w600),
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

  void _openPrayerTypeBottomSheet(StateSetter updateState){
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
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "Request a Prayer",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: title, fontSize: 22),
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: _prayerList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        padding: const EdgeInsets.all(4),
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: const EdgeInsets.only(top: 6, right: 6, left: 8),
                                                        child: Text(
                                                            toDisplayCase( _prayerList[i].prayer.toString()),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                color: title),
                                                            textAlign: TextAlign.start),
                                                      ),
                                                      onTap: (){
                                                        prayerID = _prayerList[i].prayerId.toString();
                                                        pPrayerForController.text = toDisplayCase(_prayerList[i].prayer.toString());
                                                        updateState((){});
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  void _confirmPrayerRequest(Requests getSet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            margin: const EdgeInsets.only(top: 20,bottom: 20),
                            child: const Text(
                              "Confirm Request a Prayer",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: title, fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 14, right: 10,top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: white_blue),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text("First Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(prayerFNameController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text("Last Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(prayerLNameController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text("Date of Birth",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(prayerDOBController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text("Email",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(prayerEmailController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Row(
                                  children:  [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text("Prayer For",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(pPrayerForController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Visibility(
                                  visible: false,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Notes",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: text_light),),
                                      Text(prayerNotesController.value.text, style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                      child: Text("Edit Request",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: title,
                                            fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    ),
                                  ),
                                ),
                                Container(width: 8,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                    _savePrayerRequest(getSet);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: light_yellow,
                                    elevation: 10,
                                    child: const Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text("Submit Request",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _setDatePickerWeb(TextEditingController controller){
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
                    String formattedDate = DateFormat('MMMM dd,yyyy').format(value);
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

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;


  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog(StateSetter updateState) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
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
                      "Select Country Code",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: title,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 14, right: 14),
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
                              updateState((){
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
          });
        });
  }

  List data = [];

  Future<void> getCountryData() async {
    var jsonText = await rootBundle.loadString('assets/countries.json');
    setState(() => data = json.decode(jsonText));
    var name = "";
    var code = "";
    var dial_code = "";
    for (var i = 0; i < data.length; i++) {
      name = data[i]['name'];
      code = data[i]['code'];
      dial_code = data[i]['dial_code'] != null ? data[i]['dial_code'] : "";
      listCountryCode.add(CountryListResponseModel(
          name: name, dialCode: dial_code, code: code));
    }
  }


  _savePrayerRequest(Requests getSet) async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + savePrayerRequest);

    Map<String, String> jsonBody = {
      'user_id' : _sessionManager.getUserId().toString(),
      'name' : prayerFNameController.value.text,
      'surname' : prayerLNameController.value.text,
      'date_of_birth' : universalDateConverter("dd MMM,yyyy", "dd-MM-yyyy", prayerDOBController.value.text),
      'email' : prayerEmailController.value.text,
      'mobile' : prayerNumberController.value.text,
      'prayer_id' : prayerID,
      'notes' : prayerNotesController.value.text,
      "country_code" : countryCode,
      'request_id': getSet.requestId.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      getPrayerListApi();
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  _callListPrayer() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getPrayerList);

    Map<String, String> jsonBody = {

    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var prayerResponse = PrayerListResponseModel.fromJson(user);

    if (statusCode == 200 && prayerResponse.success == 1) {
      if (prayerResponse.prayers != null) {
        _prayerList = prayerResponse.prayers!;
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(prayerResponse.message, context);
    }
  }

  void callDeletePrayerRequestAPI(Requests getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deletePrayerRequest);

    Map<String, String> jsonBody = {
      'request_id' : getSet.requestId.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var prayerResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && prayerResponse.success == 1) {
     getPrayerListApi();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

}