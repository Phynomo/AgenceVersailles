import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
// import 'package:elegant_notification/resources/arrays.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:elegant_notification/elegant_notification.dart';


String urlAll = "http://www.agenciaversalles.somee.com/api/Paquete/Listado";
String urlFeatured =
    "http://www.agenciaversalles.somee.com/api/Paquete/Listado5Caros";
String urlRecommended =
    "http://www.agenciaversalles.somee.com/api/Paquete/Listado10Baratos";
String urlUserPlaces =
    "http://www.agenciaversalles.somee.com/api/Paquete/ListadoPorPersona?id=";
String urlInsertBooking =
    "http://www.agenciaversalles.somee.com/api/Reservacion/Insertar";
String urlDeleteBooking =
    "http://www.agenciaversalles.somee.com/api/Reservacion/Eliminar";
String urlByContinent =
    "http://www.agenciaversalles.somee.com/api/Paquete/ListadoPorContinente?contNombre=";
String urlUpdatePfp =
    "http://www.agenciaversalles.somee.com/api/Usuario/EditarFoto";
// String urlFind = "http://www.agenciaversalles.somee.com/api/Paquete/Find?id=";

class RESTAPI {
  List<PlaceModel> dummyPlaces(List<dynamic> info) {
    List<PlaceModel> lista = [];
    info.forEach((element) {
      String dateStr = element["vuel_FechaSalida"];
      DateTime date = DateTime.parse(dateStr);
      lista.add(PlaceModel(
          paquId: element["paqu_Id"],
          placeTitle: element["paqu_Nombre"],
          description: "I'm mocking y'all",
          duration: 5,
          personas: element["paqu_Personas"].toString(),
          imgUrl: element["paqu_Imagen"],
          locationShort: element["ciud_Nombre"] + ", " + element["pais_Nombre"],
          rateperpackage: element["paqu_Precio"],
          fechaSalida: DateFormat('dd/MM/yyyy').format(date),
          ciudadSalida: element['ciud_Salida'],
          hotelDireccion: element['hote_DireccionExacta'],
          hotelNombre: element['hote_Nombre'],
          agencia: element['agenvuel_Nombre'],
          aeropuerto: element['aero_Nombre'],
          reseId: element['rese_Id'],
          rating: double.parse(element["hote_Estellas"].toString())));
    });
    return lista;
  }

  Future<List<PlaceModel>> getFeaturedPlaces() async {
    final respuesta = await http.get(Uri.parse(urlFeatured));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<List<PlaceModel>> getRecommendedPlaces() async {
    final respuesta = await http.get(Uri.parse(urlRecommended));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<List<PlaceModel>> getAllPlaces(String query) async {
    final respuesta = await http.get(Uri.parse(urlAll));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]).where((element) {
        final titleLower = element.placeTitle.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<dynamic> insertReservacion(data, context) async {
    var body = json.encode(data.toJson());
    var url = Uri.parse(urlInsertBooking);

    http.post(url,
        body: body,
        headers: {'Content-Type': 'application/json'}).then((response) {
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // resultado
        // print(jsonResponse["message"].toString());
        print(jsonResponse["message"].toString());
        ElegantNotification.success(
          // title:  Text("Exitoso"),
          description: Text(
            "El paquete ha sido agregado a 'Mis Reservaciones'",
            style: TextStyle(color: Colors.black),
          ),
          // toastDuration: const Duration(milliseconds: 5000),
          // animationDuration: const Duration(milliseconds: 700),
        ).show(context);
      } else {
        print(jsonResponse["message"].toString());
        ElegantNotification.error(
          // title:  Text("Exitoso"),
          description: Text(
            "Ha ocurrido un error",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      }
    });
  }

  Future<dynamic> eliminarReservacion(data, context) async {
    var body = json.encode(data.toJson());
    var url = Uri.parse(urlDeleteBooking);

    http.put(url,
        body: body,
        headers: {'Content-Type': 'application/json'}).then((response) {
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // resultado
        // print(jsonResponse["message"].toString());
        print(jsonResponse["message"].toString());
        ElegantNotification.success(
          // title:  Text("Exitoso"),
          description: Text(
            "La reservación ha sido cancelada",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);

        Navigator.pushNamed(context, "/reservaciones");
      } else {
        print(jsonResponse["message"].toString());
        ElegantNotification.error(
          // title:  Text("Exitoso"),
          description: Text(
            jsonResponse["message"].toString(),
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      }
    });
  }

  Future<List<PlaceModel>> getPaquetesXPersona(persId) async {
    final respuesta =
        await http.get(Uri.parse(urlUserPlaces + persId.toString()));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<List<PlaceModel>> getPaquetesXContinente(contNombre) async {
    final respuesta =
        await http.get(Uri.parse(urlByContinent + contNombre));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<dynamic> updatePfp(data, context) async {
    var toJson = {
      'usua_Id' : data.usuaId,
      'usua_PerfilImage' : data.usuaImgUrl
    };

    var body = json.encode(toJson);
    var url = Uri.parse(urlUpdatePfp);

    http.put(url,
        body: body,
        headers: {'Content-Type': 'application/json'}).then((response) {
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // resultado
        print(jsonResponse["message"].toString());
        ElegantNotification.success(
          // title:  Text("Exitoso"),
          description: Text(
            "La foto ha sido actualizada",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      } else {
        print(jsonResponse["message"].toString());
        print(data);
        ElegantNotification.error(
          description: Text(
            "Ha ocurrido un error",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    });
  }
}

// var data = {'usua_NombreUsuario': usuario, 'usua_Correo': usuario, 'usua_Contrasena': password}; //datos xd

//           var body = json.encode(data); //Json encriptado

//           var url = Uri.parse('http://www.agenciaversalles.somee.com/api/Usuario/Login'); //Url

//           http.put(url, body: body, headers: {'Content-Type': 'application/json'}).then((response) { //Brujeria
//           if (response.statusCode == 200) { // resultado
//              Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }else{
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SplashScreen()),
//             );
//           }
// });       //tqm, gracias por el carrito