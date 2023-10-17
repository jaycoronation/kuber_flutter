import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/screen/AstrologyScreen.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/DonationListScreen.dart';
import 'package:kuber/screen/FeedScreen.dart';
import 'package:kuber/screen/MatchMakingScreen.dart';
import 'package:kuber/screen/PrayerRequestScreen.dart';
import 'package:kuber/screen/RashiScreen.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/colors.dart';
import '../model/AstroDetailResponseModel.dart';
import '../model/CommonResponseModel.dart';
import '../model/DonationDetailResponseModel.dart';
import '../model/DonationResonseModel.dart';
import '../model/FeedListResponseModel.dart';
import '../model/MatchDetailResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
import '../utils/session_manager.dart';
import '../utils/session_manager_methods.dart';
import 'BookedPujaScreen.dart';
import 'LoginForWeb.dart';
import 'NewProfileScreen.dart';

class DashboardForWeb extends StatefulWidget {
  const DashboardForWeb({Key? key}) : super(key: key);

  @override
  State<DashboardForWeb> createState() => _DashboardForWeb();
}

class _DashboardForWeb extends State<DashboardForWeb> {
  SessionManager sessionManager = SessionManager();
  int currentIndex = 0;
  bool _isNoDataVisible = false;
  bool _isLoading = false;
  String paymentId = "";

  List<Feeds> listFeed = [];


  @override
  void initState(){
    super.initState();
    /*var url = window.location.href;

    print("Current Url === $url");
    log("Current Url === $url");

    if (url.contains("success_donation"))
      {
        paymentId = Uri.parse(url).queryParameters['paymentId'] ?? "" ;
        print(Uri.parse(url).queryParameters['paymentId']);
        print(Uri.parse(url).queryParameters['token']);
        DonationDetail();
      }

    if (url.contains("success_match"))
      {
        paymentId = Uri.parse(url).queryParameters['paymentId'] ?? "";
        print(Uri.parse(url).queryParameters['paymentId']);
        print(Uri.parse(url).queryParameters['token']);
        MatchDetail();
      }

     if (url.contains("success_astro"))
       {
         paymentId = Uri.parse(url).queryParameters['paymentId'] ?? "";
         print(Uri.parse(url).queryParameters['paymentId']);
         print(Uri.parse(url).queryParameters['token']);
         AstrologyDetail();
       }*/
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isMediumScreen(context)
        ? Scaffold(
          body: Container(
            color: kuber,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 310,
                      height: MediaQuery.of(context).size.height -150,
                      child: Material(
                        color: kuber,
                        shadowColor: Colors.grey,
                        shape:  const RoundedRectangleBorder(
                            side:  BorderSide(color: lightGrey),
                            borderRadius: BorderRadius.all( Radius.circular(14))
                        ),
                        elevation: 15.0,
                        child: SingleChildScrollView(
                          child: Material(
                            type: MaterialType.transparency,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Center(
                                //   child: Image.asset(
                                //     "assets/images/ic_guru_web.png",width: 160,
                                //   ),
                                // ),
                                // Container(height: 12,),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                //   child: Text(sessionManager.firstName.toString(),
                                //   style: const TextStyle(fontWeight: FontWeight.w800, color: listActionColor, fontSize: 18)),
                                // ),
                                //   Container(height: 12,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 0 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () async {
                                                var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAccountScreenNew()));
                                                setState(() {

                                                });
                                              },
                                              child: sessionManager.getImagePic()?.isNotEmpty ?? false
                                                  ? Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: 28,
                                                        height: 28,
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
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Image.asset("assets/images/ic_user_placeholder.png",height: 28,width: 28,),
                                              )
                                          ),
                                          Container(width: 18,),
                                          Text('Dashboard',
                                            style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 0 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 1;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 1 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            child: currentIndex == 1
                                                ? Image.asset('assets/images/ic_feed.png', width: 26, height: 26,color: white, )
                                                : Image.asset('assets/images/ic_feed.png', width: 26, height: 26, color: darkbrown,),
                                          ),
                                          Container(width: 18,),
                                          Text('Feed', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 1 ? white : darkbrown, fontSize: 18),
                                          )],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 2;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 2 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),

                                              child: currentIndex == 2
                                                  ? Image.asset('assets/images/ic_booked_prayer.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_booked_prayer.png',  width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Booked Puja', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 2 ?white : listActionColor, fontSize: 18),
                                          )],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 3;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 3 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            child: currentIndex == 3
                                                ? Image.asset('assets/images/ic_prayer_request.png', width: 26, height: 26,color: white, )
                                                : Image.asset('assets/images/ic_prayer_request.png',width: 26, height: 26, color: darkbrown,),
                                          ),
                                          Container(width: 18,),
                                          Text('Prayer Request', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 3 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 4;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 4 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 4
                                                  ? Image.asset('assets/images/ic_rashi_list.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_rashi_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Rashi List', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 4 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 5;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 5 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 5
                                                  ? Image.asset('assets/images/ic_match_making_list.png',width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_match_making_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Match Making', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 5 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 6;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 6 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 6
                                                  ? Image.asset('assets/images/ic_astrology_list.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_astrology_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Astrology', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 6 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 7;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 7 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 7
                                                  ? Image.asset('assets/images/Charity.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/Charity.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Donation List', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 7 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 8;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 8 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 8
                                                  ? Image.asset('assets/images/ic_profile.png', width: 26, height: 26, color: white, )
                                                  : Image.asset('assets/images/ic_profile.png', width: 26, height: 26 , color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('My Profile', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 8 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    _showLogoutBottomSheet();
                                  },
                                  child: Container(
                                      color: currentIndex == 9 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 9
                                                  ? Image.asset('assets/images/ic_logout_new.png', width: 20, height: 20, color: white, )
                                                  : Image.asset('assets/images/ic_logout_new.png', width: 20, height: 20 , color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Logout', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 9 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 22,),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height -150,
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        border:Border.all(color: lightGrey, width: 0.5 ),
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:currentIndex == 0
                            ? const DashboardScreen()
                            : currentIndex == 1
                            ? const FeedScreen()
                            :currentIndex == 2
                            ? const BookedPujaScreen()
                            :currentIndex == 3
                            ? const PrayerRequestScreen()
                            :currentIndex == 4
                            ? const RashiScreen()
                            :currentIndex == 5
                            ? const MatchMakingScreen()
                            :currentIndex == 6
                            ? const AstrologyScreen()
                            :currentIndex == 7
                            ? const DonationListScreen()
                            :currentIndex == 8
                            ? const MyAccountScreenNew()
                            : Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        : Scaffold(
          body: Container(
            color: kuber,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 310,
                      height: MediaQuery.of(context).size.height -100,
                      child: Material(
                        color: kuber,
                        shadowColor: Colors.grey,
                        shape:  const RoundedRectangleBorder(
                            side:  BorderSide(color: lightGrey),
                            borderRadius: BorderRadius.all( Radius.circular(14))
                        ),
                        elevation: 15.0,
                        child: SingleChildScrollView(
                          child: Material(
                            type: MaterialType.transparency,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Center(
                                //   child: Image.asset(
                                //     "assets/images/ic_guru_web.png",width: 160,
                                //   ),
                                // ),
                                Container(height: 12,),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                //   child: Text(sessionManager.firstName.toString(),
                                //   style: const TextStyle(fontWeight: FontWeight.w800, color: listActionColor, fontSize: 18)),
                                // ),
                                //   Container(height: 12,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 0 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () async {
                                                var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAccountScreenNew()));
                                                setState(() {

                                                });
                                              },
                                              child: sessionManager.getImagePic()?.isNotEmpty ?? false
                                                  ? Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 28,
                                                      height: 28,
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
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Image.asset("assets/images/ic_user_placeholder.png",height: 28,width: 28,),
                                              )
                                          ),
                                          Container(width: 18,),
                                          Text('Dashboard',
                                            style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 0 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 1;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 1 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            child: currentIndex == 1
                                                ? Image.asset('assets/images/ic_feed.png', width: 26, height: 26,color: white, )
                                                : Image.asset('assets/images/ic_feed.png', width: 26, height: 26, color: darkbrown,),
                                          ),
                                          Container(width: 18,),
                                          Text('Feed', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 1 ? white : darkbrown, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 2;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 2 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 2
                                                  ? Image.asset('assets/images/ic_booked_prayer.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_booked_prayer.png',  width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Booked Puja', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 2 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 3;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 3 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            child: currentIndex == 3
                                                ? Image.asset('assets/images/ic_prayer_request.png', width: 26, height: 26,color: white, )
                                                : Image.asset('assets/images/ic_prayer_request.png',width: 26, height: 26, color: darkbrown,),
                                          ),
                                          Container(width: 18,),
                                          Text('Prayer Request', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 3 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 4;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 4 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration:  BoxDecoration(
                                      //     border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 4
                                                  ? Image.asset('assets/images/ic_rashi_list.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_rashi_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Rashi List', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 4 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 5;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 5 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 5
                                                  ? Image.asset('assets/images/ic_match_making_list.png',width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_match_making_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Match Making', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 5 ?white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 6;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 6 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 6
                                                  ? Image.asset('assets/images/ic_astrology_list.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/ic_astrology_list.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Astrology', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 6 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 7;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 7 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 7
                                                  ? Image.asset('assets/images/Charity.png', width: 26, height: 26,color: white, )
                                                  : Image.asset('assets/images/Charity.png', width: 26, height: 26, color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Donation List', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 7 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentIndex = 8;
                                    });
                                  },
                                  child: Container(
                                      color: currentIndex == 8 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              child: currentIndex == 8
                                                  ? Image.asset('assets/images/ic_profile.png', width: 26, height: 26, color: white, )
                                                  : Image.asset('assets/images/ic_profile.png', width: 26, height: 26 , color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('My Profile', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 8 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                                GestureDetector(
                                  onTap: (){
                                    _showLogoutBottomSheet();
                                  },
                                  child: Container(
                                      color: currentIndex == 9 ? darkbrown : kuber,
                                      padding: const EdgeInsets.only(top: 14, bottom: 14, left: 32),
                                      // decoration: BoxDecoration(
                                      //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                      //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                      // ),
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(4),

                                              child: currentIndex == 9
                                                  ? Image.asset('assets/images/ic_logout_new.png', width: 20, height: 20, color: white, )
                                                  : Image.asset('assets/images/ic_logout_new.png', width: 20, height: 20 , color: darkbrown,)
                                          ),
                                          Container(width: 18,),
                                          Text('Logout', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 9 ? white : listActionColor, fontSize: 18),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                Container(height: 8,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 22,),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height -100,
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        border:Border.all(color: lightGrey, width: 0.5 ),
                        color: white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:currentIndex == 0
                            ? const DashboardScreen()
                            : currentIndex == 1
                            ? const FeedScreen()
                            :currentIndex == 2
                            ? const BookedPujaScreen()
                            :currentIndex == 3
                            ? const PrayerRequestScreen()
                            :currentIndex == 4
                            ? const RashiScreen()
                            :currentIndex == 5
                            ? const MatchMakingScreen()
                            :currentIndex == 6
                            ? const AstrologyScreen()
                            :currentIndex == 7
                            ? const DonationListScreen()
                            :currentIndex == 8
                            ? const MyAccountScreenNew()
                            : Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  _showAlertDialog(String image, String text) {
    Widget okButton = Image.asset(image,height: 160,width:160);

    showToast(text, context);
   /* AlertDialog alert = AlertDialog(
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
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );*/
  }

  void _showLogoutBottomSheet() {
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
                      child: const Divider(height: 1.5, thickness: 1.5,color: Colors.grey,)
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Logout", style: TextStyle(color: darkbrown, fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to Logout?", style: TextStyle(color: black, fontWeight: FontWeight.w800,fontSize: 16),textAlign: TextAlign.justify,),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left:12,right: 12,bottom: 30,top:12),
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
                              padding: EdgeInsets.only(left: 4.0, right: 4, top: 12, bottom: 12),
                              child: Text(
                                "No",
                                style: TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left:12,right: 12,bottom: 30,top:12),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SessionManagerMethods.clear();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreenForWeb()), (Route<dynamic> route) => true);
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
                              padding: EdgeInsets.only(left: 4.0, right: 4, top: 12, bottom: 12),
                              child: Text(
                                "Yes",
                                style: TextStyle(color: black,fontSize: 18,fontWeight: FontWeight.w600),
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

  callsaveMatchdataAPI(Match getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + matchmakingsave);

    Map<String, String> jsonBody = {
      "user_id": sessionManager.getUserId().toString(),
      "bride_name": getSet.brideName.toString(),
      "bride_surname": getSet.brideSurname.toString(),
      "bride_birth_date": getSet.brideBirthDate.toString(),
      "bride_birth_time": getSet.brideBirthTime.toString(),
      "bride_address": getSet.brideAddress.toString(),
      "groom_name": getSet.groomName.toString(),
      "groom_surname": getSet.groomSurname.toString(),
      "groom_birth_date": getSet.groomBirthDate.toString(),
      "groom_birth_time": getSet.groomBirthTime.toString(),
      "groom_address": getSet.groomAddress.toString(),
      "comments": getSet.comments.toString(),
      "first_name": getSet.firstName.toString(),
      "last_name": getSet.lastName.toString(),
      "email": getSet.email.toString(),
      "mobile": getSet.mobile.toString(),
      "country_code": getSet.mobile.toString(),
      "match_id": getSet.matchId.toString(),
      'payment_id' :paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      _showAlertDialog("assets/images/ic_match_only.png","Your request\nfor match making is received,\nwill contact you shortly.");
      setState(()
      {
        _isLoading = false;
      });
    } else
    {
      setState(()
      {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

  _callAstrologySaveApi(Astrology getSet) async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + astrologySave);

    Map<String, String> jsonBody = {
      "first_name": getSet.firstName.toString(),
      "last_name": getSet.lastName.toString(),
      "birth_date": getSet.birthDate.toString(),
      "birth_time": getSet.birthTime.toString(),
      "address": getSet.address.toString(),
      "comments": getSet.comments.toString(),
      "user_id": sessionManager.userId.toString(),
      "astrology_id": getSet.astrologyId.toString(),
      "email": getSet.email.toString(),
      "mobile": getSet.mobile.toString(),
      "notes": getSet.comments.toString(),
      "payment_id": paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var astroResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && astroResponse.success == 1) {
      _showAlertDialog("assets/images/ic_astro_only.png","Your request\nfor astrology is received,\nwill contact you shortly.");
      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(astroResponse.message, context);
    }
  }

  AstrologyDetail() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getAstrologyDetail);

    Map<String, String> jsonBody = {
      'astrology_id' : sessionManager.getAstrologyId() ?? "",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AstroDetailResponseModel.fromJson(user);
    if (statusCode == 200) {
      _callAstrologySaveApi(dataResponse.astrology ?? Astrology());
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
    }

  }

  MatchDetail() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getMatchDetail);

    Map<String, String> jsonBody = {
      'match_id' : sessionManager.getMatchId() ?? "",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = MatchDetailResponseModel.fromJson(user);
    if (statusCode == 200) {
      callsaveMatchdataAPI(dataResponse.match ?? Match());
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
    }

  }

  DonationDetail() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getDonationDetail);

    Map<String, String> jsonBody = {
      'id' : sessionManager.getDonationId() ?? "",
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = DonationDetailResponseModel.fromJson(user);
    if (statusCode == 200 && dataResponse.success == 1) {
      callsDonationAPI(dataResponse.donation ?? Donation());
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }

  }

  callsDonationAPI(Donation getSet) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + donationSave);

    Map<String, String> jsonBody = {
      'reason_for_donation': getSet.reasonForDonation.toString(),
      'amount': getSet.amount.toString(),
      'first_name': sessionManager.getName().toString(),
      'last_name': sessionManager.getLastName().toString(),
      'email': sessionManager.getEmail().toString(),
      'contact_no': sessionManager.getPhone().toString(),
      'user_id': sessionManager.getUserId().toString(),
      'id' : getSet.id ?? "",
      'payment_id': paymentId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var astroResponse = DonationResonseModel.fromJson(user);

    if (statusCode == 200 && astroResponse.success == 1) {
      _showAlertDialog("assets/images/ic_donation_vec.png"," Thank You for\n Your Donation");

      setState(() {
        _isLoading = false;
      });
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(astroResponse.message, context);
    }
  }


}