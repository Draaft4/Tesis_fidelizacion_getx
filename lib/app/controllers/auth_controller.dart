import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class Auth_Controller extends GetxController {
  RxBool isLogged = false.obs;

  var instance = FirebaseAuth.instance;

  void isInSession() {
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLogged.value = false;
      } else {
        isLogged.value = true;
      }
    });
  }


  Future<String> registerEmailPass(String email, String pass) async {
    try {
      final credential = await instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      return (e.toString());
    }
    isLogged.value = true;
    update();
    return 'ok';
  }

  Future<String> loginEmailPass(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
    isLogged.value = true;
    update();
    return 'ok';
  }

  void cerrarSesion() async {
    await instance.signOut();
    update();
    Get.offNamed("/splash");
    Get.offNamed("/home");
  }
}
