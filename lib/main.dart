import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuber/constant/api_end_point.dart';
import 'package:kuber/constant/colors.dart';
import 'package:kuber/model/CommonResponseModel.dart';
import 'package:kuber/push_notification/PushNotificationService.dart';
import 'package:kuber/screen/DashboardForWeb.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/LoginForWeb.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/screen/MyPofileScreen.dart';
import 'package:kuber/screen/PujariDashboard.dart';
import 'package:kuber/utils/responsive.dart';
import 'package:kuber/utils/routes.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:kuber/utils/session_manager_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  print("@@@@@@@@ Main Dart @@@@@@@@ ${message.data}");

}

 Future<void>main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await SessionManagerMethods.init();
   if (kIsWeb)
   {
     var isInit = await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );

     print(isInit.options);
     print(isInit.name);
   }
   else
   {
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

     FlutterError.onError = (errorDetails) {
       FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
     };
     // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
     PlatformDispatcher.instance.onError = (error, stack) {
       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
       return true;
     };

   }

   await PushNotificationService().setupInteractedMessage();

   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

   flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

   //FOR NOTIFICATION//
   if (initialMessage != null)
   {
     print("@@@@@@@@ Main Dart @@@@@@@@ ${initialMessage.data}");

   }

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

    if (kIsWeb)
      {
        return FlutterWebFrame(
          backgroundColor: kuber,
          builder: (context) {
            return MaterialApp.router(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
              title: 'Kuber',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.routes,
              theme: ThemeData(
                  textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
              ),
            );
          },
          maximumSize: const Size(1160.0, 812.0),
        );
      }
    else
      {
        return MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          title: 'Kuber',
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: false,
              /*inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: white,
                contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 18),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey,),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide( color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.grey)),
                labelStyle: const TextStyle(
                  color: darkbrown,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: const TextStyle(color: darkbrown,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),*/
              textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
          ),
        );
      }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

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
    print("opq");
    Future.delayed(Duration.zero,(){
      print(_sessionManager);
      if(_sessionManager.checkIsLoggedIn() ?? false)
      {
        print(_sessionManager.getPhone().toString());
        print(_sessionManager.getEmail().toString());
        if(_sessionManager.getPhone().toString().isEmpty || _sessionManager.getEmail().toString().isEmpty)
        {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyProfileScreen(true)), (route) => false);
        }
        else
        {
          if (kIsWeb)
            {
              print("dash");
              // GoRouter.of(context).go(AppRoutes.homeRoute);
              // context.go(AppRoutes.homeRoute);
              if (ResponsiveWidget.isSmallScreen(context))
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
                }
              else
                {
                  GoRouter.of(context).go(AppRoutes.homeRoute);
                  //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardForWeb()), (route) => false);
                }
            }
          else
            {
              print("IS IN ELSE ELSE");
              if (_sessionManager.getIsPujrai() ?? false)
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PujariDashboard()), (route) => false);
                }
              else
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
                }
            }
        }
      }
      else
      {
        if (kIsWeb)
        {
          print("abc");
           context.go(AppRoutes.loginRoute);
          //Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreenForWeb())));
        }
        else
        {
          print("xyz");
          //GoRouter.of(context).go(AppRoutes.loginRoute);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
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

