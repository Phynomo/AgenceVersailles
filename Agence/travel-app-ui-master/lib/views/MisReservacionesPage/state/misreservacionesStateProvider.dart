import 'package:flutter/material.dart';
import 'package:travelappui/models/placesModel.dart';
import 'package:travelappui/utils/restAPI.dart';

class HomePageStateProvider extends ChangeNotifier
{

  bool showBottomDrawer = true;
  RESTAPI api = RESTAPI();

  void setShowBottomDrawer(bool value){
    this.showBottomDrawer = value;
    print("\n Bottom Scroll State : "+this.showBottomDrawer.toString());
    notifyListeners();
  }

  List<String> kTopListLink = [
    'Popular',
    'Destacado',
    'Más económico',    
    'Europa',
    'Asia',
    'América'
  ];

  Future<List<dynamic>> getFeaturedPlaces() async {
    return await api.getFeaturedPlaces();    
  }

  Future<List<PlaceModel>> getAllPlaces(String query) async {
    return await api.getAllPlaces(query);    
  }

  Future<List<PlaceModel>> getRecomendedPlaces() async {
    return await api.getRecommendedPlaces();    
  }

}