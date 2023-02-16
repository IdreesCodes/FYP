import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';
import 'package:tech_media/view/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOption.currentPlatform
      );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Got a message whilst in the foreground!');
    }
    if (kDebugMode) {
      print('Message data: ${message.data}');
    }

    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.primaryMaterialColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              color: AppColors.whiteColor,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontSize: 22,
                  fontFamily: AppFonts.sfProDisplayMedium,
                  color: AppColors.primaryTextTextColor)),
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 40,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline2: TextStyle(
                fontSize: 32,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline3: TextStyle(
                fontSize: 28,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.9),
            headline4: TextStyle(
                fontSize: 2,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline5: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.sfProDisplayMedium,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w500,
                height: 1.6),
            headline6: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText1: TextStyle(
                fontSize: 17,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                fontWeight: FontWeight.w700,
                height: 1.6),
            bodyText2: TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.sfProDisplayRegular,
                color: AppColors.primaryTextTextColor,
                height: 1.6),
            caption: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.sfProDisplayBold,
                color: AppColors.primaryTextTextColor,
                height: 2.26),
          )),
      // home: const SplashScreen(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
