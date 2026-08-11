import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/common_widget.dart';
import 'package:http/http.dart' as http;

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/PrayerListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
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

  late FlutterGooglePlacesSdk _places;

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

    print("API_KEY ==== $API_KEY");

    _places = FlutterGooglePlacesSdk(API_KEY);

    rashiEmailController.text= sessionManager.getEmail().toString();
    rashiDOBController.text= universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", sessionManager.getDob().toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
      ?  Wrap(
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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        hintStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                              child: isBoy
                                                  ? const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title)
                                                  : const Image(image: AssetImage("assets/images/ic_radio_unselected.png"),  width: 20, height: 20, color:title,)
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
                                              child: isGirl
                                                  ? const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title)
                                                  : const Image(image: AssetImage("assets/images/ic_radio_unselected.png"), width: 20, height: 20, color: title)
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
                                getCommonButton('Review Request', _isLoading,() {
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
                                }),
                                Visibility(
                                  visible: false,
                                  child: TextButton(
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
                                ),
                                Container(height: 22,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ])
        : Wrap(
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
                            padding: const EdgeInsets.only(left: 18.0, right: 18),
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

                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      readOnly: true,
                                      // onTap: () async {
                                      //   _setDatePicker(rashiDOBController);
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
                                            rashiDOBController.text = formattedDate;
                                          });
                                        }
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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

                                Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: TextField(
                                      readOnly: true,
                                      // onTap: () async {
                                      //   _setTimePicker(rashiTOBController,setState);
                                      // },
                                      onTap: () async {
                                        TimeOfDay? pickedTime =  await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if(pickedTime != null ){
                                          print(pickedTime.format(context));   //output 10:51 PM

                                          setState(() {
                                            selectedTime = pickedTime.format(context);
                                            rashiTOBController.text = pickedTime.format(context); //set the value of text field.
                                          });
                                          print(selectedTime);
                                        }else{
                                          print("Time is not selected");
                                        }
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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        labelStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        hintStyle: const TextStyle(color: text_new),
                                      ),
                                    )
                                ),

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
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0, bottom: 8),
                                          child: Text('Review Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: 22,),
                              ],
                            ),
                          ),

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

  Future<void> placesDialog(
      TextEditingController controller,
      StateSetter updateState,
      ) async {
    print("IS IN DIALOG");

    final searchController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        List<AutocompletePrediction> predictions = [];

        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              title: const Text("Select Place of Birth"),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Search place...",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) async {
                        if (value.trim().isEmpty) {
                          dialogSetState(() {
                            predictions = [];
                          });
                          return;
                        }

                        try {
                          final result = await _places.findAutocompletePredictions(
                            value,
                            countries: [],
                          );

                          dialogSetState(() {
                            predictions = result.predictions;
                          });
                        } catch (e) {
                          print("Places API error: $e");
                        }
                      },
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          final prediction = predictions[index];

                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(
                              prediction.fullText ?? "",
                            ),
                            onTap: () {
                              controller.text =
                                  prediction.fullText ?? "";

                              updateState(() {});

                              Navigator.pop(dialogContext);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    searchController.dispose();
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
                    )
                ),
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
                          )
                        ),
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
                          fontSize: 18
                        ),
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
                                        fontSize: 14
                                    )
                                  ),
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
                                          fontSize: 14
                                      )
                                  ),
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
                                          fontSize: 14
                                      )
                                  ),
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
                                        color: text_light
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiEmailController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14
                                      )
                                  ),
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
                                          fontSize: 14
                                      )
                                  ),
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
                                          color: text_light
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiPOBController.value.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14
                                      )
                                  ),
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
                                          color: text_light
                                      ),
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
                          Expanded(child: getCommonButton('Edit Request', false,() { Navigator.pop(context); })),
                          Container(width: 12,),
                          Expanded(child: getCommonButton('Submit Request', _isLoading,() { saveRashiRequestApi(""); }))
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
      'date_of_birth' : universalDateConverter("dd MMM,yyyy", "dd-MM-yyyy", rashiDOBController.value.text),
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

  void afterMethod() {
    Navigator.pop(context, true);
  }

  
}

