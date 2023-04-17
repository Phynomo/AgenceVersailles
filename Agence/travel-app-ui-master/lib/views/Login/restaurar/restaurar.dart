import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/routes/routes.dart';
import 'package:travelappui/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/Login/restaurar/restaurar.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:mailer/smtp_server/gmail.dart';



String usuario = "";
String password = "";

class Recuperar extends StatefulWidget {
  const Recuperar({Key key}) : super(key: key);

  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {
Future<void> sendingmail() async {
  
   var userEmail = "agenceversailles.65@gmail.com";
   var message = Message();
   message.subject = "Hola de nuevo";
   message.text = "Hey TQM";
   message.from = Address(userEmail.toString()); 
   message.recipients.add(userEmail);
   var smtpServer = gmailSaslXoauth2(userEmail, 'wsdjohmnfisrpyeh');
   send(message, smtpServer);
   print("Exito hurraaaaaaaaaan se envio o algo asi ");
  
}


  TextEditingController _textController = TextEditingController();
  String _errorUsuario;
  String _errorPassword;
  bool _showErrorMessage = false;
  bool _showErrorConexion = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
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
        SizedBox(height: 20.0,),
        if(!_showErrorMessage && !_showErrorConexion)
        Text(
                'Recuperar usuario',
                style: TextStyle(color: Colors.black),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          // alignment: Alignment.bottomCenter,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //  SizedBox(height: 15.0),
            
              _userTextField(),
            SizedBox(height: 15.0),
            _passwordTextField(),
            SizedBox(height: 20.0),
            _buttonLogin(),
            SizedBox(height: 10.0),
            _buttonRecuperar(),


            ],
          ),
        )
      ]),
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
          onPressed: sendingmail,
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
        ),
      );
    });
  }

  Widget _buttonRecuperar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Center(
        child: TextButton(
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
        ),
      );
    });
  }



}



