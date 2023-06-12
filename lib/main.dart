import 'package:app_fidelizacion/app/bindings/splash_binding.dart';
import 'package:app_fidelizacion/app/routes/pages.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: SplashBinding(),
    getPages: AppPages.pages,
    home: SplashPage(),
  ));
}
