import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final UserController _userController = Get.find();

  RxList<QueryDocumentSnapshot> notificaciones = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  void initLogin() {
    Get.offNamed("/login");
  }

  Future<void> getNotifications() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('partner_id', isEqualTo: _userController.usuario.value.id)
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    notificaciones.value = documents;
    print("actualizando");
  }
}
