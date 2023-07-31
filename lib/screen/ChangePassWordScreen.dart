
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../utils/session_manager.dart';
import '../widget/loading.dart';
import 'SignUpScreen.dart';

class ChangePassWordScreen extends StatefulWidget {
  const ChangePassWordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassWordScreen> createState() => _ChangePassWordScreen();
}

class _ChangePassWordScreen extends State<ChangePassWordScreen> {
  bool _isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassWordController = TextEditingController();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  SessionManager sessionManager = SessionManager();

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
           ?  const LoadingWidget()
           :  SingleChildScrollView(
         child: Column(
           children: [
             Container(
               alignment: Alignment.center,
               height: 55,
               margin: const EdgeInsets.only(
                   top: 18, right: 14 ,left: 14),

               decoration: const BoxDecoration(
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
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                       borderSide:  BorderSide(color: Colors.grey,),
                     ),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide:  BorderSide(color: Colors.grey)
                     ),
                     counterText: "",
                     // border: InputBorder.none,
                     hintText: "Enter New Password",
                     hintStyle: const TextStyle(
                       color: darkbrown,
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
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
             ),
             Container(
               alignment: Alignment.center,
               height: 55,
               margin: const EdgeInsets.only(
                   top: 18, right: 14, left: 14),
               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.all(
                   Radius.circular(18),
                 ),
               ),
               child: TextField(
                   keyboardType: TextInputType.visiblePassword,
                   controller: confirmPassWordController,
                   textAlign: TextAlign.start,
                   obscureText: _confirmPasswordVisible ? true : false,
                   enableSuggestions: false,
                   autocorrect: false,
                   cursorColor: text_dark,
                   style: const TextStyle(
                     color: text_dark,
                     fontSize: 14,
                     fontWeight: FontWeight.w600,
                   ),
                   decoration: InputDecoration(
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                       borderSide:  BorderSide(color: Colors.grey,),
                     ),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide:  BorderSide(color: Colors.grey)
                     ),
                     counterText: "",
                     // border: InputBorder.none,
                     hintText: "Enter Confirm Password",
                     hintStyle: const TextStyle(
                       color: darkbrown,
                       fontSize: 14,
                       fontWeight: FontWeight.w500,
                     ),
                     suffixIcon:IconButton(
                       icon: Icon(
                         _confirmPasswordVisible
                             ?Icons.visibility
                             :Icons.visibility_off,color: text_dark,),
                       onPressed: () {
                         setState(() {
                           _confirmPasswordVisible = !_confirmPasswordVisible;
                         });
                       },
                     ),
                   )
               ),
             ),
             Container(
                 margin: EdgeInsets.only(top: 18,right: 14,left: 14),
                 width: MediaQuery.of(context).size.width,
                 child: TextButton(
                   style: ButtonStyle(
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18.0),
                         ),
                       ),
                       backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                   ),
                   onPressed: (){
                     validation();
                   },
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Update Password",style: TextStyle(color: text_dark,fontWeight: FontWeight.w600,fontSize: 15),),
                   ),
                 )
             ),
           ],
         ),
       )

    ),
         onWillPop: () {
       Navigator.pop(context);
       return Future.value(true);
     });
  }

   void validation(){
     if(passwordController.text.isEmpty)
     {
       showToast("Please enter password", context);
       return;
     }
     if (confirmPassWordController.text.isEmpty)
     {
       showToast("Please enter confirm password", context);
       return;
     }
     if(passwordController.text != confirmPassWordController.text)
     {
       showToast("Password doesn't match please try again", context);
       return;
     }
     changePasswordApi();
   }

  changePasswordApi() async {
    setState(()
    {
      _isLoading = true;
    });

    var  userType = "";
    if(sessionManager.getIsPujrai() == true){

      userType = "Pujari";
    } else if(sessionManager.getIsTemple() == true){
      userType =  "Temples";
    }else
    {
      userType =  "User";
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + changePassword);

    Map<String, String> jsonBody = {
      "id": sessionManager.getUserId().toString() ,
      "type": userType ,
      "password": passwordController.value.text,
      "confirm_password": confirmPassWordController.value.text,
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataresponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataresponse.success == 1) {
      showToast(dataresponse.message, context);
      Navigator.pop(context);
        _isLoading = false;
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
    }
    showToast(dataresponse.message, context);
  }

}