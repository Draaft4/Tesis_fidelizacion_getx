import 'dart:convert';
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:get/get.dart';

class UserDataUpdateController extends GetxController {
  final Constants constants = Constants();
  final UserController userController = Get.find();

  void updateUser(int id, String name, String email, String vat,
      String birthDate, String phone) async {
    var url = Uri.parse('${constants.url}/api/updateClient');
    // ignore: unused_local_variable
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': id,
            'name': name,
            'email': email,
            'vat': vat,
            'phone': phone,
            'x_birth_date': birthDate
          },
        ));
    url = Uri.parse('${constants.url}/api/clientData?id=$id');
    response = await http.get(url);
    var userJson = json.decode(response.body);
    url = Uri.parse('${constants.url}/api/loyaltyData?id=${userJson['id']}');
    response = await http.get(url);
    var pointsJson = json.decode(response.body);
    userController.setUserData(
        userJson['id'],
        userJson['name'],
        userJson['email'],
        userJson['vat'],
        userJson['phone'],
        userJson['birth_date'],
        pointsJson[0]["points"]);
    Get.offNamed('/perfil');
  }
}
