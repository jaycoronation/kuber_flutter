import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kuber/model/BookingListResponseModel.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../constant/common_widget.dart';

class PujaReviewScreen extends StatefulWidget {
  final BookingList getSet;
  const PujaReviewScreen(this.getSet, {Key? key}) : super(key: key);

  @override
  State<PujaReviewScreen> createState() => _PujaReviewScreen();
}

class _PujaReviewScreen extends State<PujaReviewScreen> {

  BookingList getSet = BookingList();
  TextEditingController reviewController = TextEditingController();
  SessionManager sessionManager = SessionManager();
  double rating = 0.0;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    getSet = widget.getSet;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: bg_skin,
          appBar: AppBar(
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
            title: getTitle('Review Puja'),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rate your ${getSet.pujaName}",style: const TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 18),),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glow: false,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Image.asset('assets/images/ic_rating.png'),
                    onRatingUpdate: (value) {
                      print(value);
                      rating = value;
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextField(
                      controller: reviewController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                          color: text_dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                      minLines: 3,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey,),
                        ),
                        labelText: "Write your review",
                        labelStyle: const TextStyle(color: darkbrown,fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 22),
                  child: TextButton(
                    onPressed: () {
                      if (reviewController.value.text.isEmpty)
                        {
                          showSnackBar("Please enter your review", context);
                        }
                      else
                        {
                          saveReview();
                        }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: light_yellow, width: 0.5)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(light_yellow),
                    ),

                    child: isLoading
                        ? const Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2)),
                        )
                        : const Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Text('Review', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  saveReview() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + reviewSave);

    Map<String, String> jsonBody = {
      'booking_id': getSet.bookingId ?? '',
      'user_id': sessionManager.getUserId() ?? '',
      'rating': rating.toString(),
      'notes': reviewController.value.text,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    }
    else
    {
      setState(() {
        isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

}