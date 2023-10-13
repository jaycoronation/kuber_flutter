import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kuber/screen/DashboardForWeb.dart';
import 'package:kuber/utils/routes.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/CountryListResponseModel.dart';
import '../model/SocialResponseModel.dart';
import '../model/VerifyOtpResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import 'DashboardScreen.dart';
import 'LoginWithEmailScreen.dart';
import 'MyPofileScreen.dart';
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
  final fb = FacebookLogin();


  @override
  void initState(){
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
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Login or Sign up",
                    style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 32),
                    textAlign: TextAlign.center),
                Container(height: 55,),
                Container(
                  width: 700,
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[2],
                    color: kuber,
                    border: Border.all(
                      color: const Color(0xffd8d8cc),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                          onSubmitted: (value) {
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
                        style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 18, height: 1.4),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Privacy Policy', style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 18),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                var iosUrl = Uri.parse("https://panditbookings.com/privacy_policy");
                                if (await canLaunchUrl(iosUrl))
                                {
                                await launchUrl(iosUrl);
                                }
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://panditbookings.com/privacy_policy', 'Privacy Policy')));
                              }
                          ),
                          const TextSpan(text: ' and ', style: TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 18),),
                          TextSpan(
                              text: 'Terms of Service', style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 18),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                var iosUrl = Uri.parse("https://www.panditbookings.com/terms-and-conditions/");
                                if (await canLaunchUrl(iosUrl))
                                {
                                await launchUrl(iosUrl);
                                }
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewContainer('https://panditbookings.com/terms-and-conditions', 'Terms of Service')));
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 12,),
                Container(
                  width: 700,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12),),
                      gradient: LinearGradient(
                        colors: [gradient_start, gradient_end],
                      )
                  ),
                  child: TextButton(
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
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0 , 22,0 ,22),
                      textStyle: const TextStyle(fontSize: 22, color: darkbrown, fontWeight: FontWeight.w600),
                    ),
                    child:_isLoading
                        ? CircularProgressIndicator(color: white,strokeWidth: 4,)
                        : const Text('Continue', style: TextStyle(color: darkbrown, fontSize: 16),),
                  ),
                ),
                Container(height: 22,),
                 Container(
                   width: 700,
                   child: Row(
                    children: const [
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
                 ),
                Container(height: 22,),
                Container(
                  width: 700,
                  child: GestureDetector(
                    onTap: () async {
                      //User? user = await _signInWithGoogle(context: context);
                      _signInWithGoogle(context);

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
                ),
                Container(height: 18,),
                Container(
                  width: 700,
                  child: GestureDetector(
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
                                child: Image.asset("assets/images/Facebook-icon.png",width: 25,height: 29,)
                            ),
                          ),
                          const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Continue with Facebook",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w500, color: darkbrown, fontSize: 16),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 32,),
              ],
            ),

          ]
      ),
      bottomNavigationBar: GestureDetector(
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
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await Firebase.initializeApp(
          name: "Kuber",
          options: const FirebaseOptions(
              apiKey: "AIzaSyDxM-G38CFYtCYbS3ND3fZlirLRKBOoXQc",
              authDomain: "kuber-167ed.firebaseapp.com",
              projectId: "kuber-167ed",
              storageBucket: "kuber-167ed.appspot.com",
              messagingSenderId: "951814205337",
              appId: "1:951814205337:web:904e57267945c244f52d08",
              measurementId: "G-R0QNF2TEQG"
          )
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential authResult = await _auth.signInWithPopup(googleProvider);
      final User? user = authResult.user;

      print("User GetSet $user");
      String? firstName = "";
      String? lastName = "";
      String? email = "";
      String? profilePic = "";
      firstName = user?.displayName ?? "";
      lastName = user?.displayName ?? "";
      email = user?.email ?? "";
      profilePic = user?.photoURL ?? "";
      _auth.signOut();
      _makeSocialLoginRequest("2", firstName, lastName, email, profilePic);
      print('Signed in with Google: ${user?.displayName}');
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb)
    {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential = await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    }
    else
    {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

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

          // _makeSocialLoginRequest("2", firstName, lastName, email, profilePic);
        }
        on FirebaseAuthException catch (e) {
          print(e);
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


  _sendOTPApi() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + generateOtp);

    Map<String, String> jsonBody = {
      'mobile': numberController.value.text,
      'country_code': countryCode
    };

    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }
        ,body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var loginResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && loginResponse.success == 1) {
      setState(() {
        _isLoading = false;
      });
      // GoRouter.of(context).go(AppRoutes.otpRoute);
      // context.go(AppRoutes.otpRoute,extra:  {'mobileNumber': numberController.value.text, 'countryCode': countryCode});
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtpScreen(countryCode: countryCode,mobileNumber: numberController.value.text,)));
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

                            updateState((){
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

  Future<void> loginFB() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
      // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<void> loginWithFaceBook() async {
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;

        // Get profile data
        final profile = await fb.getUserProfile();

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission

        if (email != null && email.isNotEmpty) {
          String firstName = "";
          String lastName = "";
          if (profile!.name != null && profile.name!.isNotEmpty) {
            final splitted = profile.name.toString().split(' ');

            if (splitted.isNotEmpty) {
              firstName = splitted[0];
              lastName = splitted[1];
            }
          }
          _makeSocialLoginRequest("1", firstName, lastName, email, "");
        }
        else {
          showSnackBar("Email not found.", context);
        }
        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        break;
    }
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
      getSetData.mobile = dataResponse.user?.mobile ?? '';

      getSetData.profilePic = dataResponse.user?.profilePic ?? '';
      getSetData.countryId = dataResponse.user?.countryId ?? '';
      getSetData.stateId = dataResponse.user?.stateId ?? '';
      getSetData.cityId = dataResponse.user?.stateId ?? '';
      getSetData.email = dataResponse.user?.email ?? '';
      getSetData.firstName = dataResponse.user?.firstName ?? '';
      getSetData.lastName = dataResponse.user?.lastName ?? '';
      getSetData.countryCode = dataResponse.user?.countryCode ?? '';
       getSetData.type =  dataResponse.user?.type ?? '';

      await sessionManager.createLoginSession(getSetData);

      sessionManager.setUserId(dataResponse.user?.userId.toString() ?? "");
      print(dataResponse.user!.mobile.toString());
      print(dataResponse.user!.email.toString());
      if(dataResponse.user?.mobile?.toString().isEmpty ?? true)
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyProfileScreen(true)), (route) => true);
      }
      else
      {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardForWeb()), (route) => true);
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



}