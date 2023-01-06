import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/screen/AstrologyScreen.dart';
import 'package:kuber/screen/BookedPujaScreen.dart';
import 'package:kuber/screen/ChangePassWordScreen.dart';
import 'package:kuber/screen/DeleteAccountScreen.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/screen/MyAddresses.dart';
import 'package:kuber/screen/MyPofileScreen.dart';
import 'package:kuber/screen/PrayerRequestScreen.dart';
import 'package:kuber/screen/RashiScreen.dart';
import 'package:kuber/utils/app_utils.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/utils/session_manager_methods.dart';
import 'package:kuber/widget/loading.dart';

import '../model/CountryListResponseModel.dart';
import 'MatchMakingScreen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreen();
}

class _MyAccountScreen extends State<MyAccountScreen> {
  final bool _isLoading = false;
  final SessionManager _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bg_skin,
        appBar: setUpNavigationBar(),
        body: _isLoading
            ? const LoadingWidget()
            : Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 14, right: 14),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Account",
                    style: getTitleFontStyle()
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 14, right: 14, top: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: getSecondaryTitleFontStyle()
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4,right: 22,left: 22),
                          child:GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));
                            },
                            child: Column(
                                children:[
                                  _sessionManager.getImagePic() != null
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: light_yellow,
                                                width: 1
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(_sessionManager.getImagePic().toString()) ,
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        )
                                      : Image.asset("assets/images/ic_user_placeholder.png",height: 100,),
                                  Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child:  Text(
                                        "${_sessionManager.getName()} ${_sessionManager.getLastName() }",textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,color: title,fontSize: 14),)),
                                  Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        _sessionManager.getEmail().toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,color: title,fontSize: 12),)),
                                  Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        _sessionManager.getPhone().toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,color: title,fontSize: 12),))
                                  ]
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 16),
                          child: const Text('General',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: black), textAlign: TextAlign.left,),),
                        InkWell(
                          onTap:() async {
                            var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));

                            if (value)
                              {
                                setState((){});
                              }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                      children: [
                                        Image.asset("assets/images/ic_profile.png",height: 20,),
                                        Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                         child: const Text('My Profile',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                        const Spacer(),
                                        Image.asset("assets/images/ic_right.png",height: 14,),
                                      ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_address_new.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('My Addresses',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAddresses()));
                          },
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 16,top: 16),
                          child: const Text('Inquiry',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: black), textAlign: TextAlign.left,),),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_booked_prayer.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Booked Puja',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const BookedPujaScreen()));
                          },
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchMakingScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_match_making_list.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Match Making',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AstrologyScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_astrology_list.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Astrology',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RashiScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_rashi_list.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Rashi List',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PrayerRequestScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_prayer_request.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Prayer Request',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 16,top: 16),
                          child: const Text('About',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: black), textAlign: TextAlign.left,),),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_help.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Delete Account',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteAccountScreen()));
                          },
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6,bottom: 6),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/ic_help.png",height: 20,),
                                      Container(
                                          margin: const EdgeInsets.only(left: 14,right: 14),
                                          child: const Text('Change Password',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                      const Spacer(),
                                      Image.asset("assets/images/ic_right.png",height: 14,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14),
                                  child: const Divider(color: title,height: 0.5,),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassWordScreen()));
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6,bottom: 6),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/ic_terms.png",height: 20,),
                                    Container(
                                        margin: const EdgeInsets.only(left: 14,right: 14),
                                        child: const Text('Terms & Conditions',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                    const Spacer(),
                                    Image.asset("assets/images/ic_right.png",height: 14,),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 14),
                                child: const Divider(color: title,height: 0.5,),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 16,left: 22,right: 18),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6,bottom: 6),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/ic_privacy.png",height: 20,),
                                    Container(
                                        margin: const EdgeInsets.only(left: 14,right: 14),
                                        child: const Text('Privacy policy',style: TextStyle(fontWeight: FontWeight.w900,color: text_dark,fontSize: 14),)),
                                    const Spacer(),
                                    Image.asset("assets/images/ic_right.png",height: 14,),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 14),
                                child: const Divider(color: title,height: 0.5,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
    );
}

  PreferredSizeWidget setUpNavigationBar() {
    return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      backgroundColor: bg_skin,
      elevation: 0,
      leading:IconButton(
        icon: Image.asset("assets/images/ic_back_arrow.png",
            width: 18, height: 18),
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      ) ,
      actions: [
        IconButton(
          icon: Image.asset("assets/images/ic_logout_new.png",
              width: 18, height: 18),
          iconSize: 28,
          onPressed: () {
            _showLogoutBottomSheet();
          },
        )
      ],
    );
  }

  void _showLogoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                      width: 60,
                      margin: const EdgeInsets.only(top: 12),
                      child: const Divider(height: 1.5, thickness: 1.5,color: Colors.grey,)),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Logout", style: TextStyle(color: black, fontWeight: FontWeight.bold,fontSize: 17)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                    child: const Text("Are you sure you want to Logout?", style: TextStyle(color: black, fontWeight: FontWeight.w900,fontSize: 15),textAlign: TextAlign.justify,),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left:12,right: 12,bottom: 30,top:12),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(orange)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "No",
                                style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left:12,right: 12,bottom: 30,top:12),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SessionManagerMethods.clear();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(light_yellow)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "Yes",
                                style: TextStyle(color: black,fontSize: 14,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String countryCode = "+27";
  List<CountryListResponseModel> listCountryCode = [];
  List<CountryListResponseModel> listSearchCountryName = [];
  TextEditingController countryCodeSeachController = TextEditingController();

  countryDialog() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context){
          return StatefulBuilder(
              builder:(context, setState)
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
                          width: 50,
                          margin: const EdgeInsets.only(top: 12),
                          child: const Divider(
                            height: 1.5,
                            thickness: 1.5,
                            color: Colors.grey,
                          )),
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
                            if (listCountryCode != null && listCountryCode.length > 0)
                            {
                              listSearchCountryName = [];

                              if (editable.length > 0)
                              {
                                for (var i=0; i < listCountryCode.length; i++)
                                {
                                  if (listCountryCode[i].name.toLowerCase().contains(editable.toString().toLowerCase()))
                                  {
                                    listSearchCountryName.add(listCountryCode[i]);
                                  }
                                }
                              }
                              else
                              {

                              }
                              /*adapterCountry = AdapterCountry(activity, listSearchCountryName, dialog)
                              rvCountry.adapter = adapterCountry*/
                            }
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
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: listCountryCode.length,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                  onTap: (){
                                    setState((){
                                      countryCode = listCountryCode[i].dialCode;
                                    });
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
                                              Flexible(child: Text(listCountryCode[i].name.toString(),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w200,color: title), textAlign: TextAlign.start,)),
                                              Text(listCountryCode[i].dialCode.toString(),style: const TextStyle(fontWeight: FontWeight.w300,color: text_new,fontSize: 16),)
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
      dial_code = data[i]['dial_code'] != null ? data[i]['dial_code'] : "";
      listCountryCode.add(CountryListResponseModel(name: name, dialCode: dial_code, code: code));
    }
  }

}