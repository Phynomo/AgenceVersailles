
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/Paquetes/models_ddl/modelsddl.dart';

Future<List<Hoteles>> fetchHoteles(String id) async {
  final response = await http.get(Uri.parse(
      'http://www.agenciaversalles.somee.com/api/Hotel/ListadoPorPais?id=$id'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Hoteles.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los Hoteles');
  }
}



Future<List<Habitaciones>> fetchHabitaciones(String id) async {
  final response = await http.get(Uri.parse(
      'http://www.agenciaversalles.somee.com/api/Habitacion/ListadoXHotel?hotel=$id'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Habitaciones.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener las habitaciones');
  }
}



Future<List<Paises>> fetchPaises() async {
  final response = await http
      .get(Uri.parse('http://www.agenciaversalles.somee.com/api/Pais/Listado'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Paises.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los paises');
  }
}



Future<List<Vuelos>> fetchVuelos(String id) async {
  final response = await http.get(Uri.parse(
      'http://www.agenciaversalles.somee.com/api/Vuelo/ListadoPorPais?id_Pais=$id'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Vuelos.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los vuelos');
  }
}

