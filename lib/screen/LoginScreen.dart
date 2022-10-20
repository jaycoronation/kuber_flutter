
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
import 'package:kuber/model/LoginResponseModel.dart';
import 'package:kuber/model/SocialResponseModel.dart';
import 'package:kuber/screen/LoginWithEmailScreen.dart';
import 'package:kuber/screen/LoginWithOtpScreen.dart';
import 'package:kuber/screen/SignUpScreen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../model/VerifyOtpResponseModel.dart';
import '../utils/app_utils.dart';
import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final fb = FacebookLogin();
  String _keyHash = 'Unknown';
  SessionManager sessionManager = SessionManager();
  var  loginType = "";
  bool _isLoading = false;
  
  @override
  initState() {

    getKeyHash();

    super.initState();
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
          backgroundColor: bg_skin,
          appBar: AppBar(
            backgroundColor: bg_skin,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            title: const Text("Signup",
                style: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center),
            centerTitle: true,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.4),
                child: Container(
                  margin: const EdgeInsets.only(left: 30, right: 30,bottom: 10),
                  color: black,
                  height: 0.4,
                )
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 4, right: 30, left: 30),
                        decoration: const BoxDecoration(color: yellow,
                        borderRadius: BorderRadius.all(Radius.circular(18),),),
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
                            const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Temple/ Mandir",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen("Temple")));
                        },
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 3, right: 30, left: 30),
                      decoration: const BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: InkWell(
                        onTap: (){
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
                            const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Priest/ Pandit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      ),
                    ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 3, right: 30, left: 30),
                      decoration: const BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: InkWell(
                        onTap: (){
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
                            const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Host/ Yajman",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        ),
                      ),
                    ),
                  Row(
                      children: const [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(22, 32, 22, 32),
                            child: Divider(color: black),
                          ),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w600),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(22, 22, 22, 22),
                            child: Divider(color: black),
                          ),
                        ),
                      ],
                    ),
                  Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                          child: TextButton(
                              onPressed: () async {
                                User? user =
                                    await signInWithGoogle(context: context);
                                if (user != null) {
                                  /*_makeSocialLoginRequest(
                                      "Google",
                                      user.displayName.toString(),
                                      user.displayName.toString(),
                                      user.email.toString(),
                                      user.photoURL.toString());*/
                                }
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
                                children:  <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child:Container(
                                        margin: EdgeInsets.all(6),
                                          child: Image.asset("assets/images/ic_google_new.png",width: 25,height: 29,)),
                                  ),
                                  const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Continue with google",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                          ),
                        ),
                  Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
                      child: TextButton(
                              onPressed: (){
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
                        children:  <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Container(
                                margin: EdgeInsets.all(6),
                                child: Image.asset("assets/images/ic_facebook_new.png",width: 25,height: 29,)),
                          ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Continue with Facebook",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                          ),
                    ),
                  Container(
                        width: MediaQuery.of(context).size.width,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginWithOtpScreen()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Connect with Mobile",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.w400)),
                          ),
                        )),
                  Container(
                        width: MediaQuery.of(context).size.width,
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Login With Email",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: skin,
                                    fontWeight: FontWeight.w400)),
                          ),
                        )),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By signing up or operating an account,you \n agree to our ',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: text_dark),
                          children: <TextSpan>[
                            TextSpan(text: 'Privacy Policy', style: const TextStyle(fontWeight: FontWeight.w400, color: black),
                                recognizer: TapGestureRecognizer()..onTap = () => {

                                }),
                            const TextSpan(text: ' and'),
                            TextSpan(text: 'Terms of Service', style: const TextStyle(fontWeight: FontWeight.w400, color: black),
                                recognizer: TapGestureRecognizer()..onTap = () => {
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ]),
                ),
        ));
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
        print('Access token: ${accessToken?.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        /*// Get user profile image url
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');*/

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission

        if(email != null && email.isNotEmpty)
        {
          String firstName = "";
          String lastName = "";
          if(profile!.name !=null && profile.name!.isNotEmpty)
          {
            final splitted = profile.name.toString().split(' ');

            if(splitted.length > 0)
            {
              firstName = splitted[0];
              lastName = splitted[1];
            }
          }
          print("<><> FACEBOOK EMAIL: $email");
          print("<><> FACEBOOK NAME: ${profile.name!}");
          _makeSocialLoginRequest("1",firstName,lastName,email,"");
        }
        else
        {
          showSnackBar("Email not found.", context);
        }
        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

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
        try
        {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);
          user = userCredential.user;

          print("User GetSet $user");
          String? firstName = "";
          String? lastName = "";
          String? email ="";
          String? profilePic ="";
          firstName = user?.displayName ?? "";
          lastName = user?.displayName ?? "";
          email = user?.email ?? "";
          profilePic = user?.photoURL ?? "";

          _makeSocialLoginRequest("2",firstName,lastName,email,profilePic);
        }
        on FirebaseAuthException catch (e)
        {
          print(e);
          if (e.code == 'account-exists-with-different-credential') {
            // ...

          }
          else if (e.code == 'invalid-credential')
          {
            // ...
          }
        } catch (e)
        {
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

    print("++++++HAshKey$_keyHash");
  }

  _makeSocialLoginRequest(String loginType, String firstName, String lastName, String email, String image) async {

    setState(()
    {
      _isLoading = true;
    });

    signOut(context: context);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + socialLogin);

    Map<String, String> jsonBody = {
      'name': firstName + ""+ lastName,
      'mobile':" ",
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

      var getSet = Profile();
      getSet.id = dataResponse.user?.id;
      getSet.mobile = dataResponse.user?.mobile;
      getSet.profileType = "User";
      getSet.profilePic = dataResponse.user?.profilePic;
      getSet.city = dataResponse.user?.cityName;
      getSet.state = dataResponse.user?.stateName;
      getSet.country = dataResponse.user?.countryName;
      getSet.countryId = dataResponse.user?.countryId;
      getSet.stateId = dataResponse.user?.stateId;
      getSet.cityId = dataResponse.user?.stateId;
      getSet.email = dataResponse.user?.email;
      getSet.firstName = dataResponse.user?.firstName;
      getSet.lastName = dataResponse.user?.lastName;

      await sessionManager.createLoginSession(getSet);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardScreen()),(route) => false);

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
}
