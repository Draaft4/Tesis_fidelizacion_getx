import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/notifications_controller.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import '../../../controllers/home_controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  final HomeController _homeController = Get.put(HomeController());
  final Auth_Controller _authController = Get.find();
  bool sesion = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [background(), content()],
    );
  }

  Container background() {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 200, 200, 200)),
    );
  }

  Widget content() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 23, 4),
        actions: [sesion ? botonCerrarSesion() : butonlogin()],
        title: const Text('Notificaciones'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          const Center(
            child: Text(
              "Tus Notificaciones",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15,),
          cardNotificacion("Notificación 1", "Descripción de la notificación 1",
              "01/01/2022"),
          cardNotificacion("Notificación 2", "Descripción de la notificación 2",
              "02/01/2022"),
          cardNotificacion("Notificación 3", "Descripción de la notificación 3",
              "03/01/2022"),
          
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

  Card cardNotificacion(
      String valtitle, String valDescriptions, String valdate) {
    return Card(
      child: ListTile(
        title: Text(valtitle),
        subtitle: Text(valDescriptions),
        trailing: Text(valdate),
        
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
          _homeController.initLogin();
        },
        icon: const Icon(Icons.login));
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


}
