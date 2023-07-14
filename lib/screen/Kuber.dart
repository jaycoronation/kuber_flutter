

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors.dart';
import 'WebViewContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor:kuber,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: kuber,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.dark,
            ) ,
            backgroundColor:kuber ,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                  child: Image.asset('assets/image/ic_back_arrow.png', color: darkbrown),
                )
            ),
            titleSpacing: 0,
            title: const Center(
              child: Text("Login or Sign up",
                  style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 18),
                  textAlign: TextAlign.center),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 26,),
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
                  margin: const EdgeInsets.only(right: 20,left: 20),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 22.0),
                        child: Text("+91" ,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                            )
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: black,
                        indent: 1,
                        endIndent: 1,
                      ),
                      Flexible(
                        child:  TextField(
                          maxLength: 12,
                          controller: numberController,
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.number,
                          cursorColor: black,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Colors.transparent),
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
                Center(
                  child: Container(
                    padding:  const EdgeInsets.only(bottom: 18,top: 18),
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
                          const TextSpan(text: ' and ',style:TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14),),
                          const TextSpan(text: 'Terms of Service.', style: TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),

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
                        borderRadius: BorderRadius.all(Radius.circular(12),) ,
                        gradient: LinearGradient(
                          colors: [gradient_start, gradient_end],
                        )
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text('Continue', style: TextStyle(color: darkbrown, fontSize: 16),),
                    ),
                  ),
                ),
                Container(height: 22,),
                Row(
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
                Container(height: 22,),

                Container(
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
                            child: Image.asset("assets/image/ic_back_arrow.png",width: 25,height: 29,)),
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
                Container(height: 18,),
                Container(
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
                            child: Image.asset("assets/image/ic_back_arrow.png",width: 25,height: 29,)),
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
                Container(height: 18,),
                Container(
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
                            child: Image.asset("assets/image/ic_back_arrow.png",width: 25,height: 29,)),
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
                Container(height: 18,),
                Container(
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
                            child: Image.asset("assets/image/ic_back_arrow.png",width: 25,height: 29,)),
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
              ],
            ),
          ),
          bottomNavigationBar: Container(
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
              "Register as Priest/ Pandit",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, color: white, fontSize: 16),
            )
          )
          ),
      onWillPop: (){
        Navigator.pop(context,true);
        return Future.value(true);
      },
    );
  }

}