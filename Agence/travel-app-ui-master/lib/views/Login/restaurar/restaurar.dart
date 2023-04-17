import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/routes/routes.dart';
import 'package:travelappui/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/login.dart';
import 'package:travelappui/views/Login/restaurar/restaurar.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:math';

String correo = "";
String password = "";
String codigoGenerado = "";
String codigoUsuario  = "";

// Generar un número aleatorio de 4 dígitos
int generateRandomNumber() {
  var rng = new Random();
  return rng.nextInt(9000) + 1000;
}

class Recuperar extends StatefulWidget {
  const Recuperar({Key key}) : super(key: key);

  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {


  Future sendingmail() async {
    
 final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const service_id = "service_j1kwebo";
    const template_id = "template_y2gd6ee";
    const user_id = "dx505AHX7RBKJ9QXs";

    var randomNumber = generateRandomNumber();
    codigoGenerado = randomNumber.toString();
    var respond = await http.post(url,
        headers: {
          'origin': 'http:/localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "service_id": service_id,
          "template_id": template_id,
          "user_id": user_id,
          "template_params": {
            "message": "Tu código de verificación es: " + randomNumber.toString(),
            "to_email": correo,
          }
        }));
    print(respond.body);

  }

  TextEditingController _textController = TextEditingController();
  String _errorUsuario;
  String _errorPassword;
  bool _showErrorConexion = false;
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  ThemeData appTheme = Theme.of(context);
  return Scaffold(
    backgroundColor: kPrimaryColor,
    body: ListView(
      children: [
        Container(
          height: size.height * 0.50,
          width: size.width * 0.98,
          decoration: BoxDecoration(
              color: kAccentColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36)),
            child: Image(
              image: AssetImage('assets/image/LogoBlanco.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        if (!_showErrorConexion)
          Text(
            'Recuperar usuario',
            style: TextStyle(color: Colors.black, fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
        if (_showErrorConexion)
          Text(
            'Error de conexion, Intentalo mas tarde',
            style: TextStyle(color: Colors.red, fontSize: 24.0),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 15.0),
              _userTextField(),
              SizedBox(height: 25.0),
              _enviaremail(),
              SizedBox(height: 10.0),
              _regresarlogin(),
            ],
          ),
        )
      ],
    ),
  );
}


  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            hintText: "Correo",
            hoverColor: Colors.purple.shade900,
            labelText: "Ingresa tu correo",
            iconColor: Colors.purple.shade900,
            errorText: _errorUsuario,
          ),
          onChanged: (value) {
            correo = value;
          },
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              hoverColor: Colors.purple.shade900,
              icon: Icon(Icons.lock),
              iconColor: Colors.purple.shade900,
              errorText: _errorPassword,
              hintText: "Contraseña",
              labelText: "Ingresa tu cotraseña"),
          onChanged: (value) {
            password = value;
          },
        ),
      );
    });
  }

  Widget _enviaremail() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecuperarCodigo()),
                                  );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 78.0, vertical: 15.0),
            child: Text(
              "Enviar codigo",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purple.shade900),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
          ),
        ),
      );
    });
  }

  Widget _regresarlogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: Text(
            '¿Ya recuerdas tu contraseña?',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }
}





class RecuperarCodigo extends StatefulWidget {
  const RecuperarCodigo({Key key}) : super(key: key);

  @override
  State<RecuperarCodigo> createState() => _RecuperarCodigoState();
}

class _RecuperarCodigoState extends State<RecuperarCodigo> {
  String _codigoerror;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                1, // ajustar la altura del modal
            padding: EdgeInsets.all(16.0), // agregar un padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10.0),
                Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Codigo',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu codigo',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Codigo',
                      errorText: _codigoerror),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    final RegExp regex = RegExp(r'^\d{4}-\d{4}-\d{5}$');
                    if (!regex.hasMatch(value)) {
                      return 'El número de identificación debe tener el formato 0000-0000-00000';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  initialValue: codigoUsuario,
                  onChanged: (value) {
                    codigoUsuario = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
                          final RegExp regex = RegExp(r'^\d{6}');
                          setState(() {
                            _codigoerror = null;
                          });

                          Future<void> getDataFromAPI() async {
                            String apiUrl =
                                "https://localhost:44313/api/Persona/Existe?codigo="
                                  ; // URL de la API

                            try {
                              final response =
                                  await http.get(Uri.parse(apiUrl));

                              if (response.statusCode == 200) {
                                final jsonData = json.decode(response.body);
                                String data = jsonData["data"].toString();

                                if (data.toString().contains("No puede")) {
                                  setState(() {
                                    _codigoerror = "Este DNI ya esta en uso";
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Recuperar()),
                                  );
                                }
                              } else {
                                setState(() {
                                  _codigoerror =
                                      "Error al verificar, intentalo luego";
                                });
                              }
                            } catch (error) {
                              print(error);
                            }
                          }

                          if (codigoUsuario != "" && regex.hasMatch(codigoUsuario)) {
                            getDataFromAPI();
                          } else {
                            setState(() {
                              _codigoerror = "Este campo es requerido";
                            });
                            if (!regex.hasMatch(codigoUsuario)) {
                              setState(() {
                                _codigoerror =
                                    'Ingresa el codigo de 6 caracteres';
                              });
                            }
                          }
                        },
                        child: Text('Siguente'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recuperar()),
                          );
                        },
                        child: Text('Cancelar'),
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.red.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
