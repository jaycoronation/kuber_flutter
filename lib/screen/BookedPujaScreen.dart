import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/constant/common_widget.dart';
import 'package:kuber/model/BookingListResponseModel.dart';
import 'package:kuber/screen/BookingDetailsScreen.dart';
import 'package:kuber/screen/MyAccountScreen.dart';
import 'package:kuber/screen/PujaReviewScreen.dart';
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
        appBar: AppBar(
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 55,
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
          title: getTitle('My Puja List',),
        ),
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
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(_bookingList[i].bookingId.toString())));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 10),
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: priest_light),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 6),
                            child: Text(
                                _bookingList[i].pujaName.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green
                                ),
                                textAlign: TextAlign.start
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 2, bottom: 2),
                                child: Text(
                                  "${_bookingList[i].pujaDay} ,${_bookingList[i].pujaDate}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: black,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(top: 2, bottom: 2),
                                child: Text(
                                  _bookingList[i].pujaTime.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
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
                                    margin: const EdgeInsets.only(top: 2, bottom: 2,),
                                    child: Text(
                                      _bookingList[i].bookingAddress.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: black,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2, right: 2,),
                            child: Text(
                                "Booked On ${_bookingList[i].bookedOn.toString()}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: black),
                                textAlign: TextAlign.start),
                          ),
                          Visibility(
                            visible: _bookingList[i].isReviewDone == 0,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 8, top: 8),
                                child: TextButton(
                                  onPressed: () async {
                                    startActivity(context, PujaReviewScreen(_bookingList[i]));
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: black,
                                              width: 1,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(priest_light)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Review",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
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

}
