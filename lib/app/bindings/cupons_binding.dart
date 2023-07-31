
import 'package:get/get.dart';
import '../controllers/cupons_controller.dart';


class CuponsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CuponsController>(() => CuponsController());
  }
}