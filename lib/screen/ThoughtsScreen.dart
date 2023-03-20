import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/ThoughtsResponseModel.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../utils/app_utils.dart';
import '../widget/loading.dart';
import '../widget/loading_more.dart';

class ThoughtsScreen extends StatefulWidget {
  const ThoughtsScreen({Key? key}) : super(key: key);

  @override
  State<ThoughtsScreen> createState() => _ThoughtsScreen();
}

class _ThoughtsScreen extends State<ThoughtsScreen> {
  bool isLoading = false;
  List<Records> listThoughts = [];
  bool _isLoadingMore = false;
  int _pageIndex = 0;
  final int _pageResult = 15;
  bool _isLastPage = false;
  bool isScrollingDown = false;
  late ScrollController _scrollViewController;

  @override
  void initState(){
    getThoughts(true);

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
          getThoughts(false);
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Thoughts",
                      style: getTitleFontStyle()
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4,bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: getSecondaryTitleFontStyle()
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: listThoughts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          openDetailsBottomSheet(listThoughts[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: white
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Text(
                                        listThoughts[index].title.toString(),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(fontWeight: FontWeight.w900,color: black,fontSize: 14)
                                    )
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_right,size: 24,color: black,)
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
          ),
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        }
    );
  }

  getThoughts(bool isFirstTime) async {
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

    final url = Uri.parse(MAIN_URL + getUserThoughts);

    Map<String, String> jsonBody = {
      'page' : _pageIndex.toString(),
      'limit' : _pageResult.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ThoughtsResponseModel.fromJson(user);

    if (isFirstTime) {
      if (listThoughts.isNotEmpty) {
        listThoughts = [];
      }
    }

    if (statusCode == 200 && dataResponse.success == 1) {

      List<Records>? _tempList = [];
      _tempList = dataResponse.records;
      listThoughts.addAll(_tempList!);

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

  void openDetailsBottomSheet(Records getSet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder:(context,setState) {
                return Wrap(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            )
                        ),
                        child:Column(
                          children: [
                            Container(
                                width: 50,
                                margin: const EdgeInsets.only(top: 12),
                                child: const Divider(
                                  height: 1.5,
                                  thickness: 1.5,
                                  color: Colors.grey,
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                getSet.title.toString(),
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: title,
                                    fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12,right: 12,left: 12),
                              child: Text(
                                getSet.description.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                    height: 1.5,
                                    fontSize: 14),
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                );
              }
        );
      },
    );
  }

}