import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/common_widget.dart';
import '../model/CountryListResponseModel.dart';
import '../utils/responsive.dart';
import '../widget/loading.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {

  final String strtype;
  const SignUpScreen( this.strtype,{Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {

  TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryCodeSeachController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = true;
  String selectedDate = "Pick Date";
  double width = 700;

  @override
  void initState(){
    getCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget.isSmallScreen(context)
        ? WillPopScope(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: bg_skin,
              appBar: AppBar(
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
                title: getTitle("Sign Up"),
              ),
              body: _isLoading
                  ? const LoadingWidget()
                  : Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18),
                          child: Column(
                            children: [
                              Container(height: 32,),
                              TextField(
                                controller: firstNameController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  labelText: ' First Name',
                                  labelStyle: TextStyle(color: darkbrown),
                                ),
                              ),
                              Container(height: 18,),
                              TextField(
                                controller: lastNameController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  labelText: ' Last Name',
                                  labelStyle: TextStyle(color: darkbrown),
                                ),
                              ),
                              Container(height: 18,),
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  labelText: ' Email',
                                  labelStyle: TextStyle(color: darkbrown),
                                ),
                              ),
                              Container(height: 18,),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(left: 14, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),

                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: Text(countryCode,
                                          style: const TextStyle(
                                              color: text_dark,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                      onTap: (){
                                        countryDialog();
                                      },
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 20,
                                      width: 1,
                                      color: text_light,
                                    ),
                                    Flexible(
                                      child:TextField(
                                        controller: numberController,
                                        maxLength: 12,
                                        keyboardType: TextInputType.number,
                                        cursorColor: text_dark,
                                        style: const TextStyle(
                                            color: title,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(left:15,top:20,bottom:20),
                                          fillColor: bottomSheetBg,
                                          counterText: "",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14.0),
                                              borderSide: const BorderSide(
                                                  width: 0, style: BorderStyle.none)),
                                          filled: true,
                                          hintText: "Mobile Number",
                                          hintStyle: const TextStyle(
                                            color: darkbrown,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(height: 18,),
                              TextField(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now(),
                                      helpText: 'Preferred Move Date',
                                      );
                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                                    //you can implement different kind of Date Format here according to your requirement
                                    setState(() {
                                      selectedDate = formattedDate;
                                      dobController.text = formattedDate;
                                    });
                                  }
                                },
                                controller: dobController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.grey,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  labelText: ' Date Of Birth',
                                  labelStyle: TextStyle(color: darkbrown),
                                ),
                              ),
                              Container(height: 18,),
                              TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: Colors.grey,
                                obscureText: _passwordVisible ? true : false,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(color: Colors.grey)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: Colors.grey,),
                                  ),
                                  labelText: ' Password',
                                  labelStyle: TextStyle(color: darkbrown),
                                  suffixIcon:IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ?Icons.visibility
                                          :Icons.visibility_off,color: text_dark,),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),


                              /* Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin: const EdgeInsets.only(
                              top: 18, right: 30, left: 30),
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          decoration: const BoxDecoration(
                            color: white_blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: TextField(
                              controller: lastNameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              cursorColor: text_dark,
                              style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "Last Name",
                                  hintStyle: TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin: const EdgeInsets.only(
                              top: 18, right: 30, left: 30),
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          decoration: const BoxDecoration(
                            color: white_blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: TextField(
                              controller: emailController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              cursorColor: text_dark,
                              style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Container(
                          height: 55,
                          margin: const EdgeInsets.only(top: 14, right: 30, left: 30),
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          decoration: const BoxDecoration(
                            color: white_blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  countryDialog();
                                },
                                child: Text(countryCode.toString(),
                                    style: const TextStyle(
                                        color: text_dark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                              ),
                              Container(
                                margin:
                                const EdgeInsets.only(left: 10, right: 10),
                                child: const VerticalDivider(
                                  thickness: 1,
                                  color: text_light,
                                  indent: 18,
                                  endIndent: 18,
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                    controller: numberController,
                                    keyboardType: TextInputType.number,
                                    cursorColor: text_dark,
                                    maxLength: 12,
                                    style: const TextStyle(
                                      color: text_dark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "Mobile number",
                                        hintStyle: TextStyle(
                                          color: text_dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ))),
                              )
                            ],
                          ),
                        ),*/
                              /* Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin: const EdgeInsets.only(
                              top: 18, right: 30, left: 30),
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          decoration: const BoxDecoration(
                            color: white_blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child:  TextField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                    helpText: 'Preferred Move Date',
                                    builder: (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme:  const ColorScheme.dark(
                                            primary: black,
                                            onPrimary: white,
                                            surface: text_light,
                                            onSurface: title,
                                          ),
                                          dialogBackgroundColor: white,
                                        ),
                                        child: child!,
                                      );
                                    });
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                                  //you can implement different kind of Date Format here according to your requirement
                                  setState(() {
                                    selectedDate = formattedDate;
                                    dobController.text = formattedDate;
                                  });
                                }
                              },
                              controller: dobController,
                              readOnly: true,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              cursorColor: text_dark,
                              style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "Date of Birth",
                                  hintStyle: TextStyle(
                                    color: text_dark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ))),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 55,
                          margin: const EdgeInsets.only(
                              top: 18, right: 30, left: 30),
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          decoration: const BoxDecoration(
                            color: white_blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              textAlign: TextAlign.start,
                              obscureText: _passwordVisible ? true : false,
                              enableSuggestions: false,
                              autocorrect: false,
                              cursorColor: text_dark,
                              style: const TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                suffixIcon:IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ?Icons.visibility
                                        :Icons.visibility_off,color: text_dark,),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              )
                          ),
                        ),*/
                              Container(height: 32,),

                              Container(
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
                                    if (firstNameController.text.isEmpty)
                                    {
                                      showToast('Please enter first name', context);}
                                    else if (lastNameController.text.isEmpty)
                                    {
                                      showToast('please enter valid last name', context);
                                    }
                                    else if(emailController.text.isEmpty)
                                    {
                                      showToast('Please enter email address', context);
                                    }
                                    else if(numberController.text.isEmpty)
                                    {
                                      showToast('Please enter mobile number', context);
                                    }else if (numberController.text.length <= 7)
                                    {
                                      showToast('Please enter valid mobile number', context);
                                    }
                                    else if (numberController.text.length >= 13)
                                    {
                                      showToast('Please enter valid mobile number', context);
                                    }
                                    else if(passwordController.text.isEmpty)
                                    {
                                      showToast('Please enter your password', context);
                                    }
                                    else
                                    {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      _signUpApi();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: const Text('Sign Up', style: TextStyle(color: darkbrown, fontSize: 16),),
                                ),
                              ),

    /*
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            margin: const EdgeInsets.only(top: 44, right: 30, left: 30),
                            decoration: const BoxDecoration(
                              color: light_yellow,
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (firstNameController.text.isEmpty)
                                {
                                  showToast('Please enter first name', context);}
                                else if (lastNameController.text.isEmpty)
                                {
                                  showToast('please enter valid last name', context);
                                }
                                else if(emailController.text.isEmpty)
                                {
                                  showToast('Please enter email address', context);
                                }
                                else if(numberController.text.isEmpty)
                                {
                                  showToast('Please enter mobile number', context);
                                }else if (numberController.text.length <= 7)
                                {
                                  showToast('Please enter valid mobile number', context);
                                }
                                else if (numberController.text.length >= 13)
                                {
                                  showToast('Please enter valid mobile number', context);
                                }
                                else if(passwordController.text.isEmpty)
                                {
                                  showToast('Please enter your password', context);
                                }
                                else
                                {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _signUpApi();
                                }
                              },
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: text_dark,
                                      fontWeight: FontWeight.w400)),
                            )),
    */
                            ],
                          ),
                        ),
                      )),
                  /*Container(
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
                            text: " Log In",
                            style: const TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                Navigator.pop(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
                              }),
                      ]),
                    )),*/
                ],
              )
          ),
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
        )
        :  WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: bg_skin,
          appBar: AppBar(
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
            title: getTitle("Sign Up"),
          ),
          body: _isLoading
              ? const LoadingWidget()
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.only(
                          top: 28, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child:  TextField(
                          controller: firstNameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "First Name",
                              hintStyle: TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
    */
                          Container(height: 32,),
                          Container(
                            width: width,
                            child: TextField(
                              controller: firstNameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: ' First Name',
                                labelStyle: TextStyle(color: darkbrown),
                              ),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            width: width,
                            child: TextField(
                              controller: lastNameController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: ' Last Name',
                                labelStyle: TextStyle(color: darkbrown),
                              ),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            width: width,
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: ' Email',
                                labelStyle: TextStyle(color: darkbrown),
                              ),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            width: width,
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 14, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),

                              borderRadius: const BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: Text(countryCode,
                                      style: const TextStyle(
                                          color: text_dark,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  onTap: (){
                                    countryDialog();
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 20,
                                  width: 1,
                                  color: text_light,
                                ),
                                Flexible(
                                  child:TextField(
                                    controller: numberController,
                                    maxLength: 12,
                                    keyboardType: TextInputType.number,
                                    cursorColor: text_dark,
                                    style: const TextStyle(
                                        color: title,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left:15,top:20,bottom:20),
                                      fillColor: bottomSheetBg,
                                      counterText: "",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14.0),
                                          borderSide: const BorderSide(
                                              width: 0, style: BorderStyle.none)),
                                      filled: true,
                                      hintText: "Mobile Number",
                                      hintStyle: const TextStyle(
                                        color: darkbrown,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            width: width,
                            child: TextField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                    helpText: 'Preferred Move Date',
                                    );
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                                  //you can implement different kind of Date Format here according to your requirement
                                  setState(() {
                                    selectedDate = formattedDate;
                                    dobController.text = formattedDate;
                                  });
                                }
                              },
                              controller: dobController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.grey,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: ' Date Of Birth',
                                labelStyle: TextStyle(color: darkbrown),
                              ),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            width: width,
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Colors.grey,
                              obscureText: _passwordVisible ? true : false,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(color: Colors.grey)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.grey,),
                                ),
                                labelText: ' Password',
                                labelStyle: TextStyle(color: darkbrown),
                                suffixIcon:IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ?Icons.visibility
                                        :Icons.visibility_off,color: text_dark,),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          /* Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.only(
                          top: 18, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: TextField(
                          controller: lastNameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Last Name",
                              hintStyle: TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.only(
                          top: 18, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: TextField(
                          controller: emailController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
                    Container(
                      height: 55,
                      margin: const EdgeInsets.only(top: 14, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              countryDialog();
                            },
                            child: Text(countryCode.toString(),
                                style: const TextStyle(
                                    color: text_dark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          ),
                          Container(
                            margin:
                            const EdgeInsets.only(left: 10, right: 10),
                            child: const VerticalDivider(
                              thickness: 1,
                              color: text_light,
                              indent: 18,
                              endIndent: 18,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                                controller: numberController,
                                keyboardType: TextInputType.number,
                                cursorColor: text_dark,
                                maxLength: 12,
                                style: const TextStyle(
                                  color: text_dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "Mobile number",
                                    hintStyle: TextStyle(
                                      color: text_dark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ))),
                          )
                        ],
                      ),
                    ),*/
                          /* Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.only(
                          top: 18, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child:  TextField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now(),
                                helpText: 'Preferred Move Date',
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme:  const ColorScheme.dark(
                                        primary: black,
                                        onPrimary: white,
                                        surface: text_light,
                                        onSurface: title,
                                      ),
                                      dialogBackgroundColor: white,
                                    ),
                                    child: child!,
                                  );
                                });
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
                              //you can implement different kind of Date Format here according to your requirement
                              setState(() {
                                selectedDate = formattedDate;
                                dobController.text = formattedDate;
                              });
                            }
                          },
                          controller: dobController,
                          readOnly: true,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          cursorColor: text_dark,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Date of Birth",
                              hintStyle: TextStyle(
                                color: text_dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.only(
                          top: 18, right: 30, left: 30),
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      decoration: const BoxDecoration(
                        color: white_blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          textAlign: TextAlign.start,
                          obscureText: _passwordVisible ? true : false,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: text_dark,
                          style: const TextStyle(
                            color: text_dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: text_dark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon:IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ?Icons.visibility
                                    :Icons.visibility_off,color: text_dark,),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          )
                      ),
                    ),*/
                          Container(height: 32,),

                          Container(
                            width: width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(14),),
                                gradient: LinearGradient(
                                  colors: [gradient_start, gradient_end],
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (firstNameController.text.isEmpty)
                                  {
                                    showToast('Please enter first name', context);}
                                  else if (lastNameController.text.isEmpty)
                                  {
                                    showToast('please enter valid last name', context);
                                  }
                                  else if(emailController.text.isEmpty)
                                  {
                                    showToast('Please enter email address', context);
                                  }
                                  else if(numberController.text.isEmpty)
                                  {
                                    showToast('Please enter mobile number', context);
                                  }else if (numberController.text.length <= 7)
                                  {
                                    showToast('Please enter valid mobile number', context);
                                  }
                                  else if (numberController.text.length >= 13)
                                  {
                                    showToast('Please enter valid mobile number', context);
                                  }
                                  else if(passwordController.text.isEmpty)
                                  {
                                    showToast('Please enter your password', context);
                                  }
                                  else
                                  {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    _signUpApi();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                child: const Text('Sign Up', style: TextStyle(color: darkbrown, fontSize: 18),),
                              ),
                            ),
                          ),

    /*
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: const EdgeInsets.only(top: 44, right: 30, left: 30),
                        decoration: const BoxDecoration(
                          color: light_yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (firstNameController.text.isEmpty)
                            {
                              showToast('Please enter first name', context);}
                            else if (lastNameController.text.isEmpty)
                            {
                              showToast('please enter valid last name', context);
                            }
                            else if(emailController.text.isEmpty)
                            {
                              showToast('Please enter email address', context);
                            }
                            else if(numberController.text.isEmpty)
                            {
                              showToast('Please enter mobile number', context);
                            }else if (numberController.text.length <= 7)
                            {
                              showToast('Please enter valid mobile number', context);
                            }
                            else if (numberController.text.length >= 13)
                            {
                              showToast('Please enter valid mobile number', context);
                            }
                            else if(passwordController.text.isEmpty)
                            {
                              showToast('Please enter your password', context);
                            }
                            else
                            {
                              setState(() {
                                _isLoading = true;
                              });
                              _signUpApi();
                            }
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: text_dark,
                                  fontWeight: FontWeight.w400)),
                        )),
    */
                        ],
                      ),
                    ),
                  ),
                  /*Container(
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
                            text: " Log In",
                            style: const TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                Navigator.pop(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
                              }),
                      ]),
                    )),*/
                ],
          )
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
    );
  }

  _signUpApi() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + signUp);

    Map<String, String> jsonBody = {
      'first_name': firstNameController.value.text,
      'last_name': lastNameController.value.text,
      'email': emailController.value.text,
      'mobile': numberController.value.text,
      'password': passwordController.value.text,
      'country_code': countryCode,
      'country': "",
      'state': "",
      'city': "",
      'address':"",
      'gender': "0",
      'type':widget.strtype,
      'lat': numberController.value.text,
      'lng': "",
      'location': "",
      'birthdate': dobController.value.text,
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

      showToast(dataResponse.message, context);
      Navigator.pop(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(()
      {
        _isLoading = false;
      });
      showToast(dataResponse.message, context);
    }
  }

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];

  countryDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder:(context, setState)
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
                          width: 50,
                          margin: const EdgeInsets.only(top: 12),
                          child: const Divider(
                            height: 1.5,
                            thickness: 1.5,
                            color: Colors.grey,
                          )
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
                            if (listCountryCode != null && listCountryCode.length > 0)
                            {
                              listSearchCountryName = [];

                              if (editable.isNotEmpty)
                                {
                                  for (var i=0; i < listCountryCode.length; i++)
                                  {
                                    if (listCountryCode[i].name.toLowerCase().contains(editable.toString().toLowerCase()))
                                    {
                                      listSearchCountryName.add(listCountryCode[i]);
                                    }
                                  }
                                }
                              else
                                {
                                  listSearchCountryName = [];
                                }
                              setState((){});
                              /*adapterCountry = AdapterCountry(activity, listSearchCountryName, dialog)
                              rvCountry.adapter = adapterCountry*/
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: white_blue,
                            counterText: "",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
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
         dial_code = data[i]['dial_code'] != null ? data[i]['dial_code'] : "";
         listCountryCode.add(CountryListResponseModel(name: name, dialCode: dial_code, code: code));
      }
  }

}
