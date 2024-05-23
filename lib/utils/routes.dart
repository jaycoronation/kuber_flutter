
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kuber/constant/global_context.dart';
import 'package:kuber/main.dart';
import 'package:kuber/screen/BookedPujaScreen.dart';
import 'package:kuber/screen/DashboardForWeb.dart';
import 'package:kuber/screen/DashboardScreen.dart';
import 'package:kuber/screen/DonationListScreen.dart';
import 'package:kuber/screen/FeedScreen.dart';
import 'package:kuber/screen/LoginForWeb.dart';
import 'package:kuber/screen/LoginScreen.dart';
import 'package:kuber/screen/MatchMakingScreen.dart';
import 'package:kuber/screen/PrayerRequestScreen.dart';
import 'package:kuber/screen/RashiScreen.dart';
import 'package:kuber/screen/TempleListScreen.dart';
import 'package:kuber/screen/VerifyOtpScreen.dart';
import 'package:kuber/utils/responsive.dart';
import '../utils/session_manager.dart';

class AppRoutes {
  static const mainRoute = "/";
  static const homeRoute = "/home";
  static const suceesRoute = "/sucess";
  static const suceesAstroRoute = "/success_astro";
  static const suceesMatchRoute = "/success_match";
  static const suceesDonationRoute = "/success_donation";
  static const loginRoute = "/login";
  static const otpRoute = "/verify-otp";
  static const templesRoute = "/temples";
  static const feedsRoute = "/feeds";
  static const prayersRoute = "/prayers";
  static const bookedPujaRoute = "/booked-puja";
  static const rashiRoute = "/rashi";
  static const matchMakingRoute = "/match-making";
  static const donationsRoute = "/donations";

  static final GoRouter routes = GoRouter(
    initialLocation: mainRoute,
    navigatorKey: NavigationService.navigatorKey,
    routes: <GoRoute> [
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, state) => ResponsiveWidget.isSmallScreen(context) ? const DashboardScreen() : const DashboardForWeb(),
        redirect: (context, state) => redirectToDashboard(context, state),
      ),
      GoRoute(
        path: mainRoute,
        builder: (BuildContext context, state) => const MyHomePage(),
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: templesRoute,
        builder: (BuildContext context, state) => const TempleListScreen([]),
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: feedsRoute,
        builder: (context, state) {
          return const FeedScreen();
        },
        // builder: (BuildContext context, GoRouterState state) {
        //   final chat = state.pathParameters['chat']!;
        //   return ConversationsPage(
        //     chat as ChatUserInfo,
        //   );
        // },
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: prayersRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const PrayerRequestScreen();
        },
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: bookedPujaRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const BookedPujaScreen();
        },
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: rashiRoute,
        builder: (context, state) {
          return const RashiScreen();
        },
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: matchMakingRoute,
        builder: (context, state) {
          return const MatchMakingScreen();
        },
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: donationsRoute,
        builder: (BuildContext context, state) => const DonationListScreen(),
        redirect: (context, state) => redirectToLogin(context, state),
      ),

      GoRoute(
        path: suceesRoute,
        builder: (BuildContext context, state) => const DashboardForWeb(),
        redirect: (context, state) => redirectToDashboard(context, state),
      ),
      GoRoute(
        path: suceesAstroRoute,
        builder: (BuildContext context, state) => const DashboardForWeb(),
        redirect: (context, state) => redirectToDashboard(context, state),
      ),
      GoRoute(
        path: suceesMatchRoute,
        builder: (BuildContext context, state) => const DashboardForWeb(),
        redirect: (context, state) => redirectToDashboard(context, state),
      ),
      GoRoute(
        path: suceesDonationRoute,
        builder: (BuildContext context, state) => const DashboardForWeb(),
        redirect: (context, state) => redirectToDashboard(context, state),
      ),
      GoRoute(
        path: loginRoute,
        builder: (BuildContext context, state) => kIsWeb ? LoginScreenForWeb() : LoginScreen(),
        redirect: (context, state) => redirectToLogin(context, state),
      ),
      GoRoute(
        path: otpRoute,
        builder: (BuildContext context, state) => VerifyOtpScreen(),
        redirect: (context, state) => otpRedirect(context, state),
      ),
    ]
  );

  static String? redirectToDashboard(BuildContext context, GoRouterState state) {
    SessionManager sessionManager = SessionManager();
    final String? userId = sessionManager.getUserId();

    if (kDebugMode) {
      print(userId);
    }

    if (userId == "" || userId == null) {
      return Uri(
        path: '/home',
      ).toString();
    } else {
      return Uri(
          path: '/home',
        ).toString();
    }
  }

  static String? redirectToLogin(BuildContext context, GoRouterState state) {
      Future.delayed(const Duration(seconds: 5), () {
        SessionManager sessionManager = SessionManager();
        final bool? isLoggedIn = sessionManager.checkIsLoggedIn();

        if (isLoggedIn == false) {
          return Uri(
            path: '/login',
          ).toString();
        } else {
          return Uri(
            path: '/',
          ).toString();
        }
      });
      // return null;
  }

  static String? otpRedirect(BuildContext context, GoRouterState state) {
    return Uri(
      path: '/login',
    ).toString();
  }
 
}