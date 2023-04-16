import 'package:flutter/material.dart';
import 'package:travelappui/views/Signup/Forms/info_Usuario.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key key}) : super(key: key);
  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

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

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Row(
                        children: [
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple.shade900,
                              elevation: 0,
                              child: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10.0),
                          SizedBox(
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
                        ],
                      ),

                      // SizedBox(height: 10.0,),
                      //    SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.65,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => SplashScreen(),
                      //         ),
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.red.shade600,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //       elevation: 0,
                      //       textStyle: TextStyle(
                      //         fontSize: 18,
                      //         fontFamily: 'PlayFair',
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(12.0),
                      //       child: Text("Regresar"),
                      //     ),
                      //   ),
                      // ),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Nombres',
                      style: TextStyle(
                        fontSize: 24.0,
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
                      width: MediaQuery.of(context).size.width * 0.88,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Identidad',
                      style: TextStyle(
                        fontSize: 24.0,
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
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _identidaderror = null;
                          });
                          if (_identidad != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpSexo()),
                            );
                          } else {
                            setState(() {
                              _identidaderror = "Este campo es requerido";
                            });
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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

class SignUpSexo extends StatefulWidget {
  const SignUpSexo({Key key}) : super(key: key);

  @override
  State<SignUpSexo> createState() => _SignUpSexoState();
}

class _SignUpSexoState extends State<SignUpSexo> {
  String _sexoerror;
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Sexo',
                      style: TextStyle(
                        fontSize: 24.0,
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
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Sexo', errorText: _sexoerror),
                  style: TextStyle(color: Colors.black),
                  initialValue: _sexo,
                  onChanged: (value) {
                    _sexo = value;
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
                            _sexoerror = null;
                          });
                          if (_sexo != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpFechaNacimiento()),
                            );
                          } else {
                            setState(() {
                              _sexoerror = "Este campo es requerido";
                            });
                          }
                        },
                        child: Text('Siguente'),
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
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
                          );
                        },
                        child: Text('Cancelar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade900,
                          // Define el color de fondo
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Fecha de nacimiento',
                      style: TextStyle(
                        fontSize: 24.0,
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
                  decoration: InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      errorText: _fechanacimientoerror),
                  style: TextStyle(color: Colors.black),
                  initialValue: _fechanacimiento,
                  onChanged: (value) {
                    _fechanacimiento = value;
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
                            _fechanacimientoerror = null;
                          });
                          if (_fechanacimiento != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpEstadoCivil(),
                              ),
                            );
                          } else {
                            setState(() {
                              _fechanacimientoerror = "Este campo es requerido";
                            });
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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

class SignUpEstadoCivil extends StatefulWidget {
  const SignUpEstadoCivil({Key key}) : super(key: key);

  @override
  State<SignUpEstadoCivil> createState() => _SignUpEstadoCivilState();
}

class _SignUpEstadoCivilState extends State<SignUpEstadoCivil> {
  String _estadocivilerror;
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
                      'Estado Civil',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu estadi civil',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Estado civil', errorText: _estadocivilerror),
                  style: TextStyle(color: Colors.black),
                  initialValue: _estadocivil,
                  onChanged: (value) {
                    _estadocivil = value;
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
                            _estadocivilerror = null;
                          });
                          if (_estadocivil != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpCelular()),
                            );
                          } else {
                            setState(() {
                              _estadocivilerror = "Este campo es requerido";
                            });
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple.shade900,
                      elevation: 0,
                      child: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Celular',
                      style: TextStyle(
                        fontSize: 24.0,
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
                      width: MediaQuery.of(context).size.width * 0.88,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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

class SignUpUsuario extends StatefulWidget {
  const SignUpUsuario({Key key}) : super(key: key);

  @override
  State<SignUpUsuario> createState() => _SignUpUsuarioState();
}

class _SignUpUsuarioState extends State<SignUpUsuario> {
  String _usuarioerror;
  String _emailerror;
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
                      'Identificadores',
                      style: TextStyle(
                        fontSize: 24.0,
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
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _emailerror = null;
                            _usuarioerror = null;
                          });
                          if (_usuario != "" && _email != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpContrasena()),
                            );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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

class SignUpContrasena extends StatefulWidget {
  const SignUpContrasena({Key key}) : super(key: key);

  @override
  State<SignUpContrasena> createState() => _SignUpContrasenaState();
}

class _SignUpContrasenaState extends State<SignUpContrasena> {
  String _contrasenaerror;
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
                      'Contraseña',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Ahora ingresa tu numero contraseña, recuerda no olvidarla',
                  style: TextStyle(fontSize: 16.0),
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
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _contrasenaerror = null;
                          });
                          if (_contrasena != "") {
                          } else {
                            setState(() {
                              _contrasenaerror = "Este campo es requerido";
                            });
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signupscreen()),
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
