import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/BookingListResponseModel.dart';
import 'package:kuber/screen/BookingDetailsScreen.dart';
import 'package:kuber/screen/MyAccountScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:kuber/widget/no_data_new.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class BookedPujaScreen extends StatefulWidget {
  const BookedPujaScreen({Key? key}) : super(key: key);

  @override
  State<BookedPujaScreen> createState() => _BookedPujaScreen();
}

class _BookedPujaScreen extends State<BookedPujaScreen> {
  bool _isLoading = false;
  List<BookingList> _bookingList = List<BookingList>.empty(growable: true);
  SessionManager sessionManager = SessionManager();
  bool _isNoDataVisible = false;

  @override
  void initState() {
    super.initState();
    _getbookinglist();
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
            : _isNoDataVisible
            ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_booked_prayer.png', titleMSG: 'No Booked Puja Found')
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _bookingList.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: priest_light),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.only(
                                            top: 6, right: 6, left: 8),
                                        child: Text(
                                            " ${_bookingList[i].pujaName.toString()}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.w600,
                                                color: Colors.green),
                                            textAlign: TextAlign.start),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 8,
                                                left: 8),
                                            child: Text(
                                              _bookingList[i]
                                                      .pujaDay
                                                      .toString() +" ," +
                                                  _bookingList[i]
                                                      .pujaDate
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  color: black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 8,
                                                left: 8),
                                            child: Text(
                                              _bookingList[i]
                                                  .pujaTime
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.w900,
                                                  color: black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 8,
                                                left: 8),
                                            child: Text(
                                              _bookingList[i]
                                                  .bookingAddress
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.w400,
                                                  color: black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                            ),
                                          )),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                right: 8,
                                                left: 8),
                                            child: const Text(
                                              "",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color: black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.only(
                                            top: 6,
                                            right: 6,
                                            left: 6,
                                            bottom: 8),
                                        child: Text(
                                            "Booked On ${_bookingList[i].bookedOn.toString()}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.w600,
                                                color: text_light),
                                            textAlign: TextAlign.start),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(_bookingList[i].bookingId.toString())));
                    },
                  );
                }),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  _getbookinglist() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + bookingList);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var bookingResponse = BookingListResponseModel.fromJson(user);

    if (statusCode == 200 && bookingResponse.success == 1) {

      if (bookingResponse.bookingList != null) {
        _bookingList =[];
        _bookingList = bookingResponse.bookingList!;
        _bookingList.reversed.toList();
      }
      if (_bookingList.isEmpty)
      {
        _isNoDataVisible = true;
      }
      else
      {
        _isNoDataVisible = false;
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isNoDataVisible = true;
      });
    }
  }

  PreferredSizeWidget setUpNavigationBar() {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 55,
      automaticallyImplyLeading: false,
      backgroundColor: bg_skin,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset("assets/images/ic_back_arrow.png",
            width: 18, height: 18),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const MyAccountScreen()));
        },
      ),
      title: const Text(
        'My Puja List',
        style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
      ),
    );
  }
}
