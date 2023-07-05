import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _valpasswordController = TextEditingController();

  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [background(), backgroundFilter(), content()],
    );
  }

  BackdropFilter backgroundFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
        ),
      ),
    );
  }

  Container background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("static/splash.jpeg"), fit: BoxFit.cover),
      ),
    );
  }

  Widget content() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: labelLogin('Registro de usuario')),
                        Center(child: Image.asset(
                          'static/1981-removebg-preview.png',
                          width: 180,
                          height: 180,
                        )),
                        const SizedBox(height: 25),
                        camposTexto('Correo Electrónico', false, Icons.mail,
                            _emailController),
                        const SizedBox(height: 15),
                        camposTexto('Contraseña', true, Icons.lock,
                            _passwordController),
                        const SizedBox(height: 15),
                        camposTexto('Repetir Contraseña', true, Icons.lock,
                            _valpasswordController),
                        const SizedBox(height: 35),
                        botonRegister(),
                        const SizedBox(height: 35,),
                        botonback()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container camposTexto(
      String val, bool pwd, IconData icono, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white38,
      ),
      child: TextField(
        obscureText: pwd,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icono,
            color: Colors.white,
          ),
          hintText: val,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Text labelLogin(String val) {
    return Text(
      val,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
 
  GestureDetector botonRegister() {
    return GestureDetector(
      onTap: () {
        if (_passwordController.text == _valpasswordController.text) {
          _registerController.register(_emailController.text, _passwordController.text);
        } else {
          Get.snackbar(
            'Error',
            'Las contraseñas no coinciden',
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.brown.shade400,
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Registrarse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
  GestureDetector botonback(){
    return GestureDetector(
      onTap: (){
        Get.offNamed('/login');
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15) 
         ),
         child: const Align(
              alignment: Alignment.center,
              child: Icon(
            Icons.replay,
            color:Colors.white,
            size:70
              ),
     
         ),
        ),
      );
    
  }
}
