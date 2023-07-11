import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/notifications_controller.dart';
import 'package:app_fidelizacion/app/controllers/auth_controller.dart';
import '../../../controllers/home_controller.dart';

class NotificationsPage extends GetView<NotificationsController> {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());
  final Auth_Controller _authController = Get.find();
  List notificaciones = [];
  @override
  Widget build(BuildContext context) {
    updateList();
    return Stack(
      children: [background(), content()],
    );
  }

  void updateList() async {
    await _notificationsController.getNotifications();
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
        actions: [_authController.isLogged.value ? botonCerrarSesion() : butonlogin()],
        title: const Text('Notificaciones'),
      ),
      body: RefreshIndicator(
          onRefresh: () => _notificationsController.getNotifications(),
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
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _notificationsController.notificaciones.length,
                itemBuilder: (context, index) => cardNotificacion(
                  "${(_notificationsController.notificaciones[index].data() as Map<String, dynamic>)["title"]}",
                  "${(_notificationsController.notificaciones[index].data() as Map<String, dynamic>)["message"]}",
                  (_notificationsController.notificaciones[index].data()
                          as Map<String, dynamic>)["date"]
                      .toDate()
                      .toString(),
                ),
              ),
            ),
          ])),
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
          _notificationsController.initLogin();
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
        if(_authController.isLogged.value){
          Get.offNamed("/perfil");
        }else{
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
