import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/screen/AstrologyScreen.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/DonationListScreen.dart';
import 'package:kuber/screen/FeedScreen.dart';
import 'package:kuber/screen/MatchMakingScreen.dart';
import 'package:kuber/screen/PrayerRequestScreen.dart';
import 'package:kuber/screen/RashiScreen.dart';
import '../constant/colors.dart';
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

  @override
  void initState(){
    super.initState();
    var url = window.location.href;

    print("Current Url === $url");
    log("Current Url === $url");
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

}