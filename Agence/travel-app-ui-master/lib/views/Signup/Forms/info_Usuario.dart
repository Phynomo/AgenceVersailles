import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';

String usuario = "";
String password = "";

class InfoUsuario extends StatefulWidget {
  const InfoUsuario({Key key}) : super(key: key);
  static String id = "login_page";

  @override
  State<InfoUsuario> createState() => _InfoUsuarioState();
}

class _InfoUsuarioState extends State<InfoUsuario> {
  TextEditingController _textController = TextEditingController();
  String _errorUsuario;
  String _errorPassword;
  bool _showErrorMessage = false;
  bool _showErrorConexion = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Agence Versailles",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              if (_showErrorMessage)
                Text(
                  'Usuario o contraseña incorrectos',
                  style: TextStyle(color: Colors.red),
                ),
                if (_showErrorConexion)
                Text(
                  'Error de conexion, Intentalo mas tarde',
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(
                height: 15.0,
              ),
              _userTextField(),
              SizedBox(
                height: 15.0,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20.0,
              ),
              _buttonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.people_alt),
            hintText: "Usuario o Correo",
            hoverColor: Colors.purple.shade900,
            labelText: "Ingresa tu usuario o tu correo",
            iconColor: Colors.purple.shade900,
            errorText: _errorUsuario,
          ),
          onChanged: (value) {
            usuario = value;
          },
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
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

  Widget _buttonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          try {
            setState(() {
              _errorPassword = '';
              _errorUsuario = '';
              _showErrorMessage = false;
              _showErrorConexion = false;
            });
            if (usuario != "" && password != "") {
              var data = {
                'usua_NombreUsuario': usuario,
                'usua_Correo': usuario,
                'usua_Contrasena': password
              }; //datos xd

              var body = json.encode(data); //Json encriptado

              var url = Uri.parse(
                  'http://www.agenciaversalles.somee.com/api/Usuario/Login'); //Url

              http.put(url, body: body, headers: {
                'Content-Type': 'application/json'
              }).then((response) {
                //Brujeria
                if (response.statusCode == 200) {
                  // resultado
                  var jsonResponse = jsonDecode(response.body);
                  var data = jsonResponse['data'];
                  if (data != null && data.toString().length > 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    setState(() {
                      _showErrorMessage = true;
                    });
                  }
                } else {
                  setState(() {
                      _showErrorConexion = true;
                    });
                }
              }); //tqm, gracias por el carrito
            } else {
              if (usuario.isEmpty) {
                setState(() {
                  _errorUsuario = 'Complete el campo';
                });
              }
              if (password.isEmpty) {
                setState(() {
                  _errorPassword = 'Complete el campo';
                });
              }
            }
          } catch (e) {}
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            "Inciar Sesión",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.purple.shade900),
        ),
      );
    });
  }
}
