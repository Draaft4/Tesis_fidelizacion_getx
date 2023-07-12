
import 'package:get/get.dart';
import '../controllers/userdataupdate_controller.dart';


class UserdataupdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDataUpdateController>(() => UserDataUpdateController());
  }
}