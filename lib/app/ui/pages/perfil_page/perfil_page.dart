import 'package:app_fidelizacion/app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../controllers/perfil_controller.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import '../../../controllers/home_controller.dart';

class PerfilPage extends GetView<PerfilController> {
  final PerfilController _perfilController = Get.put(PerfilController());
  final Auth_Controller _authController = Get.find();
  final UserController _userController = Get.find();
  bool sesion = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),
        content(),
      ],
    );
  }

  Widget content() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 23, 4),
        actions: [sesion ? botonCerrarSesion() : butonlogin()],
        title: const Text('Perfil'),
      ),
      body: ListView(
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
            child: points("${_userController.usuario.value.points}"),
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                labelUserData(
                    "Identificación :", Icons.recent_actors, _userController.usuario.value.vat),
                const SizedBox(height: 5),
                labelUserData("Nombre Completo :", Icons.account_circle_rounded,
                    _userController.usuario.value.name),
                const SizedBox(height: 5),
                labelUserData("Número de telefono", Icons.phone, _userController.usuario.value.phone),
                const SizedBox(height: 5),
                labelUserData("Fecha de nacimiento", Icons.calendar_month, _userController.usuario.value.bithDate),
                const SizedBox(height: 5),
                labelUserData("Correo Electronico", Icons.alternate_email_rounded, _userController.usuario.value.email),
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
          cardCupon(
              "1234",
              "Nombre del Programa",
              "2023-12-31",
              Image.asset(
                  "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png")),
          cardCupon(
              "crcce",
              "dcefc",
              "ff",
              Image.asset(
                  "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png")),
          cardCupon(
              "tome",
              "si",
              "vale",
              Image.asset(
                  "static/png-transparent-coupon-discounts-and-allowances-computer-icons-coupon-miscellaneous-text-retail.png"))
        ],
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
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
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
        icon: const Icon(Icons.login));
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
                      12, // Ajusta el tamaño de fuente según tu preferencia
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
                      12, // Ajusta el tamaño de fuente según tu preferencia
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
        Get.offNamed('/registerform');
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
              fontWeight: FontWeight.w500,
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
              children: [Text(code), Text(progName), Text(expiration)],
            ))
          ],
        ),
      ),
    );
  }
}
