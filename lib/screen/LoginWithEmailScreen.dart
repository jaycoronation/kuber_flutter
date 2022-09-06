import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/ForgotPasswordScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../model/Emal_login_response_model.dart';
import '../model/VerifyOtpResponseModel.dart';

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreen();
}

class _LoginWithEmailScreen extends State<LoginWithEmailScreen> {
  bool _isLoading = false;
  bool _passwordVisible = false;
  SessionManager sessionManager = SessionManager();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                              contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                              fillColor: white_blue,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                              filled: true,
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                  color: title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: white_blue),
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
                                fillColor: white_blue,
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    color: title,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900),
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
                        const Spacer(),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 30, left: 30),
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
                              )),
                        ),
                      ],
                    ),
                  ),
                )),
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

      var getSet = Profile();
      getSet.id = dataResponse.userId;
      getSet.mobile = dataResponse.mobile;
      getSet.profileType = dataResponse.type;
      getSet.profilePic = dataResponse.profilePic;
      getSet.city = dataResponse.cityName;
      getSet.state = dataResponse.stateName;
      getSet.country = dataResponse.countryName;
      getSet.countryId = dataResponse.countryId;
      getSet.stateId = dataResponse.stateId;
      getSet.cityId = dataResponse.stateId;
      getSet.email = dataResponse.email;
      getSet.firstName = dataResponse.firstName;
      getSet.lastName = dataResponse.lastName;

      await sessionManager.createLoginSession(getSet);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen()),(route) => false);
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
