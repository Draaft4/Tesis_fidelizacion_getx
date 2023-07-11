import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:app_fidelizacion/app/models/User.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  Rx<User> usuario = User(0, '', '', '', '', '',0).obs;

  Constants constants = Constants();

  int id = 0;

  List<dynamic> coupons = [];

  void clearUser(){
    usuario = User(0, '', '', '', '', '',0).obs;
  }

  void setMail(String email){
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
  final response = await http.get(Uri.parse('${constants.url}/api/coupons?id=47'));
    final List<dynamic> jsonResponse = json.decode(response.body);
    for (var couponData in jsonResponse) {
      String code = couponData['code'];
      String programName = couponData['program_name'];
      String expiration = couponData['fecha de expiracion'];
      String imageURL = "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png";

    }

}


}
