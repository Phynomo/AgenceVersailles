import 'package:flutter/material.dart';
import 'package:travelappui/views/Admin/admin.dart';
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/HomePage/homepageamerica.dart';
import 'package:travelappui/views/HomePage/homepageasia.dart';
import 'package:travelappui/views/HomePage/homepageeuropa.dart';
import 'package:travelappui/views/HomePage/homepagemaseconomico.dart';
import 'package:travelappui/views/HomePage/homepagetodo.dart';
import 'package:travelappui/views/Login/restaurar/restaurar.dart';
import 'package:travelappui/views/MisReservacionesPage/pruebareservaciones.dart';
import 'package:travelappui/views/ProfilePage/profilepage.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:travelappui/views/ViewDetails/viewDetails.dart';
import 'package:travelappui/views/ViewDetails/viewDetailsReservacion.dart';
import 'package:travelappui/views/Login/login.dart';
import 'package:travelappui/views/MisReservacionesPage/misreservaciones.dart';
import 'package:travelappui/views/Signup/signup.dart';
import 'package:travelappui/views/Paquetes/insertarpaquete.dart';
import 'package:travelappui/views/conocenos/conocenos.dart';

class AppRoutes {


  static const String ROUTE_Initial = ROUTE_Splashscreen;

  static const String ROUTE_Home = "/Popular";
  static const String ROUTE_HomeAll = "/Todo";
  static const String ROUTE_Splashscreen = "/splash";
  static const String ROUTE_ViewDetails = "/view";
  static const String ROUTE_ViewDetailsReservacion = "/viewReservacion";
  static const String ROUTE_Login = "/login";
  static const String ROUTE_MisReservaciones = "/reservaciones";
  static const String ROUTE_SingUp = "/signup";
  static const String ROUTE_Restaurar = "/recuperar";
  static const String ROUTE_Profile = "/perfil";
  static const String ROUTE_Admin = "/admin";
  static const String ROUTE_Ddl = "/drop";
  static const String ROUTE_InsertPaquete = "/insertPaquete";
  static const String ROUTE_HomeEuropa = "/Europa";
  static const String ROUTE_HomeAmerica = "/América";
  static const String ROUTE_HomeAsia = "/Asia";
  static const String ROUTE_Economico = "/Más económico";
  static const String ROUTE_Conocenos = "/conocenos";
  static const String prueba = "/prueba";
  
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_Home:
        return MaterialPageRoute(          
            settings: settings, builder: (_) => HomePage());
        break;
      case ROUTE_Splashscreen:
          return MaterialPageRoute(
            settings: settings, builder: (_) => SplashScreen());
        break;
      case ROUTE_ViewDetails:
          return MaterialPageRoute(
            settings: settings, builder: (_) => ViewDetails());
        break;
      case ROUTE_ViewDetailsReservacion:
          return MaterialPageRoute(
            settings: settings, builder: (_) => ViewDetailsReservacion());
        break;
      case ROUTE_Login:
          return MaterialPageRoute(
            settings: settings, builder: (_) => LoginPage());
        break;
      case ROUTE_MisReservaciones:
          return MaterialPageRoute(
            settings: settings, builder: (_) => MisReservacionesPage());
        break;
      case ROUTE_HomeAll:
          return MaterialPageRoute(
            settings: settings, builder: (_) => HomePageAll());
      break;
      case ROUTE_SingUp:
          return MaterialPageRoute(
            settings: settings, builder: (_) => Signupscreen());
      break;
      case ROUTE_Restaurar:
          return MaterialPageRoute(
            settings: settings, builder: (_) => Recuperar());
      break;
      case ROUTE_Admin:
          return MaterialPageRoute(
            settings: settings, builder: (_) => AdminPage());
      break;
      case ROUTE_Profile:
          return MaterialPageRoute(
            settings: settings, builder: (_) => PerfilPage());
      break;
      case ROUTE_InsertPaquete:
          return MaterialPageRoute(
            settings: settings, builder: (_) => FormPaquetePage());
      break;
      case ROUTE_HomeEuropa:
          return MaterialPageRoute(
            settings: settings, builder: (_) => HomePageEuropa());
      break;
      case ROUTE_HomeAmerica:
          return MaterialPageRoute(
            settings: settings, builder: (_) => HomePageAmerica());
      break;
      case ROUTE_HomeAsia:
          return MaterialPageRoute(
            settings: settings, builder: (_) => HomePageAsia());
      break;
      case ROUTE_Economico:
          return MaterialPageRoute(
            settings: settings, builder: (_) => HomePageEconomico());
      break;
      case ROUTE_Conocenos:
          return MaterialPageRoute(
            settings: settings, builder: (_) => ConocenosPage());
      break;
      case prueba:
          return MaterialPageRoute(
            settings: settings, builder: (_) => Prueba());
      break;
    }
  }
}
