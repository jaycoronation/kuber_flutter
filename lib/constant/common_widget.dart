import 'package:flutter/material.dart';

import '../widget/GradientTextButton.dart';
import 'colors.dart';

getCommonButton(String text , VoidCallback onPressed){
  return GradientTextButton(text: text,onPressed: onPressed);
}

Widget getBackArrow(){
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.all(4),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('assets/images/ic_back_arrow.png', width: 48, height: 48,),
    ),
  );
}

Widget getTitle(String title){
  return Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 20),
  );
}