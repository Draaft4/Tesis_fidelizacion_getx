import 'package:app_fidelizacion/app/constants/constants.dart';
import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';

// ignore: camel_case_types
class Auth_Controller extends GetxController {
  RxBool isLogged = false.obs;

  var instance = FirebaseAuth.instance;

  UserController userController = Get.find();

  Constants constants = Constants();

  Future<String> registerEmailPass(String email, String pass) async {
    try {
      // ignore: unused_local_variable
      final credential = await instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      var url = Uri.parse('${constants.url}/api/login?email=$email');
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);
      if (jsonResponse["message"] == "error") {
        userController.setMail(email);
        Get.offNamed("/registerform");
      } else {
        var partnerId = jsonResponse['partner_id'];
        url = Uri.parse('${constants.url}/api/clientData?id=$partnerId');
        response = await http.get(url);
        var userJson = json.decode(response.body);
        url =
            Uri.parse('${constants.url}/api/loyaltyData?id=${userJson['id']}');
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
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      return (e.toString());
    }
    isLogged.value = true;
    update();
    return 'ok';
  }

  Future<String> loginEmailPass(String email, String pass) async {
    try {
      var url = Uri.parse('${constants.url}/api/login?email=$email');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var partnerId = jsonResponse['partner_id'];
        url = Uri.parse('${constants.url}/api/clientData?id=$partnerId');
        response = await http.get(url);
        var userJson = json.decode(response.body);
        url =
            Uri.parse('${constants.url}/api/loyaltyData?id=${userJson['id']}');
        response = await http.get(url);
        var pointsJson = json.decode(response.body);
        userController.setUserData(
            userJson['id'],
            userJson['name'],
            userJson['email'],
            userJson['vat'],
            userJson['phone'],
            userJson['birth_date'],
            pointsJson[0]!=null?pointsJson[0]["points"]:0);
      }
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
    registrarToken(userController.usuario.value.id);
    isLogged.value = true;
    update();
    return 'ok';
  }

  void cerrarSesion() async {
    await instance.signOut();
    userController.clearUser();
    isLogged.value = false;
    Get.offNamed("/splash");
    Get.offNamed("/home");
  }

  // ignore: non_constant_identifier_names
  void registrarToken(int res_partner) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final fcmToken = await messaging.getToken();
    var url = Uri.parse('${constants.url}/api/checkToken');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{"partner_id": "$res_partner", "token": fcmToken},
        ));
    final body = json.decode(response.body);
    if (body['success'] == false) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var url = Uri.parse('${constants.url}/api/registerToken');
      // ignore: unused_local_variable
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{"partner_id": "$res_partner", "token": fcmToken,"device_name":androidInfo.model},
          ));
    }
  }
}
