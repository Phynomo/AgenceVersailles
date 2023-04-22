import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepagecontinente.dart';

class HomePageEuropa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePageContinent('Europa'),
    );
  }

  Widget _buildHomePageContinent(String continentName) {
    return HomePageContinent(continenteNombre: continentName);
  }
}