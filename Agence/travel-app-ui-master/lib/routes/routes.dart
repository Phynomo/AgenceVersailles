import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepage.dart';
import 'package:travelappui/views/HomePage/homepagetodo.dart';
import 'package:travelappui/views/SplashScreen/splashscreen.dart';
import 'package:travelappui/views/ViewDetails/viewDetails.dart';
import 'package:travelappui/views/Login/login.dart';
import 'package:travelappui/views/MisReservacionesPage/misreservaciones.dart';
import 'package:travelappui/views/Signup/signup.dart';

class AppRoutes {


  static const String ROUTE_Initial = ROUTE_Splashscreen;

  static const String ROUTE_Home = "/Popular";
  static const String ROUTE_HomeAll = "/Todo";
  static const String ROUTE_Splashscreen = "/splash";
  static const String ROUTE_ViewDetails = "/view";
  static const String ROUTE_Login = "/login";
  static const String ROUTE_MisReservaciones = "/reservaciones";
  static const String ROUTE_SingUp = "/signup";

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
    }
  }
}
