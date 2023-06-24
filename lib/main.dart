import 'package:app_fidelizacion/app/bindings/splash_binding.dart';
import 'package:app_fidelizacion/app/controllers/notification_controller.dart';
import 'package:app_fidelizacion/app/routes/pages.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  //token =  c92DgkgVQHewpn4QQpKhjP:APA91bHAXB0efhs_R7Y4DMd2LlfulcXr5tvlEnnfVHwknKQcXvbCXfBkBg8tkQbF_fDW8PRpVksYKwa7zWC2Uw4eZYzn6JchnbDzh6Ejsiaz36HMSPCDJVDjtlYzcsYS1yfGcu_AgWHQ
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      NotificationService()
              .showNotification(title: message.notification?.title, body: message.notification?.body);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //final fcmToken = await messaging.getToken();
  final Auth_Controller authController = Get.put(Auth_Controller(), permanent: true);
  authController.isInSession();
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
