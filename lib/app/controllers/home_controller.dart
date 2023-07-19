import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  Constants constants = Constants();

  RxList<Map<String, dynamic>> productos = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> condiciones = <Map<String, dynamic>>[].obs;
  RxBool isExpanded = false.obs;



  void initLogin() {
    Get.offNamed('/login');
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    var url = Uri.parse('${constants.url}/api/listcupons');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> cupons =
          List<Map<String, dynamic>>.from(jsonResponse);
      for (var element in cupons) {
        productos.add(element);
      }
    }
    url = Uri.parse('${constants.url}/api/loyalty_rules');
    response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> rules =
          List<Map<String, dynamic>>.from(jsonResponse);
      for (var element in rules) {
        condiciones.add(element);
      }
    }
  }
}
