import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

String urlAll = "http://www.agenciaversalles.somee.com/api/Paquete/Listado";
String urlFeatured =
    "http://www.agenciaversalles.somee.com/api/Paquete/Listado5Caros";
String urlRecommended =
    "http://www.agenciaversalles.somee.com/api/Paquete/Listado10Baratos";
// String urlFind = "https://localhost:44313/api/Paquete/Find?id=";

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
          imgUrl: "assets/image/ImagenesPaquetes/" + element["paqu_Imagen"],
          locationShort: element["ciud_Nombre"] + ", " + element["pais_Nombre"],
          rateperpackage: element["paqu_Precio"],
          fechaSalida: DateFormat('dd/MM/yyyy').format(date),
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

  Future<List<PlaceModel>> getAllPlaces() async {
    final respuesta = await http.get(Uri.parse(urlAll));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyPlaces(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  // Future<dynamic> insertReservacion() async{
  //   final respuesta = await http.post()
  // }

  // Future<List<PlaceModel>> findPlace() async {
  //   final respuesta = await http.post(Uri.parse(urlFind + '2'));
  //   if (respuesta.statusCode == 200) {
  //     final json = respuesta.body;
  //     final jsonMap = jsonDecode(json);
  //     return dummyPlaces(jsonMap["data"]);
  //   } else {
  //     print("Error en la respuesta");
  //     throw Exception('Failed to load listado');
  //   }
  // }
}

// var data = {'usua_NombreUsuario': usuario, 'usua_Correo': usuario, 'usua_Contrasena': password}; //datos xd

//           var body = json.encode(data); //Json encriptado

//           var url = Uri.parse('https://localhost:44313/api/Usuario/Login'); //Url

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