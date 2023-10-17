import 'package:flutter/material.dart';


class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> navigatorKeyHome = GlobalKey<NavigatorState>();
  static String notif_type = "";
  static String notif_id = "";
  static String match_id = "";
  static String astro_id = "";
  static String donation_id = "";
}