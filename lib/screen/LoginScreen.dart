import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/screen/LoginWithEmailScreen.dart';
import 'package:kuber/screen/WebViewContainer.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/common_widget.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryListResponseModel.dart';
import '../model/SocialResponseModel.dart';
import '../model/VerifyOtpResponseModel.dart';
import '../utils/app_utils.dart';
import 'DashboardScreen.dart';

import 'MyPofileScreen.dart';
import 'VerifyOtpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController numberController = TextEditingController();

  // final fb = FacebookLogin();
  String _keyHash = 'Unknown';
  SessionManager sessionManager = SessionManager();
  var loginType = "";
  bool _isLoading = false;
  String errorMessage = "";

  @override
  void initState() {
    printKeyHash();
    super.initState();
    getCountryData();
  }

  void printKeyHash() async{
    String? key=await FlutterFacebookKeyhash.getFaceBookKeyHash ??
        'Unknown platform version';
    print(key??"");

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(true);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kuber,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kuber,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.dark,
            ),
            backgroundColor: kuber,
            automaticallyImplyLeading: false,
            elevation: 0,
            // leading: InkWell(
            //     onTap: () {
            //       SystemNavigator.pop();
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 18, bottom: 18, left: 16),
            //       child: Image.asset('assets/images/Close-icon.png', color: darkbrown,),
            //     )
            // ),
            titleSpacing: 0,
            centerTitle: true,
            title: const Center(
              child: Text("Login or Sign up",
                  style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 18),
                  textAlign: TextAlign.center),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: _isLoading
                        ? const LoadingWidget()
                        : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              /*Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                                  child: Row(
                                    children:  <Widget>[
                                      Container(
                                          margin: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: puja
                                          ),
                                          child: Image.asset("assets/images/ic_puja_plate.png",width: 50,height: 55,)),
                                      Expanded(
                                        child: Text(
                                          "Your prayer bookings on your finger tips.",
                                          overflow: TextOverflow.clip,
                                          style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ), */
                              Container(height: 46,),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[2],
                                  color: kuber,
                                  border: Border.all(
                                    color: const Color(0xffd8d8cc),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(right: 20, left: 20),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        countryDialog();
                                      },
                                      child: Row(
                                        children: [
                                           Padding(
                                            padding: const EdgeInsets.only(left: 22.0),
                                            child: Text(countryCode,
                                                style: const TextStyle(
                                                    color: darkbrown,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16
                                                )
                                            ),
                                          ),
                                          Container(width: 4,),
                                          Image.asset('assets/images/aerrow_down.png', color: darkbrown, width: 16,),
                                          Container(width: 10,),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child:
                                      TextField(
                                        maxLength: 12,
                                        controller: numberController,
                                        textAlign: TextAlign.left,
                                        keyboardType: TextInputType.number,
                                        cursorColor: black,
                                        decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                            counterText: "",
                                            hintText: "Mobile Number",
                                            labelStyle: TextStyle(color: darkbrown)
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 18, top: 18),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'By signing up or operating an account,you agree to our \n ',
                                      style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14, height: 1.4),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Privacy Policy', style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://panditbookings.com/privacy_policy', 'Privacy Policy')));
                                          }
                                        ),
                                        const TextSpan(text: ' and ', style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),),
                                        TextSpan(
                                          text: 'Terms of Service', style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://panditbookings.com/terms-and-conditions', 'Terms of Service')));
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 12,),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0, right: 18),
                                child: getCommonButton('Continue', () {
                                  FocusScope.of(context).unfocus();
                                  if (numberController.text.isEmpty) {
                                    showToast('Please enter mobile number', context);
                                  }
                                  else if (numberController.text.length <= 7) {
                                    showToast('Please enter valid mobile number', context);
                                  }
                                  else if (numberController.text.length >= 13) {
                                    showToast('Please enter valid mobile number', context);
                                  }
                                  else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _sendOTPApi();
                                  }
                                }),
                              ),
                              Visibility(
                                visible: false,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12),),
                                        gradient: LinearGradient(
                                          colors: [gradient_start, gradient_end],
                                        )
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        if (numberController.text.isEmpty) {
                                          showToast('Please enter mobile number', context);
                                        }
                                        else if (numberController.text.length <= 7) {
                                          showToast('Please enter valid mobile number', context);
                                        }
                                        else if (numberController.text.length >= 13) {
                                          showToast('Please enter valid mobile number', context);
                                        }
                                        else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          _sendOTPApi();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent),
                                      child: const Text('Continue', style: TextStyle(color: darkbrown, fontSize: 16),),
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: 22,),
                              const Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                                      child: Divider(color: black),
                                    ),
                                  ),
                                  Text(
                                    "or",
                                    style:TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 16),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                                      child: Divider(color: black),
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 22,),
                              GestureDetector(
                                onTap: () async {
                                  print("GOOGLE LOGIN");
                                  signInWithGoogle(context: context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only( right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: kuber,
                                    border: Border.all(
                                      color: const Color(0xffd8d8cc),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children:  <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:Container(
                                            margin: const EdgeInsets.all(12),
                                            child: Image.asset("assets/images/Google-icon.png",width: 25,height: 29,)),
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue with Google",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w500, color: darkbrown, fontSize: 16),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(height: 18,),
                              /*GestureDetector(
                                onTap: () {
                                  loginFB();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only( right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: kuber,
                                    border: Border.all(
                                      color: const Color(0xffd8d8cc),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children:  <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:Container(
                                            margin: const EdgeInsets.all(12),
                                            child: Image.asset("assets/images/Facebook-icon.png",width: 25,height: 29,)),
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue with Facebook",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w500, color: darkbrown, fontSize: 16),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(height: 18,),
                              Visibility(
                                visible: Platform.isIOS,
                                child: GestureDetector(
                                  onTap: () {
                                    loginFB();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only( right: 20, left: 20, bottom: 18),
                                    decoration: BoxDecoration(
                                      color: kuber,
                                      border: Border.all(
                                        color: const Color(0xffd8d8cc),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children:  <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:Container(
                                              margin: const EdgeInsets.all(12),
                                              child: Image.asset("assets/images/Apple-icon.png",width: 25,height: 29,)),
                                        ),
                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Continue with Apple",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.w500, color: darkbrown, fontSize: 16),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),*/
/*
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithEmailScreen()));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only( right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    color: kuber,
                                    border: Border.all(
                                      color: const Color(0xffd8d8cc),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children:  <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:Container(
                                            margin: const EdgeInsets.all(12),
                                            child: Image.asset("assets/images/Email-icon.png",width: 25,height: 29,)),
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue with Email",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w500, color: darkbrown, fontSize: 16),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
*/
                              Container(height: 18,),


                           /*   Container(
                                margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                                child: TextButton(
                                  onPressed: () async {
                                    signInWithGoogle(context: context);
                                    //FirebaseCrashlytics.instance.crash();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(sky_blue)
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: const EdgeInsets.all(6),
                                            child: Image.asset("assets/images/ic_google_new.png", width: 25, height: 29,)),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue with Google",
                                            textAlign: TextAlign.center,
                                            style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                                child: TextButton(
                                  onPressed: () {
                                    loginWithFaceBook();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(darkblue)
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            margin: const EdgeInsets.all(6),
                                            child: Image.asset("assets/images/ic_facebook_new.png", width: 25, height: 29,)),
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue with Facebook",
                                            textAlign: TextAlign.center,
                                            style: getTextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 14),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: Platform.isIOS,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                                  child: TextButton(
                                    onPressed: () {
                                      logIn();
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                              margin: const EdgeInsets.all(6),
                                              child: const Icon(
                                                Icons.apple_sharp,
                                                color: white,
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Continue with Apple",
                                              textAlign: TextAlign.center,
                                              style: getTextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 14),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets.only(top: 14, bottom: 14, right: 30, left: 30),
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithOtpScreen()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Connect with Mobile",
                                        style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                      ),
                                    ),
                                  )
                              ),
                              Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets.only(bottom: 14, right: 30, left: 30),
                                  child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(black)
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithEmailScreen()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Login With Email",
                                        style: getTextStyle(fontWeight: FontWeight.w500, color: skin, fontSize: 14),
                                      ),
                                    ),
                                  )
                              ), */
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithEmailScreen()));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: const Color(0xff702828),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft:  Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xff702828),
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.only(bottom: 18,top: 18),
                                child: const Text(
                                  "Login as Priest / Pandit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 16),
                                )
                            ),
                          )

                        /*  Row(
                            children: [
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                                  child: Divider(color: black),
                                ),
                              ),
                              Text(
                                "Register as",
                                style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                              ),
                              const Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                                  child: Divider(color: black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: const EdgeInsets.only(top: 10, bottom: 3, right: 18, left: 18),
                            decoration: const BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Image.asset(
                                        "assets/images/ic_priest_blank.png",
                                        width: 55,

                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Priest/ Pandit",
                                          textAlign: TextAlign.center,
                                          style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 4, right: 12, left: 12),
                                  decoration: const BoxDecoration(color: yellow,
                                    borderRadius: BorderRadius.all(Radius.circular(12),),),
                                  child: InkWell(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 20, right: 20),
                                            child: Image.asset(
                                              "assets/images/ic_temple_blank.png",
                                              width: 55,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Temple/ Mandir",
                                                textAlign: TextAlign.center,
                                                style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                              )),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Temple")));
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                children: [

                                  Container(height: 6,),
                                ],
                              ),
                              Visibility(
                                visible: false,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 3, right: 12, left: 12),
                                      decoration: const BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Yajman")));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding: const EdgeInsets.only(left: 20, right: 20),
                                                child: Image.asset(
                                                  "assets/images/ic_host.png",
                                                  width: 55,

                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: false,
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Host / Yajman",
                                                    textAlign: TextAlign.center,
                                                    style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(height: 6,),
                                    Text(
                                      "Host / Yajman",
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ), */
                        ]
                    ),
                  ),
                ),
              );
            },
          ),
            // bottomNavigationBar:

        )
    );
  }

  /*Future<void> loginFB() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
  }*/


  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    }
    else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      print("googleSignIn ===== $googleSignIn");

      try {
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      } on Exception catch (e) {
        print("ERROR OCCUR ==== $e");
      }
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      print("googleSignInAccount ===== $googleSignInAccount");
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);
          user = userCredential.user;

          print("User GetSet $user");
          String? firstName = "";
          String? lastName = "";
          String? email = "";
          String? profilePic = "";
          firstName = user?.displayName ?? "";
          lastName = user?.displayName ?? "";
          email = user?.email ?? "";
          profilePic = user?.photoURL ?? "";

          _makeSocialLoginRequest("2", firstName, lastName, email, profilePic);
        }
        on FirebaseAuthException catch (e) {
          print("error ==== $e");
          if (e.code == 'account-exists-with-different-credential') {
            // ...

          }
          else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar('Error signing out. Try again.', context),
      );
    }
  }

  Future<void> getKeyHash() async {
    String keyHash;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      keyHash = await FlutterFacebookKeyhash.getFaceBookKeyHash ??
          'Unknown platform KeyHash';
    } on PlatformException {
      keyHash = 'Failed to get Kay Hash.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _keyHash = keyHash;
    });

    print("++++++HashKey$_keyHash");
  }

  _makeSocialLoginRequest(String loginType, String firstName, String lastName, String email, String image) async {
    setState(() {
      _isLoading = true;
    });

    signOut(context: context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + socialLogin);

    Map<String, String> jsonBody = {
      'name': "$firstName $lastName",
      'mobile': "",
      'login_type': loginType,
      'from_app': "true",
      'email': email,
      'profile_pic': image,
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SocialResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      Profile getSetData = Profile();

      getSetData.userId = dataResponse.user?.userId ?? '';
      getSetData.mobile = dataResponse.user?.mobile;

      getSetData.profilePic = dataResponse.user?.profilePic;
      getSetData.countryId = dataResponse.user?.countryId;
      getSetData.stateId = dataResponse.user?.stateId;
      getSetData.cityId = dataResponse.user?.stateId;
      getSetData.email = dataResponse.user?.email;
      getSetData.firstName = dataResponse.user?.firstName;
      getSetData.lastName = dataResponse.user?.lastName;
      getSetData.countryCode = dataResponse.user?.countryCode;
      getSetData.type = "User";

      await sessionManager.createLoginSession(getSetData);

      sessionManager.setUserId(dataResponse.user?.userId.toString() ?? "");
      print(dataResponse.user!.mobile.toString());
      print(dataResponse.user!.email.toString());
      if(dataResponse.user?.mobile?.toString().isEmpty ?? true)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyProfileScreen(true)), (route) => false);
      }
      else
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
      }
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

  _sendOTPApi() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + generateOtp);

    Map<String, String> jsonBody = {
      'mobile': numberController.value.text,
      'country_code': countryCode
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
      //context.goNamed(AppRoutes.otpRoute,pathParameters:  {'mobileNumber': numberController.value.text, 'countryCode': countryCode});
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(mobileNumber: numberController.value.text, countryCode: countryCode)));
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(loginResponse.message, context);
    }
  }

  PreferredSizeWidget setUpNavigationBar() {
    return AppBar(
      toolbarHeight: 50,
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
      title: getTitle("Login With Otp"),
      titleSpacing: 0,
    );
  }

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog() {
    print(listCountryCode.length);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder:(context, updateState)
              {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.88,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      )
                  ),
                  child: Column(
                    children:  [
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        height: 1,
                        width: 40,
                        color: text_light,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          "Select Country Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: title,
                              fontSize: 18
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20,bottom: 10,left: 14,right: 14),
                        child: TextField(
                          controller: countryCodeSeachController,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                              color: title,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                          onChanged: (editable){
                            setState((){
                              if (listCountryCode != null && listCountryCode.length > 0) {
                                listSearchCountryName = [];

                                if (editable.length > 0) {
                                  for (var i = 0; i <
                                      listCountryCode.length; i++) {
                                    if (listCountryCode[i].name.toLowerCase()
                                        .contains(
                                        editable.toString().toLowerCase())) {
                                      listSearchCountryName.add(
                                          listCountryCode[i]);
                                    }
                                  }
                                }
                                else {

                                }
                              }
                            });
                            /*adapterCountry = AdapterCountry(activity, listSearchCountryName, dialog)
                              rvCountry.adapter = adapterCountry*/
                          },
                          decoration: InputDecoration(
                            fillColor: white_blue,
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none
                                )
                            ),
                            filled: true,
                            hintText: "Search",
                            hintStyle: const TextStyle(
                              color: text_dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: listSearchCountryName.isNotEmpty ? listSearchCountryName.length : listCountryCode.length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: (){
                                  setState((){
                                    countryCode = listSearchCountryName.isNotEmpty ? listSearchCountryName[i].dialCode : listCountryCode[i].dialCode;
                                  });
                                  print(countryCode);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 14, right: 14),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(child: Text( listSearchCountryName.isNotEmpty ? listSearchCountryName[i].name : listCountryCode[i].name.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w200,color: title), textAlign: TextAlign.start,)),
                                            Text(listSearchCountryName.isNotEmpty ? listSearchCountryName[i].dialCode : listCountryCode[i].dialCode.toString(),style: const TextStyle(fontWeight: FontWeight.w300,color: text_new,fontSize: 16),)
                                          ],
                                        ),
                                      ),
                                      const Divider(height: 1,color: text_light,indent: 1,)
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        });
  }

  List data = [];

  Future<void> getCountryData() async {
    var jsonText = await rootBundle.loadString('assets/countries.json');
    setState(() => data = json.decode(jsonText));
    var name = "";
    var code = "";
    var dial_code = "";
    for (var i=0; i < data.length; i++)
    {
      name = data[i]['name'];
      code = data[i]['code'];
      dial_code = data[i]['dial_code'] ?? "";
      listCountryCode.add(CountryListResponseModel(name: name, dialCode: dial_code, code: code));
    }
  }
}


