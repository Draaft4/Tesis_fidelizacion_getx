import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {

  final HomeController _homeController = Get.put(HomeController());
  final Auth_Controller _authController = Get.find();
  
  bool sesion = false;

  @override
  Widget build(BuildContext context) {
    _authController.isInSession();
    sesion = _authController.isLogged.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [sesion ? botonCerrarSesion() : botonLogin()],
        title: const Text('Promociones'),
      ),
      body: sesion ? mainSesion() : mainNoSesion(),
    );
  }

  IconButton botonCerrarSesion() {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        _authController.cerrarSesion();
      },
    );
  }

  IconButton botonLogin() {
    return IconButton(
        onPressed: () {
          _homeController.initLogin();
        },
        icon: const Icon(Icons.login));
  }

  Widget mainSesion() => Container();

  ListView mainNoSesion() {
    return ListView(children: [
      cardPromociones(
          "Prom 1",
          Image.asset(
            "static/coffee-cup.png",
          )),
      cardPromociones(
          "Prom 2",
          Image.asset(
            "static/coffee-cup.png",
          )),
      cardPromociones(
          "Prom 2",
          Image.asset(
            "static/coffee-cup.png",
          )),
    ]);
  }

  Card cardPromociones(String val, Image imagen) {
    return Card(
      child: Column(
        children: [Text(val), SizedBox(height: 75, width: 75, child: imagen)],
      ),
    );
  }
}
