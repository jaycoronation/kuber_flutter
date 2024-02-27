import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/ForgotPasswordScreen.dart';
import 'package:kuber/screen/PujariDashboard.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/common_widget.dart';
import '../model/Emal_login_response_model.dart';
import '../model/VerifyOtpResponseModel.dart';
import '../utils/responsive.dart';
import 'SignUpScreen.dart';

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreen();
}

class _LoginWithEmailScreen extends State<LoginWithEmailScreen> {
  bool _isLoading = false;
  bool _passwordVisible = true;
  double width = 700;
  SessionManager sessionManager = SessionManager();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? WillPopScope(
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
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: getBackArrow(),
            ),
          ),
          body: LayoutBuilder(
              builder: (context, constraints){
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 14, left: 16, right: 14),
                            child: const Text(
                              'Hi, Welcome Back',
                              style: TextStyle(
                                  fontSize: 28,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: title,
                              style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                fillColor: Colors.transparent,
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(12.0),
                                //     borderSide: const BorderSide(
                                //         width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                    color: darkbrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),),
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _passwordVisible ? true : false,
                              enableSuggestions: false,
                              autocorrect: false,
                              cursorColor: title,
                              style: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                  // fillColor: white_blue,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  counterText: "",
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(12.0),
                                  //     borderSide: const BorderSide(
                                  //         width: 0, style: BorderStyle.none)),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                      color: darkbrown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: text_dark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(top: 14,right: 16),
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.topRight,
                              child: const Text(
                                'Forgot your Password?',
                                style: TextStyle(
                                    color: text_dark,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                            },
                          ),
                          Container(height: 26,),

                          Container(
                            margin: const EdgeInsets.only(right: 18, left: 18),
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
                            child: TextButton(
                              onPressed: () {
                                if(emailController.text.isEmpty)
                                {
                                  showToast("Please enter email address", context);
                                }
                                else if(passwordController.text.isEmpty)
                                {
                                  showToast("Please enter password", context);
                                }
                                else
                                {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _loginApi();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: const Text('Log in', style: TextStyle(color: darkbrown, fontSize: 16),),
                            ),
                          ),



                          /* Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 18, left: 18),
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
                                  if(emailController.text.isEmpty)
                                  {
                                    showToast("Please enter email address", context);
                                  }
                                  else if(passwordController.text.isEmpty)
                                  {
                                    showToast("Please enter password", context);
                                  }
                                  else
                                  {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _loginApi();
                                  }
                                },
                                child: const Text("Log In",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: black,
                                        fontWeight: FontWeight.w600)),
                              )),*/
                          Spacer(),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
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
                                  "Register as Priest / Pandit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 16),
                                )
                            ),
                          )
/*
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 18),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      const TextSpan(
                                        text:
                                        "Already have an account?",
                                        style: TextStyle(
                                            color: title,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                          text: " Sing Up",
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                          ),
                                    ]),
                                  )),
                            ),
*/



                        ],
                      ),
                    ),
                  ),
                );
              }

          )),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    )
        : WillPopScope(
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
                leading: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: getBackArrow(),
                ),
              ),
              body: LayoutBuilder(
                  builder: (context, constraints){
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 14, left: 16, right: 14),
                                child: Center(
                                  child: const Text(
                                    'Hi, Welcome Back',
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: darkbrown,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(height: 36,),
                              Container(
                                width: width,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: title,
                                  style: const TextStyle(
                                      color: title,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  decoration:  InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(color: Colors.grey,),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                    fillColor: Colors.transparent,
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(12.0),
                                    //     borderSide: const BorderSide(
                                    //         width: 0, style: BorderStyle.none)),
                                    filled: true,
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Container(
                                width: width,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),),
                                child: TextField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _passwordVisible ? true : false,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  cursorColor: title,
                                  style: const TextStyle(
                                      color: title,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                      // fillColor: white_blue,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide: const BorderSide(color: Colors.grey)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.grey,),
                                      ),
                                      counterText: "",
                                      // border: OutlineInputBorder(
                                      //     borderRadius: BorderRadius.circular(12.0),
                                      //     borderSide: const BorderSide(
                                      //         width: 0, style: BorderStyle.none)),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                          color: darkbrown,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: text_dark,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      )),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: width,
                                  margin: const EdgeInsets.only(top: 14,right: 16),
                                  padding: const EdgeInsets.all(4),
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    'Forgot your Password?',
                                    style: TextStyle(
                                        color: text_dark,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                                },
                              ),
                              Container(height: 26,),

                              Container(
                                margin: const EdgeInsets.only(right: 18, left: 18),
                                width: width,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12),),
                                    gradient: LinearGradient(
                                      colors: [gradient_start, gradient_end],
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(emailController.text.isEmpty)
                                      {
                                        showToast("Please enter email address", context);
                                      }
                                      else if(passwordController.text.isEmpty)
                                      {
                                        showToast("Please enter password", context);
                                      }
                                      else
                                      {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _loginApi();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    child: const Text('Log in', style: TextStyle(color: darkbrown, fontSize: 16),),
                                  ),
                                ),
                              ),
                              Container(height: 36,),


                              /* Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 18, left: 18),
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
                                      if(emailController.text.isEmpty)
                                      {
                                        showToast("Please enter email address", context);
                                      }
                                      else if(passwordController.text.isEmpty)
                                      {
                                        showToast("Please enter password", context);
                                      }
                                      else
                                      {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        _loginApi();
                                      }
                                    },
                                    child: const Text("Log In",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: black,
                                            fontWeight: FontWeight.w600)),
                                  )),*/


                             /*
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 18),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: <TextSpan>[
                                          const TextSpan(
                                            text:
                                            "Already have an account?",
                                            style: TextStyle(
                                                color: title,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                              text: " Sing Up",
                                              style: const TextStyle(
                                                  color: black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                              ),
                                        ]),
                                      )),
                                ),
    */



                            ],
                          ),
                        ),
                      ),
                    );
                  }

              ),
              bottomNavigationBar:  GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Priest")));
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
                    "Register as Priest / Pandit",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 16),
                  )
              ),
            ),
          ),
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
        );
  }

  _loginApi() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + login);

    Map<String, String> jsonBody = {
      'username': emailController.value.text,
      'password': passwordController.value.text,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = EmalLoginResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

      print(dataResponse.type);

      var getSet = Profile();
      getSet.userId = dataResponse.userId;
      getSet.mobile = dataResponse.mobile;
      getSet.type = dataResponse.type;
      getSet.profilePic = dataResponse.profilePic;
      getSet.countryId = dataResponse.countryId;
      getSet.stateId = dataResponse.stateId;
      getSet.cityId = dataResponse.stateId;
      getSet.email = dataResponse.email;
      getSet.firstName = dataResponse.firstName;
      getSet.lastName = dataResponse.lastName;
      getSet.birthdate = dataResponse.birthdate;
      getSet.countryCode = dataResponse.countryCode;

      await sessionManager.createLoginSession(getSet);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PujariDashboard()),(route) => false);
      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }
}
