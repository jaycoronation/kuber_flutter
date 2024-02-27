import 'package:flutter/material.dart';

import '../constant/colors.dart';

class GradientTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: MaterialStateProperty.all(BorderSide.none),
        foregroundColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Text(
            text,
            style: const TextStyle(color: darkbrown, fontSize: 14,fontWeight: FontWeight.w600)
          ),
        ),
      ),
    );
  }
}
