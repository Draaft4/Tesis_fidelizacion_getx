import 'package:app_fidelizacion/app/ui/pages/home_page/home_page.dart';
import 'package:app_fidelizacion/app/ui/pages/login_page/login_page.dart';
import 'package:app_fidelizacion/app/ui/pages/perfil_page/perfil_page.dart';
import 'package:app_fidelizacion/app/ui/pages/register_page/register_page.dart';
import 'package:app_fidelizacion/app/ui/pages/registerform_page/registerform_page.dart';
import 'package:app_fidelizacion/app/ui/pages/notifications_page/notifications_page.dart';
import 'package:app_fidelizacion/app/ui/pages/splash_page/splash_page.dart';
import 'package:app_fidelizacion/app/ui/pages/userdataupdate_page/userdataupdate_page.dart';
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
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
    ),
    GetPage(name: Routes.REGISTERFORM, page: () => RegisterFormPage()),
    GetPage(name: Routes.PERFIL, page: () => PerfilPage()),
    GetPage(name: Routes.NOTIFICATIONS, page: () => NotificationsPage()),
    GetPage(name: Routes.UPDATE_USER, page: () => UserDataUpdatePage())
  ];
}
