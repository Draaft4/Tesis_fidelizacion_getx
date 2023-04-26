import 'package:app_fidelizacion/app/bindings/splash_binding.dart';
import 'package:app_fidelizacion/app/routes/pages.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.INITIAL,
        theme: appThemeData,
        defaultTransition: Transition.fade,
        initialBinding: SplashBinding(),
        getPages: AppPages.pages,
        home: SplashPage(),
    )
  );
}