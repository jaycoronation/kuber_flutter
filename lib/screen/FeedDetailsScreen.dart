import 'package:flutter/material.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/FeedListResponseModel.dart';

import '../utils/app_utils.dart';

class FeedDetailsScreen extends StatefulWidget {
  final Feeds getSet;
  const FeedDetailsScreen(this.getSet, {Key? key}) : super(key: key);

  @override
  State<FeedDetailsScreen> createState() => _FeedDetailsScreen();
}

class _FeedDetailsScreen extends State<FeedDetailsScreen> {
  Feeds getSet = Feeds();

  @override
  void initState(){
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
            leading:IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context);
              },
            ) ,
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
}