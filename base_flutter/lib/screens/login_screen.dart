import 'package:flutter/material.dart';

import '../src/constants/image_strings.dart';
import 'index_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              const Text(
                "¡Bienvenido a nuestra aplicación!",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "inicia o crea sesión para disfrutar de los mejores viajes",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyWidget()),
                      );
                    },
                    child: const Text('Iniciar sesión'),
                  ),
                  const SizedBox(
                      width: 10), // Agregar un espacio entre los botones
                  TextButton(
                    onPressed: () {
                      // Acción a realizar cuando se presiona el botón
                    },
                    child: const Text('Crear usuario'),
                  )
                ],
              ),

              TextButton(
                onPressed: () {
                  // Acción a realizar cuando se presiona el botón
                },
                child: const Text('Salir'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
