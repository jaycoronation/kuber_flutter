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
import '../model/DonationListResponseModel.dart';
import '../utils/app_utils.dart';
import '../widget/no_data_new.dart';

class DonationListScreen extends StatefulWidget {
  const DonationListScreen({Key? key}) : super(key: key);

  @override
  State<DonationListScreen> createState() => _DonationListScreen();
}

class _DonationListScreen extends State<DonationListScreen> {
  bool _isLoading = false;
  bool _isNoDataVisible = false;

  final SessionManager _sessionManager = SessionManager();
  List<Records> _listDonation = [];


  @override
  void initState() {
    getDonationListApi();
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
            titleSpacing: 0,
            title: Text("Donation List", style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w900),),
          ),
          body: _isLoading
              ? const LoadingWidget()
              : _isNoDataVisible
              ? const MyNoDataNewWidget(msg: "", icon: 'assets/images/ic_rashi_list.png', titleMSG: 'No Donation List Found')
              : SingleChildScrollView(
            child: Column(
              children:  [

                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _listDonation.length,
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
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    margin: const EdgeInsets.only(
                                                        top: 12,
                                                        bottom: 2,
                                                        right: 14,
                                                        left: 14),
                                                    child: Text(
                                                      _listDonation[i]
                                                          .reasonForDonation
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: black,
                                                          fontSize: 16),
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
                                                child:  Text(
                                                  "Amount :  ₹ ${_listDonation[i].amount.toString()} ",
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
                                              top: 8,
                                                bottom: 12,
                                                right: 18,
                                                left: 14),
                                            child:  Text(
                                              "Thank You For Donation.",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color: black,
                                                  fontSize: 14),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      );
                    }),
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




  getDonationListApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getDonationList);

    Map<String, String> jsonBody = {
      'user_id' : _sessionManager.getUserId().toString(),
      'page' : "1",
      'limit' : "10"
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = DonationListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      _listDonation = [];
      _listDonation = dataResponse.records ?? [];
      _listDonation.reversed.toList();

      if (_listDonation.isNotEmpty)
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
}