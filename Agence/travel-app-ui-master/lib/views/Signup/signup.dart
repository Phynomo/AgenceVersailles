import 'dart:io';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/services/photos_service.dart';
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/login.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key key}) : super(key: key);
  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

String codigoGenerado = "";
String codigoUsuario = "";
String _nombre = "";
String _email = "";
String _apellido = "";
String _identidad = "";
String _sexo = "";
String _fechanacimiento = "";
String _estadocivil = "";
String _usuario = "";
String _celular = "";
String _contrasena = "";
File _imagePerfil;

int generateRandomNumber() {
  var rng = new Random();
  return rng.nextInt(900000) + 100000;
}

Future sendingmail(String to_email) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const service_id = "service_j1kwebo";
  const template_id = "template_zskowtj";
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

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                top: 10,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Flexible(
                        child: Image.asset(
                          "assets/image/LogoMorado.png",
                          height: 250.0,
                        ),
                      ),
                      Text(
                        "Agence Versailles",
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "¿Quieres vivir las mejores experiencias en tus viajes?",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Pues empecemos con tu registro y vive las mejores experiencias",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpNombres(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'PlayFair',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("¡Iniciemos tu viaje!"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpNombres extends StatefulWidget {
  const SignUpNombres({Key key}) : super(key: key);

  @override
  State<SignUpNombres> createState() => _SignUpNombresState();
}

class _SignUpNombresState extends State<SignUpNombres> {
  String _nombreerror;
  String _apellidoerror;
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Nombres',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  'Primero ingresa tu hermoso nombre',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    errorText: _nombreerror,
                  ),
                  style: TextStyle(color: Colors.black),
                  initialValue: _nombre,
                  onChanged: (value) {
                    _nombre = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    errorText: _apellidoerror,
                  ),
                  style: TextStyle(color: Colors.black),
                  initialValue: _apellido,
                  onChanged: (value) {
                    _apellido = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _nombreerror = null;
                            _apellidoerror = null;
                          });
                          if (_nombre != "" && _apellido != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpIdentidad()),
                            );
                          } else {
                            if (_nombre == "") {
                              setState(() {
                                _nombreerror = "Este campo es requerido";
                              });
                            }
                            if (_apellido == "") {
                              setState(() {
                                _apellidoerror = "Este campo es requerido";
                              });
                            }
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpIdentidad extends StatefulWidget {
  const SignUpIdentidad({Key key}) : super(key: key);

  @override
  State<SignUpIdentidad> createState() => _SignUpIdentidadState();
}

class _SignUpIdentidadState extends State<SignUpIdentidad> {
  String _identidaderror;
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Identidad',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu numero de identidad',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Numero de identidad',
                      errorText: _identidaderror),
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
                  initialValue: _identidad,
                  onChanged: (value) {
                    _identidad = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          final RegExp regex = RegExp(r'^\d{4}-\d{4}-\d{5}$');
                          setState(() {
                            _identidaderror = null;
                          });

                          Future<void> disponibleDNI() async {
                            String apiUrl =
                                "http://phynomo-001-site1.atempurl.com/api/Persona/Existe?identidad=" +
                                    _identidad; // URL de la API

                            try {
                              final response =
                                  await http.get(Uri.parse(apiUrl));

                              if (response.statusCode == 200) {
                                final jsonData = json.decode(response.body);
                                String data = jsonData["data"].toString();

                                if (data.toString().contains("No puede")) {
                                  setState(() {
                                    _identidaderror = "Este DNI ya esta en uso";
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpSexo()),
                                  );
                                }
                              } else {
                                setState(() {
                                  _identidaderror =
                                      "Error al verificar, intentalo luego";
                                });
                              }
                            } catch (error) {
                              setState(() {
                                _identidaderror =
                                    "Error de conexion, intentalo luego";
                              });
                            }
                          }

                          if (_identidad != "" && regex.hasMatch(_identidad)) {
                            disponibleDNI();
                          } else {
                            setState(() {
                              _identidaderror = "Este campo es requerido";
                            });
                            if (!regex.hasMatch(_identidad)) {
                              setState(() {
                                _identidaderror =
                                    'Formato no valido (0000-0000-00000)';
                              });
                            }
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

enum Gender { male, female }

class SignUpSexo extends StatefulWidget {
  const SignUpSexo({Key key}) : super(key: key);

  @override
  State<SignUpSexo> createState() => _SignUpSexoState();
}

class _SignUpSexoState extends State<SignUpSexo> {
  bool _sexoerror = false;
  Gender _gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Sexo',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu sexo biologico',
                  style: TextStyle(fontSize: 16.0),
                ),
                RadioListTile(
                  title: Text(
                    'Masculino',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text(
                    'Femenino',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                if (_sexoerror)
                  Text(
                    'Selecciona uno de los dos sexos',
                    style: TextStyle(color: Colors.red),
                  ),
                // TextFormField(
                //   decoration:
                //       InputDecoration(labelText: 'Sexo', errorText: _sexoerror),
                //   style: TextStyle(color: Colors.black),
                //   initialValue: _sexo,
                //   onChanged: (value) {
                //     _sexo = value;
                //   },
                // ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _sexoerror = false;
                          });

                          if (_gender == Gender.male) {
                            _sexo = "M";
                          } else if (_gender == Gender.female) {
                            _sexo = "F";
                          }

                          if (_sexo != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpFechaNacimiento()),
                            );
                          } else {
                            setState(() {
                              _sexoerror = true;
                            });
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple.shade900,
                          // Define el color de fondo
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

  DateTime _selectedDate = null;

class SignUpFechaNacimiento extends StatefulWidget {
  const SignUpFechaNacimiento({Key key}) : super(key: key);

  @override
  State<SignUpFechaNacimiento> createState() => _SignUpFechaNacimientoState();
}

class _SignUpFechaNacimientoState extends State<SignUpFechaNacimiento> {
  String _fechanacimientoerror;
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Cuando naciste',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu fecha de nacimiento',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2025, 12, 31),
                      onConfirm: (date) {
                        setState(() {
                          _selectedDate = date;
                          _fechanacimiento = date.toString();
                        });
                      },
                      currentTime: _selectedDate != null
                          ? _selectedDate
                          : DateTime.now(),
                      locale: LocaleType.es,
                    );
                  },
                  decoration: InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      errorText: _fechanacimientoerror),
                  style: TextStyle(color: Colors.black),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('yyyy/MM/dd').format(_selectedDate)
                        : 'Seleccione una fecha',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Por favor seleccione una fecha';
                    }
                    _fechanacimiento = value.toString();
                    return null;
                  },
                  onChanged: (value) {
                    _fechanacimiento = value.toString();
                    print(_fechanacimiento);
                  },
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //       labelText: 'Fecha de nacimiento',
                //       errorText: _fechanacimientoerror),
                //   style: TextStyle(color: Colors.black),
                //   initialValue: _fechanacimiento,
                //   onChanged: (value) {
                //     _fechanacimiento = value;
                //   },
                // ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            //_fechanacimientoerror = null;
                            _fechanacimientoerror = "Este campo es requerido";
                          });
                          int edad = 18;

                          if (_fechanacimiento.toString() != "") {
                            DateTime fechaActual = DateTime.now();

                            Duration diferencia =
                                fechaActual.difference(_selectedDate);
                            edad = diferencia.inDays ~/
                                365; // Calcula la edad en años
                          }

                          if (_fechanacimiento.toString() != "" && edad >= 18) {
                            setState(() {
                              _fechanacimientoerror = null;
                              //_fechanacimientoerror = "Este campo es requerido";
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpEstadoCivil(),
                              ),
                            );
                          } else {
                            setState(() {
                              // _fechanacimientoerror = null;
                              _fechanacimientoerror = "Este campo es requerido";
                            });
                            if (edad < 18) {
                              setState(() {
                                _fechanacimientoerror =
                                    "Tienes que ser mayor de edad";
                              });
                            }
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpEstadoCivil extends StatefulWidget {
  const SignUpEstadoCivil({Key key}) : super(key: key);

  @override
  State<SignUpEstadoCivil> createState() => _SignUpEstadoCivilState();
}

class _SignUpEstadoCivilState extends State<SignUpEstadoCivil> {
  bool _estadocivilerror = false;
  // String dropdownValue = 'Option 1';
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Estado Civil',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu estado civil',
                  style: TextStyle(fontSize: 16.0),
                ),
                MyDropdownButton(),
                if (_estadocivilerror)
                  Text(
                    'Selecciona un estado civil',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _estadocivilerror = false;
                          });
                          if (_estadocivil != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpCelular()),
                            );
                          } else {
                            setState(() {
                              _estadocivilerror = true;
                            });
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpCelular extends StatefulWidget {
  const SignUpCelular({Key key}) : super(key: key);

  @override
  State<SignUpCelular> createState() => _SignUpCelularState();
}

class _SignUpCelularState extends State<SignUpCelular> {
  String _celularerror;
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Celular',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu numero celular',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Celular', errorText: _celularerror),
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  initialValue: _celular,
                  onChanged: (value) {
                    _celular = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _celularerror = null;
                          });
                          if (_celular != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpUsuario()),
                            );
                          } else {
                            setState(() {
                              _celularerror = "Este campo es requerido";
                            });
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpUsuario extends StatefulWidget {
  const SignUpUsuario({Key key}) : super(key: key);

  @override
  State<SignUpUsuario> createState() => _SignUpUsuarioState();
}

class _SignUpUsuarioState extends State<SignUpUsuario> {
  String _usuarioerror;
  String _emailerror;
  bool puedepasar = false;
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Identificadores',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa un usuario y un correo',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Usario', errorText: _usuarioerror),
                  style: TextStyle(color: Colors.black),
                  initialValue: _usuario,
                  onChanged: (value) {
                    _usuario = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Correo', errorText: _emailerror),
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  initialValue: _email,
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _emailerror = null;
                            _usuarioerror = null;
                          });
                          Future<void> verificarUsuario() async {
                            String apiUrl =
                                "http://phynomo-001-site1.atempurl.com/api/Usuario/Existe?usuario=" +
                                    _usuario; // URL de la API

                            try {
                              final response =
                                  await http.get(Uri.parse(apiUrl));

                              if (response.statusCode == 200) {
                                final jsonData = json.decode(response.body);
                                String data = jsonData["data"].toString();

                                if (data.toString().contains("No puede")) {
                                  setState(() {
                                    _usuarioerror =
                                        "Este usuario ya esta en uso";
                                  });
                                  puedepasar = false;
                                } else {
                                  puedepasar = true;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           SignUpContrasena()),
                                  // );
                                }
                              } else {
                                setState(() {
                                  _usuarioerror =
                                      "Error al verificar, intentalo luego";
                                });
                              }
                            } catch (error) {
                              setState(() {
                                _usuarioerror =
                                    "Error al verificar, intentalo luego";
                              });
                            }
                          }

                          Future<void> verificarCorreo() async {
                            var url = Uri.parse(
                                'http://phynomo-001-site1.atempurl.com/api/Usuario/ExisteCorreo?correo=' +
                                    _email.toString()); // URL de la API

                            try {
                              final response = await http.get(url, headers: {
                                'Content-Type': 'application/json'
                              });

                              if (response.statusCode == 200) {
                                final jsonData = json.decode(response.body);
                                String data = jsonData["data"].toString();

                                if (data.toString().contains("Si Existe")) {
                                  setState(() {
                                    _emailerror = "Este correo en uso";
                                  });
                                  puedepasar = false;
                                } else {
                                  puedepasar = true;
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           SignUpCodigo()),
                                  // );
                                }
                              } else {
                                setState(() {
                                  _emailerror =
                                      "Error al verificar, intentalo luego";
                                });
                              }
                            } catch (error) {
                              setState(() {
                                _emailerror =
                                    "Conexion perdida, intentalo luego";
                              });
                            }
                          }

                          String pattern = r'\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}';

                          final RegExp regex =
                              RegExp(r'\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}');
                          RegExp regExp = new RegExp(pattern);

                          if (_usuario != "" &&
                              _email != "" &&
                              regex.hasMatch(_email)) {
                            Future<void> verificarPaso() async {
                              if (puedepasar) {
                                sendingmail(_email);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpCodigo()),
                                );
                              }
                            }

                            Future<void>
                                sincronizadorDeIdentificadores() async {
                              await verificarUsuario();
                              await verificarCorreo();
                              await verificarPaso();
                            }

                            sincronizadorDeIdentificadores();
                          } else {
                            if (_usuario == "") {
                              setState(() {
                                _usuarioerror = "Este campo es requerido";
                              });
                            }
                            if (_email == "") {
                              setState(() {
                                _emailerror = "Este campo es requerido";
                              });
                            }
                            if (!regex.hasMatch(_email)) {
                              setState(() {
                                _emailerror =
                                    "Se necesita un correo electronico";
                              });
                            }
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpCodigo extends StatefulWidget {
  const SignUpCodigo({Key key}) : super(key: key);

  @override
  State<SignUpCodigo> createState() => _SignUpCodigoState();
}

class _SignUpCodigoState extends State<SignUpCodigo> {
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Codigo',
                      style: TextStyle(
                        fontSize: 21.0,
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
                    final RegExp regex = RegExp(r'^\d{6}$');
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
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
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
                                    builder: (context) => SignUpIMGPerfil()),
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
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class SignUpContrasena extends StatefulWidget {
  const SignUpContrasena({Key key}) : super(key: key);

  @override
  State<SignUpContrasena> createState() => _SignUpContrasenaState();
}

class _SignUpContrasenaState extends State<SignUpContrasena> {
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
                      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Registro / Contraseña',
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu contraseña, recuerda no olvidarla',
                  style: TextStyle(fontSize: 16.0),
                ),
                if (_showErrorMessage)
                  Text(
                    'Ocurrió un error: ' + quepasa.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                if (_showErrorConexion)
                  Text(
                    'Ocurrió un error: ' + quepasa.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Contraseña', errorText: _contrasenaerror),
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  initialValue: _contrasena,
                  onChanged: (value) {
                    _contrasena = value;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .purple.shade900, // Define el color de fondo
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _contrasenaerror = null;
                          });
                          if (_contrasena != "") {
                            var urlImagePerfile = "https://i.ibb.co/NTYrJXY/Imagen-de-Whats-App-2023-04-23-a-las-12-47-54.jpg";

                            Future<void> enviarJson() async {
                              var data = {
                                'pers_Nombres': _nombre,
                                'pers_Apellidos': _apellido,
                                'pers_Identidad': _identidad,
                                'estc_Id': int.parse(_estadocivil),
                                'usua_PerfilImage': urlImagePerfile.toString(),
                                "pers_FechaNacimiento": _fechanacimiento
                                    .replaceFirst(" 00:00:00.000", ""),
                                'pers_Sexo': _sexo,
                                'pers_Celular': _celular,
                                'pers_EsEmpleado': false,
                                'usua_NombreUsuario': _usuario,
                                'usua_Correo': _email,
                                'usua_Contrasena': _contrasena,
                                'usua_UsuCreacion': 1
                              };

                              var jsonBody = jsonEncode(data);
                              final url = Uri.parse(
                                  'http://phynomo-001-site1.atempurl.com/api/Usuario/Registrarse');
                              final response = await http.post(
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
                                if (message ==
                                    "El registro se ha insertado con éxito") {
                                      vaciarDatos();
                                  ElegantNotification.success(
                                    // title:  Text("Exitoso"),
                                    description: Text(
                                      "Usuario creado correctamente",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    toastDuration:
                                        const Duration(milliseconds: 5000),
                                    animationDuration:
                                        const Duration(milliseconds: 700),
                                  ).show(context);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen()),
                                  );
                                } else {
                                  setState(() {
                                    quepasa = message;
                                    _showErrorMessage = true;
                                  });
                                }
                              } else {
                                setState(() {
                                  quepasa = response.statusCode.toString();
                                  _showErrorConexion = true;
                                });
                              }
                            }

                            // enviarJson();

                            Future<void> terminarRegistro() async {
                              if (_imagePerfil != null) {
                                var urlobtenida =
                                    await uploadImage(_imagePerfil);
                                setState(() {
                                  urlImagePerfile = urlobtenida.toString();
                                });
                              }
                              await enviarJson();
                            }

                            terminarRegistro();
                          } else {
                            setState(() {
                              _contrasenaerror = "Ingrese una contraseña";
                            });
                          }
                        },
                        child: Icon(Icons.arrow_forward_outlined),
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                         vaciarDatos();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          '¿Ya tienes cuenta?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
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

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

String _selectedValue = 'Seleccione un estado civil';

class _MyDropdownButtonState extends State<MyDropdownButton> {
  List<Map<String, dynamic>> estadosCiviles = [
    {"id": 1, "nombre": "Soltero(a)"},
    {"id": 2, "nombre": "Casado(a)"},
    {"id": 3, "nombre": "Divorciado(a)"},
    {"id": 4, "nombre": "Viudo(a)"},
  ];
  void _showDropdown() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: estadosCiviles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  estadosCiviles[index]['nombre'],
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedValue = estadosCiviles[index]['nombre'];
                    _estadocivil = estadosCiviles[index]['id'].toString();
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 40.0,
            child: ElevatedButton(
              onPressed: _showDropdown,
              child: Text(_selectedValue),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 252, 252, 1),
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                      color: Color.fromRGBO(255, 252, 252, 1), width: 1),
                  // Puedes personalizar los otros lados de la misma manera
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SignUpIMGPerfil extends StatefulWidget {
  const SignUpIMGPerfil({Key key}) : super(key: key);

  @override
  State<SignUpIMGPerfil> createState() => _SignUpIMGPerfilState();
}

class _SignUpIMGPerfilState extends State<SignUpIMGPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
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
                    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                    foregroundColor: Colors.purple.shade900,
                    elevation: 0,
                    child: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Registro / Foto de Perfil',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Ahora ingresa tu foto de perfil',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Column(children: [
                if (_imagePerfil != null)
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          image: DecorationImage(
                            image: FileImage(_imagePerfil),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                              width: 2, color: kAccentColor.withOpacity(0.7)),
                          borderRadius: BorderRadius.circular(300.0)),
                    ),
                  )
                else
                  Center(
                    child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 228, 228, 228),
                            border: Border.all(
                                width: 2, color: kAccentColor.withOpacity(0.7)),
                            borderRadius: BorderRadius.circular(300.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              size: 80.0,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                      child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(200, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    onPressed: () {
                      getImage(source: ImageSource.gallery);
                    },
                    child: Text(
                      "Seleccionar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(200, 38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    onPressed: () {
                      getImage(source: ImageSource.camera);
                    },
                    child: Text(
                      "Cámara",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  )),
                ]),
              ]),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.purple.shade900, // Define el color de fondo
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.33,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpContrasena()),
                        );
                      },
                      child: Icon(Icons.arrow_forward_outlined),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.purple.shade900, // Define el color de fondo
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
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextButton(
                      onPressed: () {
                        vaciarDatos();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        '¿Ya tienes cuenta?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void getImage({ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _imagePerfil = File(file.path);
      });
    }
  }
}


void vaciarDatos() {
                        _nombre = "";
                        _email = "";
                        _apellido = "";
                        _identidad = "";
                        _sexo = "";
                        _fechanacimiento = "";
                        _estadocivil = "";
                        _usuario = "";
                        _celular = "";
                        _contrasena = "";
                        _imagePerfil = null;
                        _selectedDate = null;
}