import 'dart:ui';

import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/perfil_controller.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';

// ignore: use_key_in_widget_constructors
class PerfilPage extends GetView<PerfilController> {
  final PerfilController _perfilController = Get.put(PerfilController());
  final Auth_Controller _authController = Get.find();
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),
        backgroundFilter(),
        content(),
      ],
    );
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
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.brown[300],
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  "Tus Puntos son:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Obx(
                    () => points("${_userController.usuario.value.points}")),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  "Datos Personales",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    labelUserData("Identificación :", Icons.recent_actors,
                        _userController.usuario.value.vat),
                    const SizedBox(height: 5),
                    labelUserData(
                        "Nombre Completo :",
                        Icons.account_circle_rounded,
                        _userController.usuario.value.name),
                    const SizedBox(height: 5),
                    labelUserData("Número de telefono", Icons.phone,
                        _userController.usuario.value.phone),
                    const SizedBox(height: 5),
                    labelUserData("Fecha de nacimiento", Icons.calendar_month,
                        _userController.usuario.value.bithDate),
                    const SizedBox(height: 5),
                    labelUserData("Correo Electronico:",
                        Icons.alternate_email_rounded, ""),
                    Text(_userController.usuario.value.email,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: botonUpdate(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Cupones Obtenidos",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: _userController.coupons.length,
                  itemBuilder: (context, index) => cardCupon(
                      _userController.coupons[index]["code"],
                      _userController.coupons[index]["program_name"],
                      _userController.coupons[index]["fecha de expiracion"],
                      Image.asset(
                          "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png")),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 200, 200, 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [botonHome(), botonnotif(), botonperfil()],
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

  IconButton botonCerrarSesion() {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        _authController.cerrarSesion();
      },
    );
  }

  IconButton butonlogin() {
    return IconButton(
        onPressed: () {
          _perfilController.initLogin();
        },
        icon: const Icon(Icons.account_circle));
  }

  Text points(String val) {
    return Text(val,
        style: const TextStyle(
            color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold));
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

  Widget labelUserData(String la, IconData icon, String val) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$la $val",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  GestureDetector botonUpdate() {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/update');
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 203, 156, 138)),
        child: const Center(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Actualizar Datos',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
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
}
