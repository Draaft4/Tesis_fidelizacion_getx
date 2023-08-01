import 'dart:convert';
import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterFormController extends GetxController {
  final Auth_Controller _authController = Get.find();
  final UserController _userController = Get.find();
  Constants constants = Constants();

  void register(String name, String vat, String birthDate, String phone) async {
    if (vat.length != 10) {
      Get.snackbar(
        'Error',
        'Error de validación de numero de cedula.',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    if (phone.length != 10) {
      Get.snackbar(
        'Error',
        'Error de validación de numero de telefono celular.',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    var url = Uri.parse('${constants.url}/api/newClient');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "name": name,
            "email": _userController.usuario.value.email,
            "vat": vat,
            "x_birth_date": birthDate,
            "phone": phone
          },
        ));
    final body = json.decode(response.body);
    url = Uri.parse('${constants.url}/api/clientData?id=${body["partner_id"]}');
    response = await http.get(url);
    var userJson = json.decode(response.body);
    _userController.setUserData(
        userJson['id'],
        userJson['name'],
        userJson['email'],
        userJson['vat'],
        userJson['phone'],
        userJson['birth_date'],
        0);
    _authController.isLogged.value = true;
    Get.offNamed("/home");
  }
}
