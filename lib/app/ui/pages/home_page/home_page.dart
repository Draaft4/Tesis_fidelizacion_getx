import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.put(HomeController());
  final Auth_Controller _authController = Get.find();

  final _isDialogVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
            child: Image.asset(
          'static/1981-removebg-preview.png',
          width: 180,
          height: 180,
        )),
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
        icon: const Icon(Icons.account_circle));
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
              child: Obx(() => ListView.builder(
                    itemCount: _homeController.productos.length,
                    itemBuilder: (context, index) {
                      final producto = _homeController.productos[index];
                      if (producto['base64'] != null) {
                        return cardPromociones(
                          producto['description'],
                          producto['required_points'],
                          Image.memory(base64Decode(producto['base64'])),
                        );
                      } else {
                        return cardPromociones(
                          producto['description'],
                          producto['required_points'],
                          Image.asset(
                              "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png"),
                        );
                      }
                    },
                  )),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                _showDialog();
                _isDialogVisible.value = true;
              },
              child: const Text(
                'Condiciones para ganar puntos',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
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
              child: Obx(
            () => ListView.builder(
              itemCount: _homeController.productos.length,
              itemBuilder: (context, index) {
                final producto = _homeController.productos[index];
                if (producto['base64'] != null) {
                  return cardPromociones(
                    producto['description'],
                    producto['required_points'],
                    Image.memory(base64Decode(producto['base64'])),
                  );
                } else {
                  return cardPromociones(
                    producto['description'],
                    producto['required_points'],
                    Image.asset(
                        "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png"),
                  );
                }
              },
            ),
          )),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              _showDialog();
              _isDialogVisible.value = true;
            },
            child: const Text(
              'Condiciones para ganar puntos',
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
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
    Image imagen,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: imagen,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Puntos Requeridos: $requiredPoints',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    Get.defaultDialog(
        title: "Condiciones para ganar puntos",
        titleStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        content: SizedBox(
            height: 200,
            child: ListView.builder(
                itemCount: _homeController.condiciones.length,
                itemBuilder: (context, index) {
                  final condicion = _homeController.condiciones[index];
                  return cardCondiciones(
                      condicion['minimum_qty'],
                      condicion['minimum_amount'],
                      condicion['reward_point_amount']);
                })),
        radius: 30);
  }

  Card cardCondiciones(
      // ignore: non_constant_identifier_names
      int minimun_qty,
      // ignore: non_constant_identifier_names
      double minimum_amount,
      // ignore: non_constant_identifier_names
      double reward_point_amount) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Por una compra mínima de: $minimun_qty",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Por un gasto mínimo de: $minimum_amount",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Gana $reward_point_amount puntos.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
                  fontSize: 10,
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
                  fontSize: 10,
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
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
