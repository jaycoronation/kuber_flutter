import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/model/PujaDetailsResponseModel.dart';
import 'package:kuber/screen/PujaListScreen.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';

class PujaDetailsScreen extends StatefulWidget {

  final String pujaId;
  const PujaDetailsScreen(this. pujaId, {Key? key}) : super(key: key);

  @override
  State<PujaDetailsScreen> createState() => _PujaDetailsScreen();
}

class _PujaDetailsScreen extends State<PujaDetailsScreen> {
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();
  Puja puja = Puja();

  @override
  void initState() {
    _getPujaDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bg_skin,
          appBar:  AppBar(
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 55,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading: IconButton(
              icon:
              Image.asset("assets/images/ic_back_arrow.png", width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
               Navigator.pop(context);
              },
            ),
            title: const Text(
              "Puja Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black),
              textAlign: TextAlign.center,
            ),
          ),
          body: _isLoading
              ?const  LoadingWidget()
              :Column(
             children: [
              Container(
                margin: const EdgeInsets.only(right: 16,left: 16,top: 14,bottom: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(puja.pujaName.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: black),textAlign: TextAlign.start,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(puja.pujaDescription.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: black),textAlign: TextAlign.start,),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Divider(height: 1,color: text_light,indent: 1,),
                    )
                  ],
                ),

              ),
            ],
          )
        ),
        onWillPop: () {
      Navigator.pop(context);
      return Future.value(true);
    },
    );
  }

  _getPujaDetails() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + getPujaDetailstUser);

    Map<String, String> jsonBody = {
      "user_id": sessionManager.userId,
      "puja_id": widget.pujaId
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PujaDetailsResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.success != null) {
        puja = dataResponse.puja!;
      }
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
      showToast(dataResponse.message, context);
    }
  }
}