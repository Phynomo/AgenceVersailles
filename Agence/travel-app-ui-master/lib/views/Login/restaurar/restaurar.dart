import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';
// import 'package:travelappui/routes/routes.dart';
// import 'package:travelappui/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/login.dart';
// import 'package:travelappui/views/Login/restaurar/restaurar.dart';
// import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'dart:math';

String correo = "";
String password = "";
String codigoGenerado = "";
String codigoUsuario = "";

// Generar un número aleatorio de 6 dígitos
int generateRandomNumber() {
  var rng = new Random();
  return rng.nextInt(900000) + 100000;
}

class Recuperar extends StatefulWidget {
  const Recuperar({Key key}) : super(key: key);

  @override
  State<Recuperar> createState() => _RecuperarState();
}

Future sendingmail(String to_email) async {
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
          "to_email": to_email.toString(),
        }
      }));
  print(respond.body);
}

class _RecuperarState extends State<Recuperar> {
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
            height: size.height * 0.45,
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
            height: 48.0,
          ),
          if (!_showErrorConexion)
            Text(
              'Recuperar contraseña',
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
            setState(() {
              _errorUsuario = null;
            });

            Future<void> verificarCorreo() async {
              try {
                var url = Uri.parse(
                    'http://phynomo-001-site1.atempurl.com/api/Usuario/ExisteCorreo?correo=' +
                        correo.toString()); //Url
                final response = await http
                    .get(url, headers: {'Content-Type': 'application/json'});

                if (response.statusCode == 200) {
                  final jsonData = json.decode(response.body);
                  String data = jsonData["data"].toString();

                  if (data.toString().contains("No Existe")) {
                    setState(() {
                      _errorUsuario = "Correo inexistente";
                    });
                  } else {
                    sendingmail(correo);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecuperarCodigo()),
                    );
                  }
                } else {
                  setState(() {
                    _errorUsuario = "Error al verificar, intentalo luego";
                  });
                }
              } catch (error) {
                setState(() {
                  _errorUsuario = "Conexion perdida, intentalo luego";
                });
                print(error.toString());
              }
            }

            if (correo != "") {
              verificarCorreo();
            } else {
              setState(() {
                _errorUsuario = "Complete este campo";
              });
            }
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
            setState(() {
              correo = "";
            });
            Navigator.pop(context);
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
                      backgroundColor: Color.fromRGBO(250, 250, 250,1),
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
                  'Ingresa el ultimo codigo de verificacion que fue enviado',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Codigo', errorText: _codigoerror),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    final RegExp regex = RegExp(r'^\d{4}$');
                    if (!regex.hasMatch(value)) {
                      return 'El codigo debe tener 6 digitos';
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
                          final RegExp regex = RegExp(r'^\d{6}$');
                          setState(() {
                            _codigoerror = null;
                          });

                          if (codigoUsuario != "" &&
                              regex.hasMatch(codigoUsuario)) {
                            if (codigoUsuario == codigoGenerado) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecuperarContrasena()),
                              );
                            } else {
                              setState(() {
                                _codigoerror = "El codigo no concuerda";
                              });
                            }
                          } else {
                            setState(() {
                              _codigoerror = "Este campo es requerido";
                            });
                            if (!regex.hasMatch(codigoUsuario)) {
                              setState(() {
                                _codigoerror = 'Ingresa el codigo de 6 digitos';
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
                                builder: (context) => LoginPage()),
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

class RecuperarContrasena extends StatefulWidget {
  const RecuperarContrasena({Key key}) : super(key: key);

  @override
  State<RecuperarContrasena> createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  String _contrasenaerror;
  bool _showErrorMessage = false;
  bool _showErrorConexion = false;
  String quepasa = "";
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
                      backgroundColor: Color.fromRGBO(250, 250, 250,1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Nueva contraseña',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ingresa tu nueva contraseña, recuerda no olvidarla',
                  style: TextStyle(fontSize: 16.0),
                ),
                if (_showErrorMessage)
                  Text(
                    'Ocurrió un error: ' + quepasa.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                if (_showErrorConexion)
                  Text(
                    'Error de conexion, intentelo luego',
                    style: TextStyle(color: Colors.red),
                  ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nueva contraseña',
                      errorText: _contrasenaerror),
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  initialValue: password,
                  onChanged: (value) {
                    password = value;
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
                          setState(() {
                            _contrasenaerror = null;
                          });
                          if (password != "") {
                            var data = {
                              'usua_Contrasena': password,
                              'usua_Correo': correo
                            }; //datos xd

                            Future<void> enviarJson() async {
                              var jsonBody = jsonEncode(data);
                              final url = Uri.parse(
                                  'http://phynomo-001-site1.atempurl.com/api/Usuario/Recuperar');
                              final response = await http.put(
                                url,
                                body: jsonBody,
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                              );
                              if (response.statusCode == 200) {
                                var jsonResponse = jsonDecode(response.body);
                                var message = jsonResponse['message'];
                                if (message == "usuario recuperado") {
                                  ElegantNotification.success(
                                    // title:  Text("Exitoso"),
                                    description: Text(
                                      "Contraseña restablecida exitosamente",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ).show(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                } else {
                                  setState(() {
                                    quepasa = message;
                                    _showErrorMessage = true;
                                  });
                                }
                              } else {
                                print(response.statusCode.toString());
                                setState(() {
                                  quepasa = response.statusCode.toString();
                                  _showErrorConexion = true;
                                });
                              }
                            }

                            // enviarJson();
                            enviarJson();
                          }
                        },
                        child: Text('Guardar contraseña'),
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
                                builder: (context) => LoginPage()),
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
