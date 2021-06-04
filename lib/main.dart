import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:racipi/routes/custom_route.dart';
import 'package:racipi/screens/login/login.dart';
import 'package:racipi/screens/nav/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:locally/locally.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  EquatableConfig.stringify = kDebugMode;
  SharedPreferences prefrences = await SharedPreferences.getInstance();
  bool isLoggedin = prefrences.getBool('isLogin');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    Phoenix(
      child: MyApp(isLoggedin),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedin;

  MyApp(this.isLoggedin);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute:
          isLoggedin == null ? LoginScreen.routeName : NavScreen.routeName,
    );
  }
}
