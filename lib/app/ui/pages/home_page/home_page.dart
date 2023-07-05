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
        backgroundColor:const Color.fromARGB(255, 77, 23, 4),
        actions: [sesion ? botonCerrarSesion() : botonLogin()],
        title: const Text('Promociones'),
      ),
      body:Container( 
      width: double.infinity,
      height: double.infinity,  
      margin: const EdgeInsets.only(top:40),
      
      child: sesion ? mainSesion() : mainNoSesion(),
      
    ),
    backgroundColor:const Color.fromARGB(255, 200, 200, 200),
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

  Widget mainSesion() => Container();
Widget mainNoSesion() {
  return Scaffold(
    backgroundColor:const Color.fromARGB(255, 200, 200, 200),
    body: ListView(
      children: [
        const SizedBox(height: 20,),
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
        cardPromociones(
          "aqui va descripcion",
          "aqui van puntos requeridos",
          Image.asset("static/coffee-cup.png"),
        ),
        cardPromociones(
          "Descripcion2",
          "p. requeridos",
          Image.asset("static/coffee-cup.png"),
        ),
        cardPromociones(
          "descripcion n",
          "p. requeridos n",
          Image.asset("static/coffee-cup.png"),
        ),
        const SizedBox(height: 15),
        const Center(
          child:Text(
            "Obtén 10 puntos por cada compra que realizes",
            style: TextStyle(
              fontSize: 17,
              fontWeight:FontWeight.bold
            ),
          )
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





Card cardPromociones(String val, String val2, Image imagen) {
  return Card(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color:Colors.black, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color:  Colors.white,
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
                Text(val),
                Text(val2),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
GestureDetector botonnotif(){
  return GestureDetector(
    onTap: (){
      Get.offNamed('/notifications');
    },
    child: Container(
      width:80,
      height: 60,
      
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 200, 200, 200),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications),
          Text(
            'Notificaciones',
            style:TextStyle(
              fontSize: 12, // Ajusta el tamaño de fuente según tu preferencia
              fontWeight: FontWeight.bold,
            )
          )
        ],
      ),
    ),
  );
}
GestureDetector botonHome(){
  return GestureDetector(
    onTap: (){
      Get.offNamed('/home');
    },
    child: Container(
      width:40,
      height: 55,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 200, 200, 200),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home),
          Text(
            'Inicio',
            style:TextStyle(
              fontSize: 12, // Ajusta el tamaño de fuente según tu preferencia
              fontWeight: FontWeight.bold,
            )
          )
        ],
      ),
    ),
  );
}
GestureDetector botonperfil(){
  return GestureDetector(
    onTap: (){
      Get.offNamed("/perfil");
    },
    child: Container(
      width:40,
      height: 55,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 200, 200, 200),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle),
          Text(
            'Perfil',
            style:TextStyle(
              fontSize: 12, // Ajusta el tamaño de fuente según tu preferencia
              fontWeight: FontWeight.bold,
            )
          )
        ],
      ),
    ),
  );
}

}
  

