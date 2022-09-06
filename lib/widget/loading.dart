import 'package:flutter/material.dart';

import '../constant/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                //child: Padding(padding: const EdgeInsets.all(1),child: Lottie.asset('assets/images/loading_new.json',height: 300,repeat: true,animate: true,frameRate: FrameRate.max),),
                child: const Center(
                  child: CircularProgressIndicator(color: black),),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Loading...', style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 14),
            )
          ],
        ));
  }
}
