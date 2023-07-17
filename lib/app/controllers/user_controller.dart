import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:app_fidelizacion/app/models/User.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  Rx<User> usuario = User(0, '', '', '', '', '', 0).obs;

  Constants constants = Constants();

  int id = 0;

  List<dynamic> coupons = [].obs;

  void clearUser() {
    usuario = User(0, '', '', '', '', '', 0).obs;
  }

  void setMail(String email) {
    usuario.value.email = email;
  }

  void setUserData(int id, String name, String email, String vat, String phone,
      String birthDate, double points) {
    this.id = id;
    usuario.value.id = id;
    usuario.value.name = name;
    usuario.value.email = email;
    usuario.value.vat = vat;
    usuario.value.phone = phone;
    usuario.value.bithDate = birthDate;
    usuario.value.points = points;
    getCupondata();
  }

  void getCupondata() async {
    final response =
        await http.get(Uri.parse('${constants.url}/api/coupons?id=${usuario.value.id}'));
    final List<dynamic> jsonResponse = json.decode(response.body);
    coupons = jsonResponse;
  }

  Future<void> updateData() async {
    var url = Uri.parse('${constants.url}/api/clientData?id=${usuario.value.id}');
    var response = await http.get(url);
    var userJson = json.decode(response.body);
    url =
            Uri.parse('${constants.url}/api/loyaltyData?id=${userJson['id']}');
        response = await http.get(url);
        var pointsJson = json.decode(response.body);
    setUserData(
            userJson['id'],
            userJson['name'],
            userJson['email'],
            userJson['vat'],
            userJson['phone'],
            userJson['birth_date'],
            pointsJson[0]["points"]);
    getCupondata();
  }
}
