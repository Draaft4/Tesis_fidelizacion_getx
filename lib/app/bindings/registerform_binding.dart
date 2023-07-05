
import 'package:get/get.dart';
import '../controllers/registerform_controller.dart';


class RegisterFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterFormController>(() => RegisterFormController());
  }
}