import 'package:flutter/material.dart';

import '../constant/colors.dart';

class GradientTextButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const GradientTextButton({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        minimumSize: WidgetStateProperty.all(Size.zero),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: WidgetStateProperty.all(BorderSide.none),
        foregroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                gradient_start,
                gradient_end
              ],
            )
        ),
        child: isLoading
            ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 13,bottom: 13),
              child: SizedBox(width: 16,height: 16,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
            )
            :  Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 11,bottom: 11),
              child: Text(
                text,
                style: const TextStyle(color: darkbrown, fontSize: 14,fontWeight: FontWeight.w600)
              ),
            ),
      ),
    );
  }
}
