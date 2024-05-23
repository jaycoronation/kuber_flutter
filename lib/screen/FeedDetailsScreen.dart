import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/FeedListResponseModel.dart';
import 'package:like_button/like_button.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';

import '../constant/api_end_point.dart';
import '../constant/common_widget.dart';
import '../model/CommonResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';

class FeedDetailsScreen extends StatefulWidget {
  final Feeds getSet;
  const FeedDetailsScreen(this.getSet, {Key? key}) : super(key: key);


  @override
  State<FeedDetailsScreen> createState() => _FeedDetailsScreen();
}

class _FeedDetailsScreen extends State<FeedDetailsScreen> {
  Feeds getSet = Feeds();
  List<Feeds> listFeed = [];
  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;

  @override
  void initState(){
    getFeed();
    getSet = widget.getSet;
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
            leading:GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
            centerTitle: true,
            actions: [
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: LikeButton(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  size: 22,
                  isLiked:getSet.isLiked == true,
                  circleColor: const CircleColor(start: orange, end: blue),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: orange,
                    dotSecondaryColor: blue,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Image.asset(
                      getSet.isLiked ? "assets/images/like_filled.png" : "assets/images/like.png",
                    );
                  },
                  onTap: (isLike) async {
                    setState(() {
                      if (getSet.isLiked == true) {
                        getSet.isLiked = false;
                      } else {
                        getSet.isLiked = true;
                      }
                    });
                    _likeFeeds(getSet);
                    return true;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      Share.share(getSet.shareUrl.toString());
                    },
                    child: Image.asset("assets/images/share.png",width: 20,)
                ),
              ),
              Container(width: 12,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                      child: Text(getSet.title.toString(),style: const TextStyle(fontSize: 18,color: black,fontWeight: FontWeight.w800))
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Text(getDateFromTimestamp(getSet.timestamp.toString()),style: const TextStyle(fontSize: 14,color: black,fontWeight: FontWeight.w800))
                  ),
                  Image.network(getSet.mediaPath.toString(),fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
                  Container(
                    color: skinLight,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
                    child: Text(
                        getSet.description.toString(),
                        style: const TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w500,height: 1.5)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }

  _likeFeeds(Feeds listFeed) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + likeFeeds);

    Map<String, String> jsonBody = {
      'user_id' : sessionManager.getUserId().toString(),
      'id' : listFeed.id.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }



  getFeed() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getUserFeed);

    Map<String, String> jsonBody = {
      'user_id' : sessionManager.getUserId().toString(),
      'page' : "0",
      'limit' : "10",
      'status'  : "1"
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = FeedListResponseModel.fromJson(user);


    if (statusCode == 200 && dataResponse.success == 1) {
      List<Feeds>? _tempList = [];
      _tempList = dataResponse.records;
      listFeed.addAll(_tempList!);
    }else {
      showSnackBar(dataResponse.message.toString(), context);
    }
    setState(() {
    });
  }

}