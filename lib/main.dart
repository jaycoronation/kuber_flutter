import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/utils/session_manager_methods.dart';
import 'package:firebase_core/firebase_core.dart';

 Future<void>main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await SessionManagerMethods.init();
  await Firebase.initializeApp();

   FlutterError.onError = (errorDetails) {
     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
   };
   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
   PlatformDispatcher.instance.onError = (error, stack) {
     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
     return true;
   };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      title: 'Kuber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)),
      home: const MyHomePage(
        title: 'Kuber',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SessionManager _sessionManager = SessionManager();
  AudioCache audioPlugin = AudioCache();
  AudioPlayer audio = AudioPlayer();

  @override
  void initState() {
    audio.setSource(AssetSource("audio/flute.mp3"));
    audio.play(AssetSource("audio/flute.mp3"));

    Future.delayed(Duration.zero,(){
      if(_sessionManager.checkIsLoggedIn() ?? false)
      {
        Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen())));
      }
      else
      {
        Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())));
      }
    });

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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [gredient1, gredient2],
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 260,
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 140),
                child: Image.asset("assets/images/ic_img_splash.png"),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 30),
                height: 100,
                child: Image.asset("assets/images/ic_kuber.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

