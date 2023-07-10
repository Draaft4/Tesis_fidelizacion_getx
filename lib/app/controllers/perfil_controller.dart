
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {

  final UserController _userController = Get.find();
   void initLogin(){
    Get.offNamed('/login');
  }

}
  