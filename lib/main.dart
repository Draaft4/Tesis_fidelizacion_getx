import 'package:app_fidelizacion/app/bindings/splash_binding.dart';
import 'package:app_fidelizacion/app/controllers/notification_controller.dart';
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:app_fidelizacion/app/routes/pages.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserController userController = Get.put(UserController(), permanent: true);
  final Auth_Controller authController = Get.put(Auth_Controller(), permanent: true);
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
      firestore.collection("notifications").add({
        "partner_id":userController.usuario.value.id,
        "title":message.notification?.title,
        "message":message.notification?.body,
        "date":Timestamp.fromDate(DateTime.now())
      });
      NotificationService().showNotification(title: message.notification?.title, body: message.notification?.body);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final fcmToken = await messaging.getToken();
  print("token");
  print(fcmToken);
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  if (message.notification != null) {
      firestore.collection("notifications").add({
        "partner_id":0,
        "title":message.notification?.title,
        "message":message.notification?.body,
        "date":Timestamp.fromDate(DateTime.now())
      });
    }
}