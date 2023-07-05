import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/screen/VerifyOtpScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../model/CountryListResponseModel.dart';

class LoginWithOtpScreen extends StatefulWidget {
  const LoginWithOtpScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithOtpScreen> createState() => _LoginWithOtpScreen();
}

class _LoginWithOtpScreen extends State<LoginWithOtpScreen> {
    bool _isLoading = false;
  TextEditingController numberController = TextEditingController();

  @override
  void initState(){
    getCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kuber,
          appBar: setUpNavigationBar(),
          body: _isLoading
              ? const LoadingWidget()
              : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height-100,
                  child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(top: 10,right: 45,left: 45),
                          child: Row(
                            children: [
                               GestureDetector(
                                 child: Text(
                                     countryCode,
                                    style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14)
                              ),
                                 onTap: (){
                                   countryDialog();
                                 },
                               ),
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                child: const VerticalDivider(
                                  thickness: 1,
                                  color: black,
                                  indent: 18,
                                  endIndent: 18,
                                ),
                              ),
                              Flexible(
                                child:  TextField(
                                  maxLength: 12,
                                  controller: numberController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  cursorColor: black,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: black),),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: black),
                                      ),
                                      counterText: "",
                                      hintText: "Mobile Number",
                                      labelStyle: TextStyle(color: black)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20,left: 12,right: 12),
                          child: const Text('We will send you OTP via SMS,please enter OTP to continue',
                            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            margin: const EdgeInsets.only(bottom: 24, right: 30, left: 30),
                            decoration: const BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (numberController.text.isEmpty)
                                {
                                  showToast('Please enter mobile number', context);
                                }
                                else if (numberController.text.length <= 7)
                                {
                                  showToast('Please enter valid mobile number', context);
                                }
                                else if (numberController.text.length >= 13)
                                  {
                                    showToast('Please enter valid mobile number', context);
                                  }
                                else
                                {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _sendOTPApi();
                                }
                              },
                              child: const Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: skin,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                               bottom: 24, right: 30, left: 30),
                          width: MediaQuery.of(context).size.width,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By signing up or operating an account,you \n agree to our ',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: text_dark),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Privacy Policy',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => {}),
                                const TextSpan(text: ' and'),
                                TextSpan(
                                    text: 'Terms of Service',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => {}),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
        ));
  }

  _sendOTPApi() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + generateOtp);

    Map<String, String> jsonBody = {
      'mobile': numberController.value.text,
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(numberController.value.text)));
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
      leading: IconButton(
        icon: Image.asset("assets/images/ic_back_arrow.png",
            width: 18, height: 18),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      ),
      title: Text(
        "Login With Otp",
        style: getTextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 18)
      ),
      titleSpacing: 0,
    );
  }

    String countryCode = "+27";
    List<CountryListResponseModel> listCountryCode = [];
    List<CountryListResponseModel> listSearchCountryName = [];
    TextEditingController countryCodeSeachController = TextEditingController();

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
                        )),
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
                                fontSize: 18),
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
                                fontWeight: FontWeight.w600),
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
                          child: SingleChildScrollView(
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
