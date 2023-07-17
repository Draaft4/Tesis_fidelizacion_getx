
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {

  UserController _userController = Get.find();


   @override
  void onInit() {
    super.onInit();
    updateData();
  }

   void initLogin(){
    Get.offNamed('/login');
  }

  void updateData()async {
    await _userController.updateData();
  }

}
  