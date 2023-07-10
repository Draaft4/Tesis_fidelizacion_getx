import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class Auth_Controller extends GetxController {
  RxBool isLogged = false.obs;

  var instance = FirebaseAuth.instance;

  UserController userController = Get.find();

  void isInSession() {
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLogged.value = false;
      } else {
        isLogged.value = true;
      }
    });
  }

  Future<String> registerEmailPass(String email, String pass) async {
    try {
      final credential = await instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
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
      var url = Uri.parse('http://192.168.1.18:8086/api/login?email=$email');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var partnerId = jsonResponse['partner_id'];
        url =
            Uri.parse('http://192.168.1.18:8086/api/clientData?id=$partnerId');
        response = await http.get(url);
        var userJson = json.decode(response.body);
        url = Uri.parse(
            'http://192.168.1.18:8086/api/loyaltyData?id=${userJson['id']}');
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
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
    isLogged.value = true;
    update();
    return 'ok';
  }

  void cerrarSesion() async {
    await instance.signOut();
    update();
    Get.offNamed("/splash");
    Get.offNamed("/home");
  }
}
