
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
       child: Scaffold(
         backgroundColor:darkbrown,
         appBar: AppBar(
           systemOverlayStyle: const SystemUiOverlayStyle(
             statusBarColor: darkbrown,
             statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
             statusBarBrightness: Brightness.dark,
           ) ,
           backgroundColor:darkbrown ,
           automaticallyImplyLeading: false,
           elevation: 0,
           titleSpacing: 0,
           title: const Center(
             child: Text("Dashboard",
                 style: TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 20),
                 textAlign: TextAlign.center),
           ),
           actions: [
             Padding(
               padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
               child: Image.asset('assets/image/ic_back_arrow.png', color: darkbrown),
             )
           ],
         ),
         body: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.only(left: 18.0, right: 18),
             child: Column(
               children: [
                 Container(height: 48,),
                 Image.asset('assets/images/Maharaj.png', width: 190,),
                 Container(height: 18,),
                 Container(
                   width: MediaQuery.of(context).size.width,
                   decoration: const BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(12),) ,
                       gradient: LinearGradient(
                         colors: [gradient_start, gradient_end],
                       )
                   ),
                   child: ElevatedButton(
                     onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                     },
                     style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.transparent,
                         shadowColor: Colors.transparent),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Image.asset('assets/image/Done-icon.png', width: 32,),
                         Container(width: 14,),
                         const Text('Book A Priest', style: TextStyle(color: darkbrown, fontSize: 16),),
                       ],
                     ),
                   ),
                 ),
                 Container(height: 18,),

                 Row(
                   children: [
                     Flexible(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             children: [
                               Image.asset('assets/image/Temples.jpg',width: 110, ),
                               Container(height: 8,),
                               const Text('TEMPLE', style: TextStyle(color: darkbrown, fontSize: 14, fontWeight: FontWeight.w600 ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             children: [
                               Image.asset('assets/image/Temples.jpg',width: 110, ),
                               Container(height: 8,),
                               const Text('TEMPLE', style: TextStyle(color: darkbrown, fontSize: 14, fontWeight: FontWeight.w600 ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             children: [
                               Image.asset('assets/image/Temples.jpg',width: 110, ),
                               Container(height: 8,),
                               const Text('TEMPLE', style: TextStyle(color: darkbrown, fontSize: 14, fontWeight: FontWeight.w600 ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
                 Container(height: 18,),

                 Row(
                   children: [
                     Flexible(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             children: [
                               Image.asset('assets/image/Temples.jpg',width: 110, ),
                               Container(height: 8,),
                               const Text('TEMPLE', style: TextStyle(color: darkbrown, fontSize: 14, fontWeight: FontWeight.w600 ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Column(
                             children: [
                               Image.asset('assets/image/Temples.jpg',width: 110, ),
                               Container(height: 8,),
                               const Text('TEMPLE', style: TextStyle(color: darkbrown, fontSize: 14, fontWeight: FontWeight.w600 ),),
                             ],
                           ),
                         ],
                       ),
                     ),
                     Flexible(
                       child: Container(),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       ),
     onWillPop: (){
       Navigator.pop(context,true);
       return Future.value(true);
     },
   );
  }

}