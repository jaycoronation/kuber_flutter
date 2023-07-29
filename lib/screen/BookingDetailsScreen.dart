import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/BookingDetailsResponseModel.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  const BookingDetailsScreen(this.bookingId, {Key? key}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreen();
}

class _BookingDetailsScreen extends State<BookingDetailsScreen> {
  bool _isLoading = false;
  Booking _bookingDetail = Booking();

  @override
  void initState() {
    super.initState();
    _getBookingDetailsApi();
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
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      margin: const EdgeInsets.only(
                          left: 16, top: 20, right: 10, bottom: 10),
                      child: const Text(
                        'Booking Details',
                        style: TextStyle(
                            fontSize: 20,
                            color: black,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10, left: 16, right: 10, bottom: 12),
                      child: const Text(
                        'User Details : ',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w700),
                      )),
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
                          child: Text(
                            _bookingDetail.username.toString(),
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
                            _bookingDetail.email.toString(),
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
                            _bookingDetail.mobile.toString(),
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
                      margin: const EdgeInsets.only(
                          top: 10, left: 16, right: 10, bottom: 12),
                      child: const Text(
                        'Puja Details :',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w700),
                      )),
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
                          child: Text(
                            _bookingDetail.pujaName.toString(),
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
                            _bookingDetail.pujaDescription.toString(),
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
                      margin: const EdgeInsets.only(
                          top: 10, left: 16, right: 10, bottom: 12),
                      child: const Text(
                        'Puja Date & Time :',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w700),
                      )),
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
                          child: Text(
                            _bookingDetail.pujaDay.toString() +
                                "," +
                                _bookingDetail.pujaDate.toString()+"  "+
                                _bookingDetail.pujaTime.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: title),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10, left: 16, right: 10, bottom: 12),
                      child: const Text(
                        'Address Details :',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w700),
                      )),
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
                          child: Text(
                            _bookingDetail.bookingAddress.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: title),
                            textAlign: TextAlign.start,
                          ),
                        ),
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
                          "Will you pick up priest? ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          _bookingDetail.pickupByUser == "1" ? "Yes" : "No",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
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
                          "Do You Wants goodfs from Keber? ",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          _bookingDetail.pickupByUser == "1" ? "Yes" : "No",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: title,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                    ],
                  ),
                )),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  _getBookingDetailsApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + bookingDetails);

    Map<String, String> jsonBody = {
      'booking_id': widget.bookingId,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var bookingDetailResponse = BookingDetailsResponseModel.fromJson(user);

    if (statusCode == 200 && bookingDetailResponse.success == 1) {
      if (bookingDetailResponse.booking != null) {
        _bookingDetail = bookingDetailResponse.booking!;
        print(" data response${bookingDetailResponse.booking}");
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(bookingDetailResponse.message, context);
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
          Navigator.pop(context);
        },
      ),
    );
  }
}
