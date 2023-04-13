import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/routes/routes.dart';
import 'package:travelappui/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(children: [
        Container(
          height: size.height * 0.55,
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
              image: AssetImage('assets/image/LogoFondoMoradoConL.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: size.height * 0.45,
          padding: EdgeInsets.all(32),
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Text(
                //"¡Bienvenue à la meilleure agence!",
                "¡Empieza tu viaje con nosotros!",
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: appTheme.textTheme.headline1,
              )),
              SizedBox(height: 18),
              Text(
                "Realiza tus reservaciones de viaje con nosotros, pero antes inicia sesión o crea una cuenta nueva",
                maxLines: 4,
                overflow: TextOverflow.fade,
                style: appTheme.textTheme.bodyText1,
              ),
              SizedBox(height: 18),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.ROUTE_Home);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: appTheme.accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'PlayFair',
                          fontWeight: FontWeight.bold)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Iniciar sisión"),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
