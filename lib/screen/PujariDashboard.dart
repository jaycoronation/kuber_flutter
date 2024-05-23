import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/no_data_new.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/DonationListResponseModel.dart';
import '../model/PujariDashboardResponseModel.dart';
import 'MyAccountScreen.dart';
import 'NewProfileScreen.dart';

class PujariDashboard extends StatefulWidget {
  const PujariDashboard({Key? key}) : super(key: key);

  @override
  State<PujariDashboard> createState() => _PujariDashboard();
}

class _PujariDashboard extends State<PujariDashboard> {

  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;
  List<Booking> listAssignedPuja = [];

  @override
  void initState(){
    getAssignedPooja();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kuber,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kuber,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light,
            ) ,
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: kuber,
            elevation: 0,
            titleSpacing: 42,
            centerTitle: true,
            title: const Center(
              child: Text("Dashboard",
                  style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 20),
                  textAlign: TextAlign.center
              ),
            ),
            actions: [
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAccountScreen()));
                    setState(() {

                    });
                  },
                  child: sessionManager.getImagePic()?.isNotEmpty ?? false
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: light_yellow,
                                width: 1
                            ),
                            image: DecorationImage(
                                image: NetworkImage(sessionManager.getImagePic().toString()) ,
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/ic_user_placeholder.png",height: 60,width: 60,),
                      )
              )
            ],
          ),
          body: listAssignedPuja.isNotEmpty
              ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: listAssignedPuja.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDetailsScreen(_bookingList[i].bookingId.toString())));
                        },
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
                                                "${listAssignedPuja[i].username.toString()} - ${listAssignedPuja[i].mobile.toString()}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.green),
                                                textAlign: TextAlign.start
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 2, bottom: 2, right: 8, left: 12),
                                                  child: Text(
                                                    "${listAssignedPuja[i].pujaName ?? ''} Pooja on ${listAssignedPuja[i].bookingDate ?? ''}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: black,
                                                        overflow: TextOverflow.clip,
                                                        fontSize: 14),
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                margin: const EdgeInsets.only(top: 2, left: 8),
                                                child: const Text(
                                                  "Yajman will pickup you : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Text(
                                                listAssignedPuja[i].pickupByUser.toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: black,
                                                    fontSize: 14),
                                                textAlign: TextAlign.end,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(4),
                                                margin: const EdgeInsets.only( bottom: 2,left: 8),
                                                child: const Text(
                                                  "Yajman will provide pooja goods : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(

                                                child: Text(
                                                  listAssignedPuja[i].poojaGoodsProvideByUser.toString(),
                                                  style: const TextStyle(
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
                                                "Booked On ${listAssignedPuja[i].bookedOn.toString()}",
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
                      );
                    },
                  ),
                )

              ],
            )
              : const MyNoDataNewWidget(msg: "There are no assigned pooja yet please check it later!", icon: 'assets/images/ic_booked_prayer.png', titleMSG: "No Pooja Found"),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
    );
  }

  getAssignedPooja() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getAssignedPoojaForPujari);

    Map<String, String> jsonBody = {
      'pujari_id' : sessionManager.getUserId().toString(),
      'admin_id' : sessionManager.getUserId().toString(),
      'page' : "1",
      'limit' : "10"
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PujariDashboardResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      listAssignedPuja = dataResponse.booking ?? [];
      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
    }
  }

}