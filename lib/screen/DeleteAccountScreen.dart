import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/utils/session_manager_methods.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/common_widget.dart';

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
              toolbarHeight: 55,
              automaticallyImplyLeading: false,
              backgroundColor: bg_skin,
              elevation: 0,
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: getBackArrow(),
              ),
              centerTitle: true,
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
                      child: Text("You're about to delete your account",
                        style: getTitleFontStyle()),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:12,left: 12,right: 6),
                      child: Text("All the data associated with it(including your profile,photo, reviews and subscriptions) will be permanently deleted in 30 days. this information can't be recovered once the account is deleted.",
                        style: getSecondaryTitleFontStyle()),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      child: getCommonButton('Delete my account now', () {_showDeleteBottomSheet(); }),
                    ),
                    Visibility(
                      visible: false,
                      child: Container(
                          margin: const EdgeInsets.all(12),
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
                              // _getDeleteAccountApi();
                              _showDeleteBottomSheet();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Delete my account now",style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 15),),
                            ),
                          )
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   margin: const EdgeInsets.only(top:12,left: 12,right: 12),
                    //   child: const Text("Back to Settings",style: TextStyle(color: black,fontWeight: FontWeight.w900,fontSize: 14)),
                    // )
                  ],
                )
          ),
          onWillPop: (){
            Navigator.pop(context);
            return Future.value(true);
          }
        );
  }


  void _showDeleteBottomSheet() {
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
                    child: const Text("Delete account ", style: TextStyle(color: black, fontWeight: FontWeight.bold,fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to Delete account now?", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 15),textAlign: TextAlign.justify,),
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
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "No",
                                style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),
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
                            onPressed: (){
                              _getDeleteAccountApi();
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
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Yes",
                                style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.bold),
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



  _getDeleteAccountApi() async {
    setState(() {
      _isLoading = true;
    });

    print("User Id"+ sessionManager.getUserId().toString());

    var  userType = "";
    if(sessionManager.getIsPujrai() == true){
      userType = "Pujari";
    } else if(sessionManager.getIsTemple() == true){
      userType =  "Temples";
    }else {
      userType =  "User";
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + deletAccount);

    Map<String, String> jsonBody = {
      'id':sessionManager.getUserId().toString(),
      'type': userType
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var bookingResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && bookingResponse.success == 1) {

      SessionManagerMethods.clear();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
      setState(()
      {
        _isLoading = false;
      });
    }
    else {
      setState(()
      {
        _isLoading = false;
      });
      showToast(bookingResponse.message, context);
    }
  }

}