import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/DonateResponseModel.dart';
import '../utils/app_utils.dart';

class BookPriestBottomSheet extends StatefulWidget {
  const BookPriestBottomSheet({super.key});
  @override
  State<BookPriestBottomSheet> createState() => _BookPriestBottomSheetState();
}

class _BookPriestBottomSheetState extends State<BookPriestBottomSheet> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController selectPujaController = TextEditingController();
  TextEditingController leaveDetailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();



  Widget buildStageChip(DonateResponseModel getSet, StateSetter setStateInner) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: getSet.isSelected ?? false
            ? BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(32)
        )
            : BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(width: 0.7,color: Colors.grey)
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.only(top: 6),
        child: Text(
          getSet.price.toString(),
          style: TextStyle(fontWeight: getSet!.isSelected ?? false ? FontWeight.w500 : FontWeight.w400, color: getSet?.isSelected  ?? false ? white : black, fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child:  Wrap(
          children: [
               Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.88,
                      decoration: const BoxDecoration(
                        color: bottomSheetBg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          topRight: Radius.circular(22.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:Padding(
                          padding: const EdgeInsets.only(left:14,right:14),
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
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "Book a Priest",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: darkbrown, fontSize: 22),
                                ),
                              ),
                              Container(height: 18,),

                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 18),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Address",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: txtGrey,
                                            fontSize: 16),
                                      )
                                  ),
                                  Container(height: 14,),
                                  TextField(
                                    onTap: (){
                                      placesDialog(addressController,setState);
                                    },
                                    controller: addressController,
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
                                      hintText: 'Select Address',
                                    ),
                                  ),
                                ],
                              ),

                              Container(height: 22,),
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 18),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Puja Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: txtGrey,
                                            fontSize: 16),
                                      )
                                  ),
                                  Container(height: 14,),
                                  TextField(
                                    onTap: () async {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PujaListScreen())) as PujaList;
                                      print(value);
                                      if (value.pujaId.toString().isNotEmpty)
                                      {
                                        print(value.pujaName);
                                        setState((){
                                          selectPujaController.text = value.pujaName.toString();
                                          pujaDescription = value.pujaDescription.toString();
                                          pujaId = value.pujaId.toString();
                                        });
                                      }
                                    },
                                    controller: selectPujaController,
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
                                      hintText: 'Select Puja',
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset("assets/images/ic_form_dropdown_arrow.png",height: 14,
                                          width: 14,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /* Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                    child: const Text(
                                      "Yajman's Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: text_new,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 14,),
                                    child: TextField(
                                      controller: firstNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      minLines: 1,
                                      maxLines: 1,
                                      style: const TextStyle(color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                          fillColor: white_blue,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                          hintText: 'First name',
                                          hintStyle: const TextStyle(
                                              color: text_dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10,),
                                    child: TextField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                          fillColor: white_blue,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                          hintText: 'Last name',
                                          hintStyle: const TextStyle(
                                              color: text_dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: TextField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration:  InputDecoration(
                                          fillColor: white_blue,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                          hintText: 'Email',
                                          hintStyle: const TextStyle(
                                              color: text_dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(left: 18, right: 18),
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
                                          child: Text(countryCode,
                                              style: const TextStyle(
                                                  color: text_dark,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)
                                          ),
                                          onTap: (){
                                            print("is DOne");
                                            countryDialog(setState);
                                          },
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10,right:10),
                                          height: 20,
                                          width: 1,
                                          color: text_light,
                                        ),
                                        Flexible(
                                          child: TextField(
                                              controller: mobileNumberController,
                                              keyboardType: TextInputType.number,
                                              cursorColor: text_dark,
                                              maxLength: 10,
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
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                    child: const Text(
                                      "Puja Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: text_new,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: TextField(
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PujaListScreen())) as PujaList;
                                        print(value);
                                        if (value.pujaId.toString().isNotEmpty)
                                        {
                                          print(value.pujaName);
                                          setState((){
                                            selectPujaController.text = value.pujaName.toString();
                                            pujaDescription = value.pujaDescription.toString();
                                            pujaId = value.pujaId.toString();
                                          });
                                        }
                                      },
                                      controller: selectPujaController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: title,
                                      style: const TextStyle(
                                          color: title, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                          fillColor: white_blue,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                              borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                          hintText: 'Select Puja',
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Image.asset("assets/images/ic_right.png",height: 14,
                                              width: 14,),
                                          ),
                                          hintStyle: const TextStyle(
                                              color: text_dark,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ), */
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                const EdgeInsets.only(top: 20, bottom: 10),
                                child: const Text(
                                  "Available Date & Time",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: text_new,
                                      fontSize: 16),
                                ),
                              ),
                              Container(height: 14,),
                              Padding(
                                padding: const EdgeInsets.only(left: 22.0, right: 22),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        _setPickDate(pickDateController,setState);
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/ic_calender.png",
                                            height: 22,
                                            width: 22,
                                          ),
                                          Container(width: 12,),
                                          const Text("Pick Date", style: TextStyle( fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: black),),
                                          Container(width: 24,),
                                          Image.asset(
                                            "assets/images/ic_form_dropdown_arrow.png",
                                            height: 18,
                                            width: 18,
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(width: 35,),
                                    GestureDetector(
                                      onTap: () async {
                                        _setTimePicker(pickTimeController,setState);
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/ic_time.png",
                                            height: 22,
                                            width: 22,
                                          ),
                                          Container(width: 12,),
                                          const Text("Pick Time", style: TextStyle( fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: black),),
                                          Container(width: 24,),
                                          Image.asset(
                                            "assets/images/ic_form_dropdown_arrow.png",
                                            height: 18,
                                            width: 18,
                                          ),
                                        ],
                                      ),
                                    ),

                                    /* Expanded(
                                          child: TextField(
                                            onTap: () async {
                                              _setPickDate(pickDateController);
                                            },
                                            controller: pickDateController,
                                            keyboardType: TextInputType.name,
                                            readOnly: true,
                                            decoration:  InputDecoration(
                                              contentPadding:const EdgeInsets.only(top:12),
                                              border: InputBorder.none,
                                              fillColor: bottomSheetBg,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_calender.png",
                                                  height: 14,
                                                  width: 14,
                                                ),
                                              ),

                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_form_dropdown_arrow.png",
                                                  height: 2,
                                                  width: 2,
                                                ),
                                              ),

                                              filled: true,
                                              labelText: "Pick Date",
                                              labelStyle: getTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: black
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(width: 12,),
                                        Expanded(
                                          child: TextField(
                                            onTap: () async {
                                              _setTimePicker(pickTimeController);
                                            },
                                            controller: pickTimeController,
                                            cursorColor: text_dark,
                                            readOnly: true,
                                            decoration:  InputDecoration(
                                              fillColor: bottomSheetBg,
                                              border: InputBorder.none,
                                              prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(14),
                                                  child:Image.asset("assets/images/ic_time.png",height: 14,
                                                    width: 14,)
                                              ),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_form_dropdown_arrow.png",
                                                  height: 2,
                                                  width: 2,
                                                ),
                                              ),

                                              filled: true,
                                              hintText: "Pick Time",
                                              hintStyle: getTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: black
                                              ),
                                            ),
                                          ),
                                        ),*/
                                  ],
                                ),
                              ),

                              Container(height: 18,),
                              Row(
                                children: [
                                  Flexible(
                                    child: Visibility(
                                      visible: selectedDate.isNotEmpty,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(28),
                                          color: const Color(0xffe8e4c7),

                                        ),
                                        margin: const EdgeInsets.only(right: 8, left: 2),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:6.0, bottom: 6),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(selectedDate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: darkbrown),),
                                              const Image(image: AssetImage("assets/images/ic_right_aerrow.png"), width: 20, height: 20,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 18,),
                                  Flexible(
                                    child: Visibility(
                                      visible: selectedTime != "Pick Time",
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8, left: 2),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(28),
                                          color: const Color(0xffe8e4c7),

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top:6.0, bottom: 6, left: 8,right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(selectedTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: darkbrown),),
                                              const Image(image: AssetImage("assets/images/ic_right_aerrow.png"), width: 20, height: 20,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              /* Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: selectedDate.isNotEmpty,
                                        child: Expanded(
                                          child: TextField(
                                            onTap: () async {
                                              _setPickDate(pickDateController);
                                            },
                                            controller: pickDateController,
                                            keyboardType: TextInputType.name,
                                            readOnly: true,
                                            decoration:  InputDecoration(
                                              contentPadding:const EdgeInsets.only(top:12),
                                              border: InputBorder.none,
                                              fillColor: bottomSheetBg,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_calender.png",
                                                  height: 14,
                                                  width: 14,
                                                ),
                                              ),

                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_form_dropdown_arrow.png",
                                                  height: 2,
                                                  width: 2,
                                                ),
                                              ),

                                              filled: true,
                                              hintText: "Pick Date",
                                              hintStyle: getTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(width: 12,),
                                      Visibility(
                                        visible: selectedTime.isNotEmpty,
                                        child: Expanded(
                                          child: TextField(
                                            onTap: () async {
                                              _setTimePicker(pickTimeController);
                                            },
                                            controller: pickTimeController,
                                            cursorColor: text_dark,
                                            readOnly: true,
                                            decoration:  InputDecoration(
                                              fillColor: bottomSheetBg,
                                              border: InputBorder.none,
                                              prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(14),
                                                  child:Image.asset("assets/images/ic_time.png",height: 14,
                                                    width: 14,)
                                              ),
                                              suffixIcon: Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Image.asset(
                                                  "assets/images/ic_form_dropdown_arrow.png",
                                                  height: 2,
                                                  width: 2,
                                                ),
                                              ),

                                              filled: true,
                                              hintText: "Pick Time",
                                              hintStyle: getTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), */

                              Container(
                                margin: const EdgeInsets.only(left: 14,right: 14,top: 14,bottom: 14),
                                child: Row(
                                  children: [
                                    const Flexible(
                                      flex: 1,
                                      child: Divider(
                                        color: text_light,
                                        height: 0.5,
                                        thickness: 0.5,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 4, right: 4),
                                      child: const Text(
                                        "OR",
                                        style: TextStyle(
                                            color: text_light,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    const Flexible(
                                      flex: 1,
                                      child: Divider(
                                        color: text_light,
                                        height: 0.5,
                                        thickness: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Ask for Auspicious date",
                                  style: getTextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: text_new,
                                      fontSize: 16),
                                ),
                              ),
                              Container(height: 14,),
                              TextField(
                                controller: leaveDetailController,
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
                                  hintText: 'Leave Your Detail',
                                ),
                              ),

                              // Container(
                              //   margin: const EdgeInsets.only(top: 10, ),
                              //   child:  TextField(
                              //     controller: leaveDetailController,
                              //     minLines: 4,
                              //     maxLines: 4,
                              //     keyboardType: TextInputType.text,
                              //     cursorColor: title,
                              //     style:   const TextStyle(
                              //         color: title, fontSize: 14, fontWeight: FontWeight.w900),
                              //     decoration: InputDecoration(
                              //         fillColor: white_blue,
                              //         filled: true,
                              //         border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(16.0),
                              //             borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                              //         ),
                              //         contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                              //         hintText: 'Leave Your Detail',
                              //         hintStyle: const TextStyle(
                              //             color: text_dark,
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold)),
                              //   ),
                              // ),

                              Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text("Our office will contact you",
                                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: text_light),),
                              ),
                              /* Container(
                                    alignment: Alignment.topLeft,
                                    margin: const EdgeInsets.only(top: 16,bottom: 14),
                                    child: const Text("Address",style: TextStyle(fontSize: 14,color: brown,fontWeight: FontWeight.w600),),
                                  ),
                                  TextField(
                                    minLines: 2,
                                    maxLines: 2,
                                    controller: addressController,
                                    keyboardType: TextInputType.text,
                                    cursorColor: title,
                                    readOnly: true,
                                    onTap: (){
                                      placesDialog(addressController,setState);
                                    },
                                    style:  const TextStyle(
                                        color: title, fontSize: 14, fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                        fillColor: white_blue,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                        hintText: 'Add Address',
                                        hintStyle: const TextStyle(
                                            color: text_dark,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900)),
                                  ), */
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 14,bottom: 14),
                                child: const Text("Will you pick up priest?",style: TextStyle(fontWeight: FontWeight.w400,color: text_new,fontSize: 16),),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPickupPriest = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(top: 8, right: 5),
                                            child: isPickupPriest ?
                                            const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                            const Image(image: AssetImage("assets/images/ic_radio_unselected.png"),  width: 20, height: 20, color:title,)
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(top: 8),
                                          child: const Text("Yes", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPickupPriest = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(top: 8, right: 5,left: 16),
                                            child: !isPickupPriest ?
                                            const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                            const Image(image: AssetImage("assets/images/ic_radio_unselected.png"), width: 20, height: 20, color: title)
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(top: 8,),
                                          child: const Text("No", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 18,bottom: 14),
                                child: const Text("Do you wants Puja Goods from Kuber?",style: TextStyle(fontWeight: FontWeight.w400,color: brown,fontSize: 16),),
                              ),


                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isWantGoods = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(top: 8, right: 5),
                                            child:isWantGoods?
                                            const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                            const Image(image: AssetImage("assets/images/ic_radio_unselected.png"),  width: 20, height: 20, color:title,)
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(top: 8),
                                          child: const Text("Yes", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isWantGoods = false;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(top: 8, right: 5,left: 16),
                                            child: !isWantGoods ?
                                            const Image(image: AssetImage("assets/images/ic_radio_selected.png"), width: 20, height: 20, color: title) :
                                            const Image(image: AssetImage("assets/images/ic_radio_unselected.png"), width: 20, height: 20, color: title)
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(top: 8,),
                                          child: const Text("No", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: black),),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(height: 8,),
                              Visibility(
                                visible: isWantGoods == true ,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 10,bottom: 10),
                                  height: 60,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    color: const Color(0xffe8e4c7),
                                    // elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 240,
                                        child: Row(
                                          children: [
                                            const Image(image: AssetImage("assets/images/ic_doc.png"),width: 18,),
                                            Container(width: 8,),
                                            const Text("Download Puja Good List",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: text_new,
                                                  fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                            Container(width: 12,),
                                            const Image(image: AssetImage("assets/images/ic_down_form.png"),width: 14,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                  margin: const EdgeInsets.only(top: 16,right: 18,left: 14),
                                  child: const Divider(color: text_light,thickness: 1,height: 0.5,)),
                              // Row(
                              //   children: [
                              //     InkWell(
                              //       child: Padding(
                              //     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              //     child: Container(
                              //
                              //       alignment: Alignment.bottomRight,
                              //       margin: const EdgeInsets.only(top: 10,bottom: 20),
                              //       padding: const EdgeInsets.only(left: 14,right: 14),
                              //       height: 60,
                              //       child: Card(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(20.0),
                              //         ),
                              //         color: light_yellow,
                              //         elevation: 10,
                              //         child: const Padding(
                              //           padding: EdgeInsets.all(14.0),
                              //           child: Text("Next",
                              //             style: TextStyle(
                              //                 fontSize: 14,
                              //                 color: title,
                              //                 fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              //         ),
                              //       ),
                              //     ),
                              //       ),
                              //       onTap: ()
                              //       {
                              //     var dateTime = "${pickDateController.text} $selectedTime";
                              //
                              //     if (dateTime == "Pick Date Pick Time")
                              //     {
                              //       dateTimeForShow = leaveDetailController.text;
                              //     }
                              //     else
                              //     {
                              //       var dateForShow = "${universalDateConverter("MMMM dd, yyyy", "dd-MM-yyyy", selectedDate)} $selectedTime";
                              //       dateTimeForShow = dateTime;
                              //       dateTimeForPass = dateForShow;
                              //     }
                              //     _bookPristValidation();
                              //       },
                              //     ),
                              //
                              //   ],
                              // ),
                              Container(height: 18,),
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8, left: 2),
                                      child: TextButton(
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
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
                                              Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8, left: 2),
                                      child: TextButton(
                                        onPressed: ()
                                        {
                                          var dateTime = "${selectedDate} $selectedTime";
                                          print(dateTime);
                                          if (dateTime == " Pick Time")
                                          {
                                            if (leaveDetailController.value.text.isNotEmpty)
                                            {
                                              dateTimeForShow = leaveDetailController.value.text;
                                            }
                                            else
                                            {
                                              showToast("Please select date or leave details for us.", context);
                                              return;
                                            }
                                          }
                                          else
                                          {
                                            var dateForShow = "${universalDateConverter("MMM dd, yyyy", "dd-MM-yyyy", selectedDate)} $selectedTime";
                                            dateTimeForShow = dateTime;
                                            dateTimeForPass = dateForShow;
                                          }
                                          _bookPristValidation();
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
                                              Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Container(height: 22,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

}