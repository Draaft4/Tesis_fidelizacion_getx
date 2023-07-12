import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());
  final Auth_Controller _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 23, 4),
        actions: [
          _authController.isLogged.value ? botonCerrarSesion() : botonLogin()
        ],
        title: const Text('Promociones'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 40),
        child: _authController.isLogged.value ? mainSesion() : mainNoSesion(),
      ),
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
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

  IconButton botonLogin() {
    return IconButton(
        onPressed: () {
          _homeController.initLogin();
        },
        icon: const Icon(Icons.login));
  }

  Widget mainSesion() => Scaffold(
        backgroundColor: const Color.fromARGB(255, 200, 200, 200),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Promociones Canjeables",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: _homeController.productos.length,
                itemBuilder: (context, index) {
                  final producto = _homeController.productos[index];
                  return cardPromociones(
                    producto['description'],
                    producto['required_points'],
                    producto['reward_type'],
                    producto['quantity'],
                    Image.memory(base64Decode(producto['base64'])),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Center(
                child: Text(
              "Obtén 10 puntos por cada compra que realices",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 200, 200, 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              botonHome(),
              botonnotif(),
              botonperfil(),
            ],
          ),
        ),
      );

  Widget mainNoSesion() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Promociones Canjeables",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: _homeController.productos.length,
              itemBuilder: (context, index) {
                final producto = _homeController.productos[index];
                return cardPromociones(
                  producto['description'],
                  producto['required_points'],
                  producto['reward_type'],
                  producto['quantity'],
                  Image.memory(base64Decode(producto['base64'])),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          const Center(
              child: Text(
            "Obtén 10 puntos por cada compra que realices",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 200, 200, 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            botonHome(),
            botonnotif(),
            botonperfil(),
          ],
        ),
      ),
    );
  }

  Card cardPromociones(
    String description,
    double requiredPoints,
    String rewardType,
    int quantity,
    Image imagen,
  ) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              height: 90,
              width: 90,
              child: imagen,
            ),
            title: Text(description),
            onTap: () {
              _homeController.isExpanded.toggle();
            },
          ),
          Obx(() {
            return Visibility(
              visible: _homeController.isExpanded.value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Puntos Requeridos: $requiredPoints'),
                    Text('Tipo de Recompensa: $rewardType'),
                    Text('Cantidad: $quantity'),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  GestureDetector botonnotif() {
    return GestureDetector(
      onTap: () {
        if (_authController.isLogged.value) {
          Get.offNamed('/notifications');
        } else {
          _homeController.initLogin();
        }
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 200, 200, 200),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications),
            Text('Notificaciones',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector botonHome() {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/home');
      },
      child: Container(
        width: 40,
        height: 55,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 200, 200, 200),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home),
            Text('Inicio',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector botonperfil() {
    return GestureDetector(
      onTap: () {
        if (_authController.isLogged.value) {
          Get.offNamed("/perfil");
        } else {
          _homeController.initLogin();
        }
      },
      child: Container(
        width: 40,
        height: 55,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 200, 200, 200),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle),
            Text('Perfil',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
