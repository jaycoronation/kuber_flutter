import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kuber/screen/FeedDetailsScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:like_button/like_button.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/FeedListResponseModel.dart';
import '../widget/loading_more.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {
  bool isLoading = false;
  List<Feeds> listFeed = [];
  bool _isLoadingMore = false;
  int _pageIndex = 0;
  final int _pageResult = 15;
  bool _isLastPage = false;
  bool isScrollingDown = false;
  late ScrollController _scrollViewController;
  SessionManager sessionManager = SessionManager();

  @override
  void initState(){
    getFeed(true);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {});
        }
      }
      pagination();

    });

    super.initState();
  }

  void pagination() {
    if (!_isLastPage && !_isLoadingMore) {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent)) {
        setState(() {
          _isLoadingMore = true;
          getFeed(false);
        });
      }
    }
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
            leading:IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ) ,
          ),
          body: isLoading
              ? const LoadingWidget()
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Feed",
                          style: getTitleFontStyle()
                      ),
                    ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: listFeed.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedDetailsScreen(listFeed[index])));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: white
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        listFeed[index].mediaPath.toString(),
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),

                                      child: Row(
                                        children: [
                                          LikeButton(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            size: 22,
                                            isLiked: listFeed[index].isLiked == true,
                                            circleColor: const CircleColor(start: orange, end: blue),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor: orange,
                                              dotSecondaryColor: blue,
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Image.asset(
                                                listFeed[index].isLiked ? "assets/images/like_filled.png" : "assets/images/like.png",
                                              );
                                            },
                                            onTap: (isLike) async {
                                              setState(() {
                                                if (listFeed[index].isLiked == true) {
                                                  listFeed[index].isLiked = false;
                                                } else {
                                                  listFeed[index].isLiked = true;
                                                }
                                              });
                                              likeFeeds;
                                              return true;
                                            },
                                          ),
                                          Container(width: 12,),
                                          GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () async {
                                                if (await canLaunchUrl(Uri.parse(listFeed[index].shareUrl.toString())))
                                                {
                                                  await launchUrl(Uri.parse(listFeed[index].shareUrl.toString()),mode: LaunchMode.externalApplication);
                                                }
                                              },
                                              child: Image.asset("assets/images/share.png",width: 20,)
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(height: 4,),
                                    Container(
                                        margin: const EdgeInsets.only(left: 12,right: 12),
                                        child: Text(listFeed[index].title.toString(),style: const TextStyle(fontWeight: FontWeight.w400,color: black,fontSize: 14))
                                    ),
                                    Container(height: 12,),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(left: 12,right: 12),
                                        child: Text(getDateFromTimestamp(listFeed[index].timestamp.toString()),
                                            style: const TextStyle(fontWeight: FontWeight.w500,color: darkbrown,fontSize: 14))
                                    ),
                                    Container(height: 12,),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Visibility(
                          visible: _isLoadingMore,
                          child: const LoadingMoreWidget()
                      )
                  ],
                ),
              )
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }

  getFeed(bool isFirstTime) async {
    if (isFirstTime)
      {
        setState(() {
          isLoading = true;
          _isLoadingMore = false;
          _pageIndex = 1;
          _isLastPage = false;
        });
      }
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getUserFeed);

    Map<String, String> jsonBody = {
      'page' : _pageIndex.toString(),
      'user_id' : sessionManager.getUserId().toString(),
      'limit' : _pageResult.toString(),
      'status'  : "1"

    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = FeedListResponseModel.fromJson(user);

    if (isFirstTime) {
      if (listFeed.isNotEmpty) {
        listFeed = [];
      }
    }

    if (statusCode == 200 && dataResponse.success == 1) {

      List<Feeds>? _tempList = [];
      _tempList = dataResponse.records;
      listFeed.addAll(_tempList!);

      if (_tempList.isNotEmpty) {
        _pageIndex += 1;
        if (_tempList.isEmpty || _tempList.length % _pageResult != 0) {
          _isLastPage = true;
        }
      }

    } else {
      showSnackBar(dataResponse.message.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }
}