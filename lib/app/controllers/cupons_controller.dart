import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_fidelizacion/app/constants/constants.dart';
import 'dart:convert';

class CuponsController extends GetxController {
  final UserController _userController = Get.find();

  RxList<dynamic> coupons = <dynamic>[].obs;

  Constants constants = Constants();

  @override
  void onInit() {
    super.onInit();
    getCupondata();
  }

  void initLogin() {
    Get.offNamed('/login');
  }


    Future<void> getCupondata() async {
    final response =
        await http.get(Uri.parse('${constants.url}/api/coupons?id=${_userController.usuario.value.id}'));
    final List<dynamic> jsonResponse = json.decode(response.body);
    coupons.assignAll(jsonResponse);
  }
}
