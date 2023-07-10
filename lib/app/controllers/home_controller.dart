import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeController extends GetxController {
  RxList<Map<String, dynamic>> productos = <Map<String, dynamic>>[].obs;
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
  final url = Uri.parse('http://192.168.1.18:8086/api/listcupons');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    List<Map<String, dynamic>> cupons = List<Map<String, dynamic>>.from(jsonResponse);
    for (var element in cupons) {
      productos.add(element);
    }
  }
}

}
