import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/notifications_controller.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class NotificationsPage extends GetView<NotificationsController> {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());
  final Auth_Controller _authController = Get.find();
  List notificaciones = [];
  @override
  Widget build(BuildContext context) {
    updateList();
    return Stack(
      children: [background(), backgroundFilter(), content()],
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

  Container background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("static/splash.jpeg"), fit: BoxFit.cover),
      ),
    );
  }

  void updateList() async {
    await _notificationsController.getNotifications();
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
        title: const Text('Notificaciones'),
      ),
      body: RefreshIndicator(
          onRefresh: () => _notificationsController.getNotifications(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.brown[300],
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Tus Notificaciones",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: Obx(
                  () => ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _notificationsController.notificaciones.length,
                    itemBuilder: (context, index) => cardNotificacion(
                      "${(_notificationsController.notificaciones[index].data() as Map<String, dynamic>)["title"]}",
                      "${(_notificationsController.notificaciones[index].data() as Map<String, dynamic>)["message"]}",
                      DateFormat('dd-MM-yyyy').format(
                          (_notificationsController.notificaciones[index].data()
                                  as Map<String, dynamic>)["date"]
                              .toDate()),
                    ),
                  ),
                )),
              ]),
            ),
          )),
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
        title: Text(
          valtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          valDescriptions,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          valdate,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
          _notificationsController.initLogin();
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

  GestureDetector botonperfil() {
    return GestureDetector(
      onTap: () {
        if (_authController.isLogged.value) {
          Get.offNamed("/perfil");
        } else {
          _notificationsController.initLogin();
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
