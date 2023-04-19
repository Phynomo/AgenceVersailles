import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/models/usuarioModel.dart';
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/restaurar/restaurar.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html';

String usuario = "";
String password = "";

UsuarioModel sacainfoUsuario(info) {
  UsuarioModel usuario = new UsuarioModel();

  usuario.usuaId = info[0]["usua_Id"].toString();
  usuario.usuaNombreUsuario = info[0]["usua_NombreUsuario"].toString();
  usuario.usuaCorreo = info[0]["usua_Correo"].toString();
  usuario.usuaContrasena = info[0]["usua_Contrasena"].toString();
  usuario.persId = info[0]["pers_Id"].toString();
  usuario.usuaPersonaNombreCompleto =
      info[0]["usua_PersonaNombreCompleto"].toString();
  usuario.usuaEsAdmin = info[0]["usua_EsAdmin"].toString();

  return usuario;
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static String id = "login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textController = TextEditingController();
  String _errorUsuario;
  String _errorPassword;
  bool _showErrorMessage = false;
  bool _showErrorConexion = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            SizedBox(height: 15.0),
            Flexible(
              child: Image.asset(
                "assets/image/LogoMorado.png",
                height: 300.0,
              ),
            ),
            Center(
              child: Text(
                "Agence Versailles",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            if (_showErrorMessage)
              Center(
                child: Text(
                  'Usuario o contraseña incorrectos',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (_showErrorConexion)
              Center(
                child: Text(
                  'Error de conexion, Intentalo mas tarde',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 15.0),
            _userTextField(),
            SizedBox(height: 15.0),
            _passwordTextField(),
            SizedBox(height: 20.0),
            SizedBox(
              width: 10.0,
              child: _buttonLogin(),
            ),
            SizedBox(height: 10.0),
            _buttonRecuperar(),
          ],
        ),
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
      return Center(
        child: ElevatedButton(
          onPressed: () {
            Future<void> iniciarsesionlogin() async {
              try {
                // var data = {
                //   'usua_NombreUsuario': usuario,
                //   'usua_Correo': usuario,
                //   'usua_Contrasena': password
                // }; //datos xd

                // var body = json.encode(data); //Json encriptado

                var url =
                    'https://localhost:44313/api/Usuario/Login?usuario=$usuario&contrasena=$password'; //Url
                final response = await http.get(Uri.parse(url));

                var jsonResponse = jsonDecode(response.body);
                var data = jsonResponse['data'];

                // print(data);

                //Brujeria
                if (response.statusCode == 200) {
                  // resultado

                  if (data != null && data.toString().length > 2) {
                    var usuarioModel = sacainfoUsuario(data);
                    String usuarioJson = jsonEncode(usuarioModel.toJson());
                    window.sessionStorage['usuario'] = usuarioJson;

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
                } //tqm, gracias por el carrito
              } catch (e) {
                print(e.toString());
                setState(() {
                  _showErrorConexion = true;
                });
              }
            }

            try {
              setState(() {
                _errorPassword = null;
                _errorUsuario = null;
                _showErrorMessage = false;
                _showErrorConexion = false;
              });
              if (usuario != "" && password != "") {
                iniciarsesionlogin();
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
              "Iniciar sesión",
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

  Widget _buttonRecuperar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Recuperar(),
            ),
          );
        },
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
      );
    });
  }
}
