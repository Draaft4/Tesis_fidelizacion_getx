
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  void login(String email, String pass)async {
    String response = await Auth_Controller().loginEmailPass(email, pass);
    if(response!="ok"){
      Get.snackbar(
            'Error',
            response,
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
    );
    }else{
      Get.offNamed("/home");
    }
  }

  void register(){
    Get.toNamed("/register");
  }

}