

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

class PrayerBottomSheet extends StatefulWidget {

  const PrayerBottomSheet( {super.key});
  @override
  State<PrayerBottomSheet> createState() => _PrayerBottomSheetState();
}

class _PrayerBottomSheetState extends State<PrayerBottomSheet> {
  TextEditingController prayerFNameController = TextEditingController();
  TextEditingController prayerLNameController = TextEditingController();
  TextEditingController prayerDOBController = TextEditingController();
  TextEditingController prayerEmailController = TextEditingController();
  TextEditingController PrayerForController = TextEditingController();
  TextEditingController prayerNotesController = TextEditingController();
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
    prayerFNameController.text= sessionManager.getName().toString();
    prayerLNameController.text= sessionManager.getLastName().toString();
    prayerEmailController.text= sessionManager.getEmail().toString();
    print(sessionManager.getDob().toString());
    prayerDOBController.text= universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", sessionManager.getDob().toString());
    _callListPrayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child:SingleChildScrollView(
        child: Wrap(
            children: [
              StatefulBuilder(
                  builder: (context,setState){
                    return Wrap(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: bottomSheetBg,
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
                              :Container(
                            margin: const EdgeInsets.only(left: 14,right: 14),
                            child: Column(
                              children: [
                                Container(
                                    width: 50,
                                    margin: const EdgeInsets.only(top: 12),
                                    child: const Divider(
                                      height: 2,
                                      thickness: 2,
                                      color: bottomSheetline,
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top:20,bottom: 20),
                                  child: const Text(
                                    "Request a Prayer",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: darkbrown, fontSize: 18),
                                  ),
                                ),

                                Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: prayerFNameController,
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
                                        labelText: 'First name',
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
                            ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      onTap: (){
                                      },
                                      controller: prayerLNameController,
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
                                        labelText: 'Last name',
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
                            ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      onTap: () async {
                                        _setDatePicker(prayerDOBController);
                                      },
                                      readOnly: true,
                                      controller: prayerDOBController,
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
                                        labelText: 'Date of Birth',
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue),
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
                                      color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                      fillColor: white_blue,
                                      border: InputBorder.none,
                                      hintText: 'Date of Birth',
                                      hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
                            ),  */


                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      controller: prayerEmailController,
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
                                        labelText: 'Email',
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
                            ), */

                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      onTap: (){
                                        _openPrayerTypeBottomSheet(setState);
                                      },
                                      readOnly: true,
                                      controller: PrayerForController,
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
                                        labelText: 'Prayer For',
                                        labelStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /* Container(
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: white_blue),
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 14,right: 10,top: 4,bottom: 4),
                                child: TextField(
                                  controller: PrayerForController,
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
                            ), */

                                Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      minLines: 4,
                                      maxLines: 4,
                                      controller: prayerNotesController,
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
                                        counterText: "",
                                        hintText: 'Leave Your Detail',
                                        hintStyle: const TextStyle(color: text_new),                                     ),
                                    )
                                ),

                                /*  Container(
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
                            ), */

                                Container(height: 22,),
                                TextButton(
                                  onPressed: (){
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
                                    else if (PrayerForController.value.text.isEmpty)
                                    {
                                      showToast("Please enter prayer type", context);
                                    }
                                    else
                                    {
                                      _confirmPrayerRequest();
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
                                /*  InkWell(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  margin: const EdgeInsets.only(top: 10,bottom: 30),
                                  padding: const EdgeInsets.only(left: 14,right: 14),
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
                                else if (PrayerForController.value.text.isEmpty)
                                  {
                                    showToast("Please enter prayer type", context);
                                  }
                                else
                                  {
                                    _confirmPrayerRequest();
                                  }
                              },
                            ) */
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ]),
      ),
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
                                  return InkWell(
                                    child: Container(
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
                                                              toDisplayCase(_prayerList[i].prayer.toString()),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  color: title),
                                                              textAlign: TextAlign.start),
                                                        ),
                                                        onTap: (){
                                                          prayerID = _prayerList[i].prayerId.toString();
                                                          PrayerForController.text = toDisplayCase(_prayerList[i].prayer.toString());
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
                                    ),
                                    onTap: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(_bookingList[i].bookingId.toString())));
                                    },
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

  void _confirmPrayerRequest() {
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                      child: Text(PrayerForController.value.text,
                                          style:const TextStyle(fontWeight: FontWeight.w700,color: text_dark,fontSize: 14)),
                                    )
                                  ],
                                ),
                                Visibility(
                                    visible: prayerNotesController.value.text.isNotEmpty,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            "Notes",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: text_light),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            prayerNotesController.value.text,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: title,
                                                fontSize: 14),textAlign: TextAlign.start,),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20,bottom: 20,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 12),
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
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  child: GestureDetector(
                                    onTap: (){
                                      _savePrayerRequest();
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
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
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

  _savePrayerRequest() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + savePrayerRequest);

    Map<String, String> jsonBody = {
      'user_id' : sessionManager.getUserId().toString(),
      'name' : prayerFNameController.value.text,
      'surname' : prayerLNameController.value.text,
      'date_of_birth' : universalDateConverter("MMMM dd, yyyy", "dd-MM-yyyy", prayerDOBController.value.text),
      'email' : prayerEmailController.value.text,
      'prayer_id' : prayerID,
      'notes' : prayerNotesController.value.text,
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
    }
  }

  void afterMethod() {
    Navigator.pop(context, true);
  }


}

