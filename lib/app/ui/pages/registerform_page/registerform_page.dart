
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/registerform_controller.dart';


class RegisterFormPage extends GetView<RegisterFormController> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _usernController = TextEditingController();
  final TextEditingController _phonenumberController =TextEditingController();
  final TextEditingController  _idecontroller = TextEditingController();
  final RegisterFormController _registerFormController=Get.put(RegisterFormController());
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [background(),backgroundFilter(),content()],
    );
}
  Widget content(){
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Card(
              color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      Center(child: labelFormlogin('Registro de Usurio')),
                      Center(child: Image.asset('static/1981-removebg-preview.png',
                          width: 180,
                          height: 180,
                        )),
                      const SizedBox(height:15 ),
                    textvalues('numero de Cedula', false,Icons.recent_actors , _idecontroller),
                    const SizedBox(height: 15),
                    textvalues('Nombre Completo', false, Icons.mail,
                    _usernController),
                    const SizedBox(height: 15),
                    textvalues('número de Telefono', false, Icons.phone, 
                    _phonenumberController),
                    const SizedBox(height: 15,),
                    dateField('Fecha de nacimiento',false, Icons.calendar_today, _dateController,),
                    const SizedBox(height: 35,),
                    botonlog(),
                     const SizedBox(height: 35,),
                    botonback(),
                     ],
                    ),
                  ],
                ),
              ),
            ),
          )
        )
      ),
    );
  }
  Text labelFormlogin(String val){
    return Text(
      val, 
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Container background(){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("static/splash.jpeg"), fit: BoxFit.cover
      ),
      )
    );
  }
  BackdropFilter backgroundFilter(){
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0)
        ),
      ),
    );
  }
  Container textvalues(
    String val, bool pwd, IconData icono, TextEditingController controller){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white38
        ),
        child: TextField(
          obscureText: pwd,
          controller:controller,
          style:  const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border:  InputBorder.none,
              prefixIcon: Icon(
                icono,
                color: Colors.white,
              ),
              hintText: val,
              hintStyle: const TextStyle( color: Colors.white),       
            ),
          ),
       );  
    }
Container dateField(String val,bool pwd, IconData icono, TextEditingController controller ){
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white38,
        ),
        child: TextField(
          obscureText: pwd,
          controller: controller,
          readOnly: true,
          onTap: (){
            _selectDate(controller);
          },
          style:const TextStyle(color: Colors.white) ,
          decoration: InputDecoration(
           border: InputBorder.none,
           prefixIcon: Icon(
            icono,
            color: Colors.white,
           ),
           hintText: val,
           hintStyle: const TextStyle( color: Colors.white), 
          ),
        ),
    );


  }
  Future<void> _selectDate(controller) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final DateFormat formatter =DateFormat('yyyy-MM-dd'); // Aquí puedes formatear la fecha según tus necesidades
      final String formattedDate =formatter.format(picked);
      controller.text=formattedDate;
      
    }
  }

  GestureDetector botonlog(){
    return GestureDetector(
      onTap: (){
        _registerFormController.register(_usernController.text, _idecontroller.text, _dateController.text, _phonenumberController.text);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Registrarse',
            style:TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ) ,
          ),
          ),
      )
      ),
    );
  }
  GestureDetector botonback(){
    return GestureDetector(
      onTap: (){
        Get.offNamed('/login');
      },
      child: Container(

          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), 
          ),
          child:const Align(
            alignment: Alignment.center,
         child: Icon(
          Icons.assignment_return_outlined,
          color: Colors.white,
          size: 70,
         )
         )
      ),
    );
  }
}
  