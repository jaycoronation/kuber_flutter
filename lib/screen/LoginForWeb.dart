import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryListResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import 'LoginWithEmailScreen.dart';
import 'VerifyOtpScreen.dart';
import 'WebViewContainer.dart';

class LoginScreenForWeb extends StatefulWidget {
  const LoginScreenForWeb({Key? key}) : super(key: key);

  @override
  State<LoginScreenForWeb> createState() => _LoginScreenForWeb();
}

class _LoginScreenForWeb extends State<LoginScreenForWeb> {

  TextEditingController numberController = TextEditingController();
  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;


  @override
  void initState(){
    super.initState();
    getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        titleSpacing: 0,
        centerTitle: true,
        title: const Center(
          child: Text("Login or Sign up",
              style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 18),
              textAlign: TextAlign.center),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
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
                                borderSide: BorderSide(color: Colors.transparent),),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                    //signInWithGoogle(context: context);
                    //FirebaseCrashlytics.instance.crash();
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
                GestureDetector(
                  onTap: () {
                    //loginWithFaceBook();
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
          ]
      ),
    );
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(numberController.value.text, countryCode)));
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(loginResponse.message, context);
    }
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