import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/VerifyOtpResponseModel.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/common_widget.dart';
import '../model/CommonResponseModel.dart';
import '../utils/responsive.dart';
import '../utils/routes.dart';
import 'DashboardForWeb.dart';
import 'MyPofileScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? mobileNumber;
 final String? countryCode;

  VerifyOtpScreen({Key? key, this.mobileNumber, this.countryCode}) : super(key: key);


  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreen();
}

class _VerifyOtpScreen extends State<VerifyOtpScreen> {
  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;
  String strPin = "";
  int _start = 60;
  late Timer _timer;
  String otp = "";
  bool visibilityResend = false;
  double width = 700;


  @override
  void initState(){
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
      ?  WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kuber,
        appBar: setUpNavigationBar(),
        body: _isLoading
            ? const LoadingWidget()
            : Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 42, right: 10, top: 20),
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          "OTP send to ${widget.mobileNumber} ",
                          style: const TextStyle(
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 42, top: 50),
                          child: Text(
                            "Enter OTP",
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: text_dark,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          blinkWhenObscuring: true,
                          autoDismissKeyboard: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            fieldOuterPadding:
                            const EdgeInsets.only(left: 8),
                            borderRadius: BorderRadius.circular(10.0),
                            borderWidth: 2,
                            fieldHeight: 60,
                            fieldWidth: 30,
                            activeColor: black,
                            selectedColor: black,
                            disabledColor: text_dark,
                            inactiveColor: text_light,
                            activeFillColor: kuber,
                            selectedFillColor: kuber,
                            inactiveFillColor: kuber,
                          ),
                          cursorColor: Colors.black,
                          animationDuration:
                          const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            _verifyOtpApi(v);
                          },
                          onChanged: (value) {
                            setState(() {
                              strPin = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 6, left: 4),
                            child: Text("00:$_start",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                )
                            )
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 26, right: 26, top: 32, bottom: 12),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)
                            ),
                            backgroundColor: black,
                            minimumSize: const Size.fromHeight(55),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (otp.isEmpty)
                            {
                              showSnackBar('Please enter otp', context);
                            }
                            else if (otp.length != 4)
                            {
                              showSnackBar('Please enter valid otp', context);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              _verifyOtpApi(otp);
                            }
                          },
                          child: const Text(
                            "Verify Otp",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500,color: skin),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            visibilityResend ? Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.0),
                                ),
                              ),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _sendOTPApi();
                                },
                                child: const Text(
                                  "Resend Otp",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    )
        :  WillPopScope(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kuber,
            appBar: setUpNavigationBar(),
            body: _isLoading
                ? const LoadingWidget()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 42, right: 10, top: 20),
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              "OTP send to ${widget.mobileNumber} ",
                              style: const TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 42, top: 50),
                              child: Text(
                                "Enter OTP",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: text_dark,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: false,
                              blinkWhenObscuring: true,
                              autoDismissKeyboard: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                fieldOuterPadding:
                                const EdgeInsets.only(left: 8),
                                borderRadius: BorderRadius.circular(10.0),
                                borderWidth: 2,
                                fieldHeight: 60,
                                fieldWidth: 30,
                                activeColor: black,
                                selectedColor: black,
                                disabledColor: text_dark,
                                inactiveColor: text_light,
                                activeFillColor: kuber,
                                selectedFillColor: kuber,
                                inactiveFillColor: kuber,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                              const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                _verifyOtpApi(v);
                              },
                              onChanged: (value) {
                                setState(() {
                                  strPin = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                return true;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 6, left: 4),
                                child: Text("00:$_start",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 26, right: 26, top: 32, bottom: 12),
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)
                                ),
                                backgroundColor: black,
                                minimumSize: const Size.fromHeight(55),
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (otp.isEmpty)
                                {
                                  showSnackBar('Please enter otp', context);
                                }
                                else if (otp.length != 4)
                                {
                                  showSnackBar('Please enter valid otp', context);
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _verifyOtpApi(otp);
                                }
                              },
                              child: const Text(
                                "Verify Otp",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500,color: skin),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                visibilityResend ? Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 1.0),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      _sendOTPApi();
                                    },
                                    child: const Text(
                                      "Resend Otp",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
        );

  }

  PreferredSizeWidget setUpNavigationBar() {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 50,
      automaticallyImplyLeading: false,
      backgroundColor: kuber,
      elevation: 0,
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: getBackArrow(),
      ),
      centerTitle: true,
      title: getTitle("Verify OTP"),
    );
  }

  _verifyOtpApi(String otp) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + verifyOtp);

    Map<String, String> jsonBody = {
      'mobile': widget.mobileNumber.toString(),
      'otp': otp,
      'country_code' : widget.countryCode.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = VerifyOtpResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      setState(() {
        _isLoading = false;
      });
      await sessionManager.createLoginSession(dataResponse.profile!);
      sessionManager.setUserId(dataResponse.profile?.userId.toString() ?? "");
      print(dataResponse.profile!.mobile.toString());
      print(dataResponse.profile!.email.toString());

      getNextScreen(dataResponse);

    }
    else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            visibilityResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _sendOTPApi() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + generateOtp);

    Map<String, String> jsonBody = {
      'mobile': widget.mobileNumber.toString(),
      'county_code' :widget.countryCode.toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var loginResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && loginResponse.success == 1) {
      setState(() {
        _isLoading = false;
      });
      context.goNamed(AppRoutes.otpRoute,pathParameters:  {'mobileNumber': widget.mobileNumber.toString(), 'countryCode': widget.countryCode.toString()});
      //Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(widget.mobileNumber, widget.countryCode)));
    } else {
      setState(() {
        _isLoading = false;
      });
      showToast(loginResponse.message, context);
    }
  }

  void getNextScreen(VerifyOtpResponseModel dataResponse) {

    if (kIsWeb)
    {
      if(dataResponse.profile?.email?.toString().isEmpty ?? true)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyProfileScreen(true)), (route) => false);
      }
      else
      {
        GoRouter.of(context).go(AppRoutes.homeRoute);
      }
    }
    else
    {
      if(dataResponse.profile?.email?.toString().isEmpty ?? true)
      {
        //GoRouter.of(context).go(AppRoutes.loginRoute);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyProfileScreen(true)), (route) => false);
      }
      else
      {
        print("IS IN DASHBOARD");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
      }
    }

  }
}
