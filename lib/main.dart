import 'package:app_fidelizacion/app/bindings/splash_binding.dart';
import 'package:app_fidelizacion/app/routes/pages.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  //token = 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  print("${settings.authorizationStatus}");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
    print(message.data);
    if(message.notification!=null){
      print('${message.notification}');
    }
  });
  final fcmToken = await messaging.getToken();
  print(fcmToken);
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
