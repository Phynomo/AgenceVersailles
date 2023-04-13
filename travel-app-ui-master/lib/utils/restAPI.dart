import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "http://www.agenciaversalles.somee.com/api/Paquete/Listado";

class RESTAPI {
  List<PlaceModel> dummyFeatured(List<dynamic> info) {
    List<PlaceModel> lista = [];
    info.forEach((element) {
      lista.add(PlaceModel(
          placeTitle: element["paqu_Nombre"],
          description:
            "I'm mocking y'all",
          duration: 1,
          imgUrl: element["paqu_Imagen"],
          locationShort: "Honshu, Japan",
          rateperpackage: element["paqu_Precio"],
          rating: 4.5));
    });
    return lista;
  }

  List<PlaceModel> dummyAllPlaces = [
    PlaceModel(
        placeTitle: "Northern Moutains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic2.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 400.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Himalayas Mt",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 6,
        imgUrl: "assets/image/pic3.jpg",
        locationShort: "Ladakh, India",
        rateperpackage: 350.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Mount Fugi",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 7,
        imgUrl: "assets/image/pic1.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 250.0,
        rating: 3.8),
    PlaceModel(
        placeTitle: "Mountains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic4.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 300.0,
        rating: 4.0),
    PlaceModel(
        placeTitle: "Northern Moutains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic2.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 400.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Himalayas Mt",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 6,
        imgUrl: "assets/image/pic3.jpg",
        locationShort: "Ladakh, India",
        rateperpackage: 350.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Mount Fugi",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 7,
        imgUrl: "assets/image/pic1.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 250.0,
        rating: 3.8),
    PlaceModel(
        placeTitle: "Mountains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic4.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 300.0,
        rating: 4.0),
    PlaceModel(
        placeTitle: "Northern Moutains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic2.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 400.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Himalayas Mt",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 6,
        imgUrl: "assets/image/pic3.jpg",
        locationShort: "Ladakh, India",
        rateperpackage: 350.0,
        rating: 4.5),
    PlaceModel(
        placeTitle: "Mount Fugi",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 7,
        imgUrl: "assets/image/pic1.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 250.0,
        rating: 3.8),
    PlaceModel(
        placeTitle: "Mountains",
        description:
            "Enjoy your winter vacation with warmth and amazing sightseeing on the mountains. Enjoy the best experience with us!",
        duration: 5,
        imgUrl: "assets/image/pic4.jpg",
        locationShort: "Honshu, Japan",
        rateperpackage: 300.0,
        rating: 4.0)
  ];



  Future<List<PlaceModel>> getFeaturedPlaces() async {
    final respuesta = await http.get(Uri.parse(url));
    if (respuesta.statusCode == 200) {
      final json = respuesta.body;
      final jsonMap = jsonDecode(json);
      return dummyFeatured(jsonMap["data"]);
    } else {
      print("Error en la respuesta");
      throw Exception('Failed to load listado');
    }
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    return dummyAllPlaces;
  }
}
