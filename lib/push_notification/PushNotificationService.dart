import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/global_context.dart';
import '../firebase_options.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager.dart';
import 'package:http/http.dart' as http;

// ignore: slash_for_doc_comments
/**
 * Documents added by Alaa, enjoy ^-^:
 * There are 3 major things to consider when dealing with push notification :
 * - Creating the notification
 * - Hanldle notification click
 * - App status (foreground/background and killed(Terminated))
 *
 * Creating the notification:
 *
 * - When the app is killed or in background state, creating the notification is handled through the back-end services.
 *   When the app is in the foreground, we have full control of the notification. so in this case we build the notification from scratch.
 *
 * Handle notification click:
 *
 * - When the app is killed, there is a function called getInitialMessage which
 *   returns the remoteMessage in case we receive a notification otherwise returns null.
 *   It can be called at any point of the application (Preferred to be after defining GetMaterialApp so that we can go to any screen without getting any errors)
 * - When the app is in the background, there is a function called onMessageOpenedApp which is called when user clicks on the notification.
 *   It returns the remoteMessage.
 * - When the app is in the foreground, there is a function flutterLocalNotificationsPlugin, is passes a future function called onSelectNotification which
 *   is called when user clicks on the notification.
 *
 * */
class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessaging.instance.requestPermission();
    await enableIOSNotifications();
    await registerNotificationListeners();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var id = "";
      var contentType = "";
      var image = "";
      var messageData = "";
      print('Data Payload:${message.data.toString()}');
      message.data.forEach((key, value) {
        if (key == "content_id") {
          id = value;
        }

        if (key == "operation") {
          contentType = value;
        }

        if (key == "image") {
          image = value;
        }

        if (key == "message") {
          messageData = value;
        }
      });
      print('<><> onMessageOpenedApp id--->$id');
      print('<><> onMessageOpenedApp contentType--->$contentType');

      NavigationService.notif_id = id;

      openPage(contentType);
    });
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        SessionManager sessionManager = SessionManager();
        var isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
        if (title != null && isLoggedIn)
        {
          var idAPI = "";
          var contentType = "";
          var image = "";
          var titleAPI = "";
          var messageData = "";

          titleAPI = title.toString();
          idAPI = id.toString();
          messageData = body.toString();

          print('<><> onMessage id--->$id');
          print('<><> onMessage contentType--->$contentType');
          print("<><> onMessage Image URL : $image <><>");
          print("<><> onMessage Payload : $payload <><>");
          const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentSound: true, presentAlert: true);

          flutterLocalNotificationsPlugin.show(
            id.hashCode,
            title,
            messageData,
            payload: contentType,
            NotificationDetails(
                android: AndroidNotificationDetails('SIRE', 'SIRE',
                    channelDescription: channel.description,
                    icon: payload,
                    playSound: true,
                    importance: Importance.max,
                    styleInformation: BigTextStyleInformation(messageData),
                    priority: Priority.high),
                iOS: iOSPlatformChannelSpecifics),
          );
        }
        else
        {
          print("<><> CHECK DATA : " " <><>");
        }
      },
    );

    var initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (payload) {
      // This function handles the click in the notification when the app is in foreground
      // Get.toNamed(NOTIFICATIOINS_ROUTE);
      try {
        var contentType = payload.toString();

        print(payload.notificationResponseType.name);
        print(payload.notificationResponseType.index);
        print(payload.actionId);
        print(payload.payload);

        openPage(payload.payload ?? '');
      } catch (e) {
        print(e);
      }
    });
    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      print('onMessage Notification Payload:${message?.notification!.toMap().toString()}');
      print('onMessage Data Payload:${message?.data.toString()}');
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      AppleNotification? appleNotification = message?.notification?.apple;
      SessionManager sessionManager = SessionManager();
      var isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if (notification != null && isLoggedIn)
        {
          var id = "";
          var contentType = "";
          var image = "";
          var title = "";
          var messageData = "";

          message?.data.forEach((key, value) {
            if (key == "content_id") {
              id = value;
            }

            if (key == "operation") {
              contentType = value;
            }

            if (key == "image") {
              image = value;
            }

            if (key == "title") {
              title = value;
            }

            if (key == "message") {
              messageData = value;
            }
          });

           print('<><> onMessage id--->$id');
          print('<><> onMessage contentType--->$contentType');
          print('<><> onMessage title--->$title');
          print('<><> onMessage messageData--->$messageData');
          print("<><> onMessage Image URL : $image <><>");

          NavigationService.notif_id = id;



          const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
              presentSound: true, presentAlert: true);

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            title,
            messageData,
            payload: contentType,
            NotificationDetails(
                android: AndroidNotificationDetails('SIRE', 'SIRE',
                    channelDescription: channel.description,
                    icon: android?.smallIcon,
                    playSound: true,
                    importance: Importance.max,
                    styleInformation: BigTextStyleInformation(messageData),
                    priority: Priority.high),
                iOS: iOSPlatformChannelSpecifics),
          );
        }
      else
        {
            print("<><> CHECK DATA :  <><>");
        }
    });
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true);
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.max,
        playSound: true,
      );

  void openPage(String contentId) {


    NavigationService.notif_type = contentId;
    NavigationService.navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardScreen()), (Route<dynamic> route) => false
    );
  }

}