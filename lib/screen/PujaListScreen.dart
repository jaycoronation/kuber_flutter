import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/PujaListResponseModel.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/common_widget.dart';
import 'PujaDetailsScreen.dart';

class PujaListScreen extends StatefulWidget {
  const PujaListScreen({Key? key}) : super(key: key);

  @override
  State<PujaListScreen> createState() => _PujaListScreen();
}

class _PujaListScreen extends State<PujaListScreen> {
  List<PujaList> _pujaList = List<PujaList>.empty(growable: true);
  List<PujaList> listPujaSearch = List<PujaList>.empty(growable: true);
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    _getPujaListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bg_skin,
        appBar:  AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: bg_skin,
          titleSpacing: 0,
          elevation: 0,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: Row(
            children: [
              const Text(
                "Puja List",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const LoadingWidget()
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(12, 8, 12, 6),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      color: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: black),
                        onChanged: (s){
                          setState((){
                            if (s.length > 1)
                            {
                              if(listPujaSearch.isNotEmpty){
                                listPujaSearch= [];
                              }
                              for (var i=0; i < _pujaList.length; i++)
                              {
                                if (_pujaList[i].pujaName.toString().toLowerCase().contains(s.toString().toLowerCase().trim()))
                                {
                                  listPujaSearch.add(_pujaList[i]);
                                  print(listPujaSearch.toString());
                                }
                              }
                            }
                            else
                              {
                                listPujaSearch.clear();
                              }
                          });
                        },
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: ImageIcon(
                                AssetImage("assets/images/ic_search.png"),
                                color: Colors.black,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: text_light)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount:listPujaSearch.isNotEmpty? listPujaSearch.length: _pujaList.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Container(
                              margin: const EdgeInsets.only(left: 14, right: 14),
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                onTap: (){
                                  var data = listPujaSearch.isNotEmpty? listPujaSearch[i]: _pujaList[i];
                                  Navigator.pop(context,data);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: white,
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(listPujaSearch.isNotEmpty? listPujaSearch[i].pujaName.toString():_pujaList[i].pujaName.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  PujaDetailsScreen(_pujaList[i].pujaId.toString())));
                                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=> PujaDetailsScreen(listPujaSearch.isNotEmpty? listPujaSearch[i]:_pujaList[i].pujaId.toString())));
                                          },
                                          child: Container(
                                            alignment: Alignment.bottomRight,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              color: light_yellow,
                                              elevation: 10,
                                              child: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Text("Pooja Info",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: black,
                                                      fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  _getPujaListUser() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + pujaList);

    Map<String, String> jsonBody = {
      "id": sessionManager.getUserId().toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PujaListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      _pujaList = [];
      _pujaList = dataResponse.pujaList!;
      _pujaList.reversed.toList();

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

}