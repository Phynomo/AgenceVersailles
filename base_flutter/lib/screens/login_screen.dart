import 'package:flutter/material.dart';

import '../src/constants/image_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromRGBO(255, 211, 0, 1),
      body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            //Image(image: const AssetImage(logo2)),
            Image.asset('assets/images/Logo2.png'),
            const Text("¡Bienvenido a nuestra aplicación!"),
            const Text("inicia o crea sesión para disfrutar de los mejores viajes")
          ],
        ),
      ),
      ),
    );
  }
}