import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepagecontinente.dart';

class HomePageAmerica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePageContinent('América'),
    );
  }

  Widget _buildHomePageContinent(String continentName) {
    return HomePageContinent(continenteNombre: continentName);
  }
}