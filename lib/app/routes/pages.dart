import 'package:app_fidelizacion/app/ui/pages/home_page/home_page.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashPage(),
    ),
  ];
}
