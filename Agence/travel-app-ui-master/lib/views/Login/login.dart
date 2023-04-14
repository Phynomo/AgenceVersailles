import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';


String usuario = "";
String password = "";

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static String id = "login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Flexible(
                child: Image.asset(
                  "assets/image/LogoMorado.png",
                  height: 300.0,
                ),
              ),
              Text(
                "Agence Versailles",
                style: TextStyle(
                  fontSize: 24.0,
                ),
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
              labelText: "Ingresa tu usuario o tu correo"),
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
              icon: Icon(Icons.lock),
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
          var data = {'usua_NombreUsuario': usuario, 'usua_Correo': usuario, 'usua_Contrasena': password}; //datos xd

          var body = json.encode(data); //Json encriptado

          var url = Uri.parse('http://www.agenciaversalles.somee.com/api/Usuario/Login'); //Url

          http.put(url, body: body, headers: {'Content-Type': 'application/json'}).then((response) { //Brujeria
          if (response.statusCode == 200) { // resultado
            var jsonResponse = jsonDecode(response.body);
            var data = jsonResponse['data'];
            if (data != null) {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            }else{
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
            }
             
          }else{
            
          }
});       //tqm, gracias por el carrito 
          } catch (e) {
            
          }
          


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
