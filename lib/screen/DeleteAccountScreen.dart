
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreen();
}

class _DeleteAccountScreen extends State<DeleteAccountScreen> {
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bg_skin,
          appBar:AppBar(
            // systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 55,
            automaticallyImplyLeading: false,
            backgroundColor: bg_skin,
            elevation: 0,
            leading:IconButton(
              icon: Image.asset("assets/images/ic_back_arrow.png",
                  width: 18, height: 18),
              iconSize: 28,
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ) ,
          ),
          body: _isLoading
              ? const LoadingWidget()
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12),
                child: Text("You're about to delete your account", style: TextStyle(color: black,fontWeight: FontWeight.w900,fontSize: 17),),
              ),
              Container(
                margin: EdgeInsets.only(top:12,left: 12,right: 6),
                child: const Text("All the data associated with it(including your profile,photo, reviews and subscriptions) will be permanently deleted in 30 days. this information can't be recovered once the account is deleted.",
                  style: TextStyle(color: text_light,fontSize: 12,fontWeight: FontWeight.w400),),
              ),
              Container(
                  margin: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                    ),
                    onPressed: (){
                      _getDeleteAccountApi();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Delete my account now",style: TextStyle(color: text_dark,fontWeight: FontWeight.w600,fontSize: 15),),
                    ),
                  )
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top:12,left: 12,right: 6),
                child: Text("Back to Settings",style: TextStyle(color: black,fontWeight: FontWeight.w900,fontSize: 14)),
              )
            ],
          )
        ),
        onWillPop: (){
          Navigator.pop(context);
          return Future.value(true);
        });
  }

  _getDeleteAccountApi() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deletAccount  );

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString(),
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var bookingResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && bookingResponse.success == 1) {

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(bookingResponse.message, context);
    }
  }

}