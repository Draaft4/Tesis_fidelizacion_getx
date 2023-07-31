import 'dart:ui';

import 'package:app_fidelizacion/app/controllers/cupons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class CuponsPage extends GetView<CuponsController> {
  final CuponsController _cuponsController = Get.put(CuponsController());
  final Auth_Controller _authController = Get.find();
  List notificaciones = [];
  @override
  Widget build(BuildContext context) {
    updateList();
    return Stack(
      children: [background(), backgroundFilter(), content()],
    );
  }

  void updateList() async {
    await _cuponsController.getCupondata();
  }

  BackdropFilter backgroundFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
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
      appBar: AppBar(
        leading: Center(
            child: Image.asset(
          'static/1981-removebg-preview.png',
          width: 180,
          height: 180,
        )),
        backgroundColor: const Color.fromARGB(255, 140, 60, 30),
        actions: [
          _authController.isLogged.value ? botonCerrarSesion() : butonlogin()
        ],
        title: const Text('Cupones'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: Colors.brown[300],
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: Obx(() => ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _cuponsController.coupons.length,
                        itemBuilder: (context, index) => cardCupon(
                              _cuponsController.coupons[index]['code'],
                              _cuponsController.coupons[index]['program_name'],
                              _cuponsController.coupons[index]
                                  ['fecha de expiracion'],
                              Image.asset(
                                  "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png"),
                            )))),
              ]))),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 200, 200, 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [botonHome(), botonnotif(), botonCupones(), botonperfil()],
        ),
      ),
    );
  }

  Card cardCupon(
      String code, String progName, String expiration, Image imagen) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: imagen,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Codigo del cupón: $code",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Text(progName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Text("Fecha de Expiración: $expiration",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  IconButton botonCerrarSesion() {
    return IconButton(
      icon: const Icon(Icons.power_settings_new),
      onPressed: () {
        _authController.cerrarSesion();
      },
    );
  }

  IconButton butonlogin() {
    return IconButton(
        onPressed: () {
          _cuponsController.initLogin();
        },
        icon: const Icon(Icons.account_circle));
  }

  GestureDetector botonnotif() {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/notifications');
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
                  fontSize:
                      10, // Ajusta el tamaño de fuente según tu preferencia
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
                  fontSize:
                      10, // Ajusta el tamaño de fuente según tu preferencia
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector botonCupones() {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/cupons');
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
            Icon(Icons.discount),
            Text('Cupones',
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
        Get.offNamed("/perfil");
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
                  fontSize:
                      12, // Ajusta el tamaño de fuente según tu preferencia
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
