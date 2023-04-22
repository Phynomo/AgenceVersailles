import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/homepagecontinente.dart';

class HomePageAsia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePageContinent('Asia'),
    );
  }

  Widget _buildHomePageContinent(String continentName) {
    return HomePageContinent(continenteNombre: continentName);
  }
}