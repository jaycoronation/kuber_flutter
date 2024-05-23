import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bg_skin,
        appBar: AppBar(
          backgroundColor: bg_skin,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset("assets/images/ic_back_arrow.png",
                width: 18, height: 18),
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _isLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 90),
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                        child: Image.asset(
                          "assets/images/ic_kuber.png",
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Enter your email address and we will send you a \n password recover link.",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: title),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 26, right: 26, top: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: white_blue),
                        padding: const EdgeInsets.all(4),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: title,
                          style: const TextStyle(
                              color: title,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: title,
                                fontSize: 14,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 40, bottom: 14, right: 30, left: 30),
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                              ),
                              onPressed: () {
                               _forgotPasswordApi();
                              },
                              child: const Text("Send Link",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.w400)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }


  _forgotPasswordApi() async {

    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + forgotPassword);

    Map<String, String> jsonBody = {
      'email': emailController.value.text,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

      showToast(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
       Navigator.pop(context);
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }
}
