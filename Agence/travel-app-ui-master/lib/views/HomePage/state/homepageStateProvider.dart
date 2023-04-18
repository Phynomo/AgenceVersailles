import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
import 'package:travelappui/utils/restAPI.dart';

class HomePageStateProvider extends ChangeNotifier {
  bool showBottomDrawer = true;
  RESTAPI api = RESTAPI();

  void setShowBottomDrawer(bool value) {
    this.showBottomDrawer = value;
    print("\n Bottom Scroll State : " + this.showBottomDrawer.toString());
    notifyListeners();
  }

  List<String> kTopListLink = [
    'Popular',
    'Más económico',
    'Europa',
    'Asia',
    'América'
  ];

  Future<List<dynamic>> getFeaturedPlaces() async {
    return await api.getFeaturedPlaces();
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    return await api.getAllPlaces();
  }

  Future<List<PlaceModel>> getRecomendedPlaces() async {
    return await api.getRecommendedPlaces();
  }

  Future<dynamic> insertReservacion(data, context) async {
    return await api.insertReservacion(data, context);
  }

  Future<dynamic> eliminarReservacion(data, context) async {
    return await api.eliminarReservacion(data, context);
  }

  Future<List<PlaceModel>> getPaquetesXPersona(persId) async {
    return await api.getPaquetesXPersona(persId);
  }

  Future<void> GetTopList() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});

    kTopListLink.add("India");

    notifyListeners();
  }
}
