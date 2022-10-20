import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kuber/model/RashiListResponseModel.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../utils/app_utils.dart';

class RashiScreen extends StatefulWidget {
  const RashiScreen({Key? key}) : super(key: key);

  @override
  State<RashiScreen> createState() => _RashiScreen();
}

class _RashiScreen extends State<RashiScreen> {
  bool _isLoading = false;
  bool _isNoDataVisible = false;
  bool _isBoy = false;
  bool _isGirl = false;
  final SessionManager _sessionManager = SessionManager();
  List<Requests> _listRashi = [];
  String selectedDate = "Pick Date";
  String selectedTime = "Pick Time";
  String selectdateOfBirth = "Date Of Birth";

  TextEditingController rashiMothersNameController = TextEditingController();
  TextEditingController rashiFathersNameController = TextEditingController();
  TextEditingController rashiEmailController = TextEditingController();
  TextEditingController rashiTOBController = TextEditingController();
  TextEditingController rashiPOBController = TextEditingController();
  TextEditingController rashiController = TextEditingController();
  TextEditingController rashiDOBController = TextEditingController();

  @override
  void initState() {
    getRashiListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: Text("No Rashi Request Found",style: TextStyle(color: text_dark,fontSize: 18,fontWeight: FontWeight.bold),))
                  ],
                )
              : SingleChildScrollView(
                child: Column(
                    children:  [
                      Container(alignment: Alignment.centerLeft,margin: const EdgeInsets.only(left: 12,right: 12),child: const Text("Rashi",style: TextStyle(color: black,fontWeight: FontWeight.w900,fontSize: 18),)),
                      Container(margin: const EdgeInsets.only(left: 12,right: 12),child: const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: black),)),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          itemCount: _listRashi.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  color: rashi_light,
                                  elevation: 2,
                                  child: InkWell(
                                    onTap: (){
                                      _openRashiCalculatorDialog(_listRashi[i]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Birth on ${universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", _listRashi[i].dateOfBirth)} at ${_listRashi[i].timeOfBirth}", style: const TextStyle(color: black,fontSize: 14, fontWeight: FontWeight.w900)),
                                          Container(height: 8,),
                                          Row(
                                            children: [
                                              const Expanded(child: Text("Mother's Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                              const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                              Expanded(child: Text(_listRashi[i].motherName, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(child: Text("Father's Name", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                              const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                              Expanded(child: Text(_listRashi[i].fatherName, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(child: Text("Birth Place", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                              const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                              Expanded(child: Text(_listRashi[i].placeOfBirth, style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(child: Text("Gender", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),) ),
                                              const Text(" : ", style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),),
                                              Expanded(child: Text(_listRashi[i].childGender == "1" ? "Girl" : "Boy", style: const TextStyle(color: text_dark,fontWeight: FontWeight.w400,fontSize: 14),) ),
                                            ],
                                          ),
                                          Visibility(
                                              visible: _listRashi[i].notes.isNotEmpty,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Note",style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                                                    Text(_listRashi[i].notes,style: const TextStyle(color: text_dark,fontSize: 14,fontWeight: FontWeight.w400),
                                                    ),
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

  void _openRashiCalculatorDialog(Requests getSet){
    rashiEmailController.text = getSet.email;
    rashiMothersNameController.text = getSet.motherName;
    rashiFathersNameController.text = getSet.fatherName;
    rashiTOBController.text = getSet.timeOfBirth;
    rashiPOBController.text = getSet.placeOfBirth;
    rashiController.text = getSet.notes;
    rashiDOBController.text = universalDateConverter("dd-MM-yyyy", "dd MMM,yyyy", getSet.dateOfBirth);
    _isBoy = getSet.childGender == "0";
    _isGirl = getSet.childGender == "1";

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
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
                            "Rashi Calculator",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, color: title, fontSize: 22),
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      controller: rashiMothersNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Mother's Name",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      controller: rashiFathersNameController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Father's Name",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      controller: rashiEmailController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Email",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      onTap: (){
                                        _setDatePicker(rashiDOBController);
                                      },
                                      controller: rashiDOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Date of Birth",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      onTap: (){
                                        _setTimePicker(rashiTOBController);
                                      },
                                      controller: rashiTOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Time of Birth",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      controller: rashiPOBController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Place of Birth",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 10, right: 18, left: 18),
                                    child: TextField(
                                      minLines: 4,
                                      maxLines: 4,
                                      controller: rashiController,
                                      keyboardType: TextInputType.text,
                                      cursorColor: text_dark,
                                      style: const TextStyle(
                                          color: text_dark, fontSize: 14, fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        fillColor: white_blue,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(width: 0,style: BorderStyle.none)
                                        ),
                                        filled: true,
                                        hintText: "Leave Your Detail",
                                        hintStyle: const TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(top:10,bottom:6,left: 18),
                                      child: const Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 16),)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isBoy = true;
                                            _isGirl = false;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(top: 4, right: 5,left: 22,bottom: 8),
                                                child: _isBoy ?
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
                                            _isGirl = true;
                                            _isBoy = false;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(top: 4, right: 5,bottom: 8,left:10),
                                                child: _isGirl ?
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
                                ],
                              ),
                            )
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
                                  reviewRashiDialog(getSet);
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
                      ],
                    )
                );
              });
        }) ;
  }

  void reviewRashiDialog(Requests getSet){
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
                            width: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 12),
                            child: const Divider(
                              height: 1.5,
                              thickness: 1.5,
                              color: Colors.grey,
                            )),
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
                            fontSize: 18),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color:sky_blue),
                        child: Column(
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
                                      rashiDOBController.value.text,
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
                                      rashiEmailController.value.text,
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
                                      rashiTOBController.value.text,
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
                                      "Place of Birth",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiPOBController.value.text,
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
                                      "Gender of Baby",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      _isBoy ? "Boy" : "Girl" ,
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
                                      "Notes",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: text_light),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      rashiController.value.text ,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: title,
                                          fontSize: 14)),
                                )
                              ],
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
                          Container(width: 8,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              saveRashiRequestApi(getSet);
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
                        ],
                      ),
                    )
                  ],
                ));
          });
        });
  }

  void saveRashiRequestApi(Requests getSet) async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

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
      'user_id' : _sessionManager.getUserId().toString(),
      'child_gender' : _isBoy ? "0" : "1" ,
      'email' : rashiEmailController.value.text,
      'notes' : rashiController.value.text,
      'request_id':getSet.requestId.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      getRashiListApi();

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

  getRashiListApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getRashiList);

    Map<String, String> jsonBody = {
      'user_id' : _sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = RashiListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      _listRashi = [];
      _listRashi = dataResponse.requests;
      _listRashi.reversed.toList();

      if (_listRashi.isNotEmpty)
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
    } else
    {
      setState(()
      {
        _isLoading = false;
        _isNoDataVisible = true;
      });
    }
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
                    child: const Text("Delete Rashi Request", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to delete this request?", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 15),textAlign: TextAlign.center,),
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
                              callDeleteRashiRequestAPI(getSet);
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

  void callDeleteRashiRequestAPI(Requests getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deleteRashiRequest);

    Map<String, String> jsonBody = {
      'request_id' : getSet.requestId.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var prayerResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && prayerResponse.success == 1) {
      getRashiListApi();
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(prayerResponse.message, context);
    }
  }

}