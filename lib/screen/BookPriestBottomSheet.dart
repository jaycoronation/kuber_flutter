

import 'dart:async';
import 'dart:convert';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/PrayerListResponseModel.dart';
import '../model/PujaListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';
import 'PujaListScreen.dart';

class BookPriestBottomSheet extends StatefulWidget {

  const BookPriestBottomSheet( {super.key});
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
  String puja_items_pdf = "";
  String pujaId = "";
  String _currentAddress = "";
  String dateTimeForShow = "";
  String dateTimeForPass = "";
  bool isWantGoods = true;
  bool isPickupPriest = true;
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
    return Wrap(
      children: [
     StatefulBuilder(
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
           child:  _isLoading
               ? const Expanded(child: LoadingWidget())
               : SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child:Padding(
               padding: EdgeInsets.only(
                   bottom: MediaQuery.of(context).viewInsets.bottom),
               child: Padding(
                 padding: const EdgeInsets.only(left: 14.0,right: 14),
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
                                 puja_items_pdf = value.pujaItemsPdf.toString();
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
                           behavior: HitTestBehavior.opaque,
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
                           behavior: HitTestBehavior.opaque,
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
                       child: GestureDetector(
                         onTap: () async {
                           if (puja_items_pdf.isEmpty)
                             {
                               showToast('Please enter puja name', context);
                             }
                          else if(await canLaunchUrl(Uri.parse(puja_items_pdf)))
                              {
                                launchUrl(Uri.parse(puja_items_pdf),mode: LaunchMode.externalApplication);
                              }
                         },
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
           ),
         );
       },
     ),
        ]);
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
  
  void _bookPristValidation() {
    if(sessionManager.checkIsLoggedIn()??false)
    {
      if(addressController.text.isEmpty)
      {
        showToast("Please  select pooja address", context);
        return;
      }
    }
    else
    {
      if(addressController.text.toString() == "Select Address")
      {
        showToast("Please select pooja ", context);
        return ;
      }
    }

    if(pujaId.isEmpty)
    {
      showToast("Please select pooja",context);
      return;
    }
    if(selectPujaController.text.isEmpty)
    {
      showToast("Please select pooja",context);
      return;
    }

    if(leaveDetailController.text.isEmpty)
    {
      if(selectedDate.toString()==("Pick Date"))
      {
        showToast("Select date for pooja ",context);
        return;
      }
      if(selectedTime.toString()==("Pick Time"))
      {
        showToast("Select time for pooja ",context);
        return;
      }
    }
    _reviewBookingDialog();
  }
  
  void _reviewBookingDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder: (context,setState){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.88,
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
                            )
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Review Priest Booking",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: title, fontSize: 18),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 18, bottom: 10),
                          child: const Text(
                            "User Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: black,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 4, right: 4, top: 6, bottom: 6),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: white_blue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                                child: Text(
                                  sessionManager.getName().toString() + sessionManager.getLastName().toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4, bottom: 4),
                                child: Text(
                                  sessionManager.getEmail().toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 4),
                                child: Text(
                                  sessionManager.getPhone().toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 12, left: 20, right: 18, bottom: 10),
                          child: const Text(
                            "Puja Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: black,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 6),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: white_blue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4, bottom: 4),
                                child:  Text(
                                  selectPujaController.value.text.toString()  ,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4, bottom: 4),
                                child:  Text(
                                  pujaDescription,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                          const EdgeInsets.only(top: 12, left: 20, right: 18, bottom: 10),
                          child:  const Text(
                            "Puja Date & Time:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: black,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, top: 6, bottom: 6),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: white_blue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4, bottom: 4),
                                child:  Text(
                                  dateTimeForShow,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                          const EdgeInsets.only(top: 12, left: 20, right: 18, bottom: 10),
                          child:  const Text(
                            "Address Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: black,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 4, right: 4, top: 6, bottom: 6),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: white_blue
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 4, bottom: 4),
                                child: Text(
                                  addressController.value.text ,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: title),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin:
                            const EdgeInsets.only(top: 12, left: 20, right: 18, bottom: 20),
                            child:  const Text(
                              "Pujari Near You:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Visibility(
                            visible:false,
                            child: ListView.builder( shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: _prayerList.length,
                                itemBuilder: (BuildContext context, int i){
                                  return Container(child:const Text(""));
                                }
                            )
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 18, right: 10, bottom: 12,top:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Will you pick up priest? : ",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              Text(
                                isPickupPriest ? "Yes" : "No",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: title,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 18, right: 10, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Do You Want Puja Goods from Kuber? :",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              Text(isWantGoods ? "Yes" : "No",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: title,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  padding: const EdgeInsets.only(left: 14,right: 14),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: light_yellow,
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Text("Edit",
                                        style: getTextStyle(
                                            fontSize: 14,
                                            color: title,
                                            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  bookPujaRequest();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  padding: const EdgeInsets.only(left: 14,right: 14),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: light_yellow,
                                    elevation: 10,
                                    child: const Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text("Submit",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: title,
                                            fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
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
                );
              }
          );
        }
    );
  }

  bookPujaRequest() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + bookPuja);
/*
    @Field("user_id") user_id: String,
    @Field("puja_id") puja_id: String,
    @Field("booking_date") booking_date: String,
    @Field("booking_address") booking_address: String,
    @Field("auspicious_description") auspicious_description: String,
    @Field("pickup_by_user") pickup_by_user: String,
    @Field("puja_goods_provide_by_user") puja_goods_provide_by_user: String,*/

    Map<String, String> jsonBody = {
      'user_id' : sessionManager.getUserId().toString(),
      'email' : sessionManager.getEmail().toString(),
      'puja_id' : pujaId,
      'booking_date' : dateTimeForPass,
      'booking_address' : addressController.text,
      'auspicious_description' : leaveDetailController.text,
      'pickup_by_user' : isPickupPriest ? "1" : "0",
      'puja_goods_provide_by_user' : isWantGoods ? "1" : "0",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      Navigator.pop(context, true);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
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


}

