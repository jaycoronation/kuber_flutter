import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/MatchListResponseModel.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:google_maps_webservice/places.dart';
import '../constant/api_end_point.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../widget/no_data_new.dart';

class MatchMakingScreen extends StatefulWidget {
  const MatchMakingScreen({Key? key}) : super(key: key);

  @override
  State<MatchMakingScreen> createState() => _MatchMakingScreen();
}

class _MatchMakingScreen extends State<MatchMakingScreen> {
  TextEditingController matchFnameController = TextEditingController();
  TextEditingController matchLnameController = TextEditingController();
  TextEditingController matchEmailcontroller = TextEditingController();
  TextEditingController matchNumberController = TextEditingController();
  TextEditingController matchGirlFnameController = TextEditingController();
  TextEditingController matchGirlLNameController = TextEditingController();
  TextEditingController matchGirlBirthDateController = TextEditingController();
  TextEditingController matchGirlBirthTimeController = TextEditingController();
  TextEditingController matchGirlBirthPlaceController = TextEditingController();
  TextEditingController matchBoyFNameController = TextEditingController();
  TextEditingController matchBoyLNameController = TextEditingController();
  TextEditingController matchBoyBirthDateController = TextEditingController();
  TextEditingController matchBoyBirthTimeController = TextEditingController();
  TextEditingController matchBoyBirthPlaceController = TextEditingController();
  TextEditingController matchNoteController = TextEditingController();
  String selectedDate = "Pick Date";
  String selectdateOfBirth = "Date Of Birth";
  String selectedTime = "Pick Time";
  String matchId = "";
  bool _isLoading = false;
  bool _isNoDataVisible = false;
  SessionManager sessionManager = SessionManager();
  List<Matches> _listMatch = [];

  @override
  void initState() {
    getMatchListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: bg_skin,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
                  ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_match_making_list.png', titleMSG: 'No Match Making Found')
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 12, right: 12),
                              child: Text(
                                "Match Making",
                                style: getTitleFontStyle(),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 12, top: 8,right: 12),
                              child: Text(
                                "Matchmaking is the process of matching of two people birth chart, usually for the purpose of marriage",
                                style: getSecondaryTitleFontStyle(),
                              )),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            itemCount: _listMatch.length,
                            itemBuilder: (context, i) {
                              return Container(
                                  margin: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    color: match_light,
                                    elevation: 2,
                                    child: InkWell(
                                      onTap: () {
                                        _openMatchMakingDialog(_listMatch[i]);
                                        matchId = _listMatch[i].matchId;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Bride",
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].brideName +
                                                      " " +
                                                      _listMatch[i]
                                                          .brideSurname,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Date",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].brideBirthDate,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Time",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].brideBirthTime,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Place",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].brideAddress,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            const Text("Groom",
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].groomName +
                                                      " " +
                                                      _listMatch[i]
                                                          .groomSurname,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Date",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].groomBirthDate,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Time",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].groomBirthTime,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Birth Place",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                )),
                                                const Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  _listMatch[i].groomAddress,
                                                  style: const TextStyle(
                                                      color: text_dark,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],
                                            ),
                                            Visibility(
                                                visible: _listMatch[i]
                                                    .comments
                                                    .isNotEmpty,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Note",
                                                        style: TextStyle(
                                                            color: black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        _listMatch[i].comments,
                                                        style: const TextStyle(
                                                            color: text_dark,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        });
  }

  _openMatchMakingDialog(Matches getSet) {
    matchFnameController.text = getSet.firstName;
    matchLnameController.text = getSet.lastName;
    matchEmailcontroller.text = getSet.email;
    matchGirlFnameController.text = getSet.brideName;
    matchGirlLNameController.text = getSet.brideSurname;
    matchGirlBirthDateController.text = universalDateConverter(
        "dd-MM-yyyy", "dd MMM,yyyy", getSet.brideBirthDate);
    matchGirlBirthTimeController.text = getSet.brideBirthTime;
    matchGirlBirthPlaceController.text = getSet.brideAddress;

    matchBoyFNameController.text = getSet.groomName;
    matchBoyLNameController.text = getSet.groomSurname;
    matchBoyBirthDateController.text = universalDateConverter(
        "dd-MM-yyyy", "dd MMM,yyyy", getSet.groomBirthDate);
    matchBoyBirthPlaceController.text = getSet.groomAddress;
    matchBoyBirthTimeController.text = getSet.groomBirthTime;

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
                        "Match Making",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: title,
                            fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.only(left: 14, right: 14),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 14),
                                  child: const Text(
                                    "Yajman's details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: text_dark),
                                  )),
                              TextField(
                                controller: matchFnameController,
                                keyboardType: TextInputType.text,
                                cursorColor: text_dark,
                                style: const TextStyle(
                                    color: title,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  fillColor: white_blue,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                controller: matchLnameController,
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
                                controller: matchEmailcontroller,
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
                                          style: TextStyle(
                                              color: text_dark,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                      onTap: () {
                                        countryDialog(setState);
                                      },
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: matchNumberController,
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
                              Container(height: 10),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  alignment: Alignment.topLeft,
                                  child: const Text(
                                    "Girl's details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: text_dark),
                                  )),
                              TextField(
                                controller: matchGirlFnameController,
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
                                      borderRadius: BorderRadius.circular(12.0),
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
                                controller: matchGirlLNameController,
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
                                      borderRadius: BorderRadius.circular(12.0),
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
                                onTap: () async {
                                  _setDatePicker(matchGirlBirthDateController);

                                 /* FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
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
                                    String formattedDate =
                                        DateFormat('dd MMM,yyyy')
                                            .format(pickedDate);
                                    print(formattedDate);
                                    //you can implement different kind of Date Format here according to your requirement
                                    setState(() {
                                      matchGirlBirthDateController.text =
                                          formattedDate;
                                    });
                                  }*/
                                },
                                controller: matchGirlBirthDateController,
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
                                onTap: () async {
                                  _setTimePicker(matchGirlBirthTimeController);
                             /*     FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  final TimeOfDay? picked_s =
                                      await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme:
                                                    const ColorScheme.dark(
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
                                  if (picked_s != null &&
                                      picked_s != TimeOfDay) {
                                    setState(() {
                                      selectedTime =
                                          ("${picked_s.hour}:${picked_s.minute} ${picked_s.period.name}")
                                              .toString();
                                      matchGirlBirthTimeController.text =
                                          selectedTime;
                                    });
                                  }*/
                                },
                                controller: matchGirlBirthTimeController,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                  filled: true,
                                  hintText: "Birth time",
                                  hintStyle: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(height: 10),
                              TextField(
                                controller: matchGirlBirthPlaceController,
                                keyboardType: TextInputType.text,
                                cursorColor: text_dark,
                                readOnly: true,
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  placesDialog(
                                      matchGirlBirthPlaceController, setState);
                                },
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
                                  hintText: "Birth Place",
                                  hintStyle: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(height: 10),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 10, right: 14),
                                  child: const Text(
                                    "Boy's details",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: text_dark),
                                  )),
                              TextField(
                                controller: matchBoyFNameController,
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
                                      borderRadius: BorderRadius.circular(12.0),
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
                                controller: matchBoyLNameController,
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
                                      borderRadius: BorderRadius.circular(12.0),
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
                                onTap: () async {
                                  _setDatePicker(matchBoyBirthDateController);

                                 /* FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
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
                                    String formattedDate =
                                        DateFormat('dd MMM,yyyy')
                                            .format(pickedDate);
                                    print(formattedDate);
                                    //you can implement different kind of Date Format here according to your requirement
                                    setState(() {
                                      matchBoyBirthDateController.text =
                                          formattedDate;
                                    });
                                  }*/
                                },
                                controller: matchBoyBirthDateController,
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
                                onTap: () async {
                                  _setTimePicker(matchBoyBirthTimeController);
                                /*  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  final TimeOfDay? picked_s =
                                      await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme:
                                                    const ColorScheme.dark(
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
                                  if (picked_s != null &&
                                      picked_s != TimeOfDay) {
                                    setState(() {
                                      selectedTime =
                                          ("${picked_s.hour}:${picked_s.minute} ${picked_s.period.name}")
                                              .toString();
                                      matchBoyBirthTimeController.text =
                                          selectedTime;
                                    });
                                  }*/
                                },
                                controller: matchBoyBirthTimeController,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                  filled: true,
                                  hintText: "Birth time",
                                  hintStyle: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(height: 10),
                              TextField(
                                controller: matchBoyBirthPlaceController,
                                keyboardType: TextInputType.text,
                                cursorColor: text_dark,
                                readOnly: true,
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  placesDialog(
                                      matchBoyBirthPlaceController, setState);
                                },
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
                                  hintText: "BirthPlace",
                                  hintStyle: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(height: 10),
                              TextField(
                                controller: matchNoteController,
                                minLines: 4,
                                maxLines: 4,
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
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                  filled: true,
                                  hintText: "Note",
                                  hintStyle: const TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                  child: Text(
                                    "Delete Request",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: title,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              showDeleteDialog(getSet);
                            },
                          ),
                          Container(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              _validation(matchId, getSet);
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
                                  "Review Request",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: title,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          });
        });
  }

  _validation(String matchId, Matches getSet) {
    if (matchFnameController.text.isEmpty) {
      showToast("Please enter first name", context);
    } else if (matchLnameController.text.isEmpty) {
      showToast("Please enter Last Name", context);
    } else if (matchEmailcontroller.text.isEmpty) {
      showToast("Please enter email", context);
    } else if (matchNumberController.text.length <= 7) {
      showToast('Please enter valid mobile number', context);
    } else if (matchNumberController.text.length >= 13) {
      showToast('Please enter valid mobile number', context);
    } else if (matchGirlFnameController.text.isEmpty) {
      showToast("Please enter bride's first name", context);
    } else if (matchGirlLNameController.text.isEmpty) {
      showToast("Please enter bride's last name", context);
    } else if (matchGirlBirthDateController.text.isEmpty) {
      showToast("Please enter bride's birth", context);
    } else if (matchGirlBirthTimeController.text.isEmpty) {
      showToast("Please enter bride's birth time", context);
    } else if (matchGirlBirthPlaceController.text.isEmpty) {
      showToast("Please enter bride's birth place", context);
    } else if (matchBoyFNameController.text.isEmpty) {
      showToast("Please enter groom's first name", context);
    } else if (matchBoyLNameController.text.isEmpty) {
      showToast("Please enter  groom's last name", context);
    } else if (matchBoyBirthPlaceController.text.isEmpty) {
      showToast("Please enter  groom's birthplace", context);
    } else if (matchBoyBirthDateController.text.isEmpty) {
      showToast("Please enter  groom's birth date", context);
    } else {
      saveMatchdataAPI(matchId, getSet);
    }
  }

  saveMatchdataAPI(String matchId, Matches getSet) async {
    setState(() {
      _isLoading = true;
    });

    Navigator.pop(context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + matchmakingsave);

    Map<String, String> jsonBody = {
      "user_id": sessionManager.getUserId().toString(),
      "bride_name": matchGirlFnameController.value.text,
      "bride_surname": matchGirlLNameController.value.text,
      "bride_birth_date": universalDateConverter(
          "dd MMM,yyyy", "dd-MM-yyyy", matchGirlBirthDateController.value.text),
      "bride_birth_time": matchGirlBirthTimeController.value.text,
      "bride_address": matchGirlBirthPlaceController.value.text,
      "groom_name": matchBoyFNameController.value.text,
      "groom_surname": matchBoyLNameController.value.text,
      "groom_birth_date": universalDateConverter(
          "dd MMM,yyyy", "dd-MM-yyyy", matchBoyBirthDateController.value.text),
      "groom_birth_time": matchBoyBirthTimeController.value.text,
      "groom_address": matchBoyBirthPlaceController.value.text,
      "comments": matchNoteController.value.text,
      "first_name": matchFnameController.value.text,
      "last_name": matchLnameController.value.text,
      "email": matchEmailcontroller.value.text,
      "mobile": matchNumberController.value.text,
      "match_id": getSet.matchId.toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      getMatchListApi();

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

  void showDeleteDialog(Matches getSet) {
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
                      child: const Divider(
                        height: 1.5,
                        thickness: 1.5,
                        color: Colors.grey,
                      )),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Delete Match Request",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w900,
                            fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text(
                      "Are you sure you want to delete this request?",
                      style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w900,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
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
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(orange)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
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
                              callDeleteMatchApi(getSet);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        light_yellow)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
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
                      onChanged: (editable)
                      {
                        if (listCountryCode != null &&
                            listCountryCode.length > 0)
                        {
                          listSearchCountryName = [];
                          if (editable.length > 0)
                          {
                            for (var i = 0; i < listCountryCode.length; i++)
                            {
                              if (listCountryCode[i]
                                  .name
                                  .toLowerCase()
                                  .contains(
                                      editable.toString().toLowerCase())) {
                                listSearchCountryName.add(listCountryCode[i]);
                              }
                            }
                          } else {}
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
                              onTap: () {
                                setState(() {
                                  countryCode = listCountryCode[i].dialCode;
                                });
                                updateState(() {});
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 14, right: 14),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            listCountryCode[i].name.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w200,
                                                color: title),
                                            textAlign: TextAlign.start,
                                          )),
                                          Text(
                                            listCountryCode[i]
                                                .dialCode
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: text_new,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: text_light,
                                      indent: 1,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
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

  Future<void> placesDialog(
      TextEditingController controller, StateSetter updateState) async {
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
      language: "en",
    );

    if (prediction != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(prediction.placeId!);
      controller.text = prediction.description.toString();
      updateState(() {});
    }
  }

  getMatchListApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getMatchList);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = MatchListResponseModel.fromJson(user);

    if (statusCode == 200) {
      _listMatch = [];
      _listMatch = dataResponse.matches;
      _listMatch.reversed.toList();

      if (_listMatch.isNotEmpty)
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
      setState(()
      {
        _isLoading = false;
        _isNoDataVisible = true;
      });
    }
  }

  void callDeleteMatchApi(Matches getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deletematch);

    Map<String, String> jsonBody = {'match_id': getSet.matchId.toString()};

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var prayerResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && prayerResponse.success == 1) {
      getMatchListApi();
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(prayerResponse.message, context);
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
}
