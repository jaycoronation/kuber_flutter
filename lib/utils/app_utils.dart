import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kuber/constant/colors.dart';


/*show message to user*/
showSnackBar(String? message,BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message!),
          duration: const Duration(seconds: 1),
        ),
      );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

TextStyle getTextStyle({required FontWeight fontWeight, required Color color, required double fontSize}){
  return GoogleFonts.rubik(fontWeight: fontWeight, color: color, fontSize: fontSize);
}

TextStyle getTitleFontStyle(){
  return GoogleFonts.rubik(fontWeight: FontWeight.w600, color: black, fontSize: 18);
}

TextStyle getSecondaryTitleFontStyle(){
  return GoogleFonts.rubik(fontWeight: FontWeight.w400, color: black, fontSize: 14);
}

String getCurrentYear() {
  String formattedDate = "0";
  var now = DateTime.now();
  var formatter = DateFormat('yyyy');
  formattedDate = formatter.format(now);
  return formattedDate;
  print(formattedDate); // 2016-01-25
}

String getCurrentDate(){
  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yyyy h:mm a');
  String formattedDate = formatter.format(now);
  print(formattedDate); // 2016-01-25
  return formattedDate;
}

String getDateFromTimestamp(String timeStamp){
  int timestamp = int.parse(timeStamp); // example timestamp
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); // convert timestamp to DateTime object

  String formattedDate = DateFormat('dd MMM, yyyy').format(date); // format DateTime object to desired date format

  print(formattedDate); // output: 2022-03-09
  return formattedDate;
}

showToast(String? message,BuildContext? context){
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: light_yellow,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

/*check email validation*/
bool isValidEmail(String? input) {
  try {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input!);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

isValidPhoneNumber(String? input)
{
  try {
    return RegExp(r'(0/91)?[7-9][0-9]{9}').hasMatch(input!);
  } catch (e) {
    if(kDebugMode){

      print(e);
    }
    return false;
  }
}

/*convert string to CamelCase*/
toDisplayCase (String str) {
  try {
    return str.toLowerCase().split(' ').map((word) {
        String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

String universalDateConverter(String inputDateFormat,String outputDateFormat, String date) {
  var outputDate = "";
  try {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat(outputDateFormat);
    outputDate = outputFormat.format(inputDate);
    print(outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
  } catch (e) {
  }
  return outputDate;
}

String getPrice(String str) {
  return "€$str";
}
