import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travelappui/views/Paquetes/models_ddl/modelsddl.dart';

class Droplist extends StatefulWidget {
  const Droplist({Key key}) : super(key: key);

  @override
  State<Droplist> createState() => _DroplistState();
}

class _DroplistState extends State<Droplist> {
  List<Hoteles> _hoteles = [];
  List<Habitaciones> _habitaciones = [];
  List<Vuelos> _vuelos = [];
  List<Paises> _paises = [];

  @override
  void initState() {
    super.initState();
    _loadPaises();
  }

  void _loadAll() async {
    final paises = await fetchPaises();
    setState(() {
      _paises = paises;
    });
    final vuelos = await fetchVuelos(_paises[0].paisId.toString());
    final hoteles = await fetchHoteles(_paises[0].paisId.toString());
    setState(() {
      _vuelos = vuelos;
      _hoteles = hoteles;
    });
    final habitaciones = await fetchHabitaciones(_hoteles[0].hoteId.toString());
    setState(() {
      _habitaciones = habitaciones;
    });
  }

  void _loadPaises() async {
    final paises = await fetchPaises();
    setState(() {
    _paises.clear();
      _paises = paises;
    });
  }

  void _loadVuelos(String id) async {
    final vuelos = await fetchVuelos(id);
    setState(() {
    _vuelos.clear();
      _vuelos = vuelos;
    });
  }

  void _loadHoteles(String id) async {
    final hoteles = await fetchHoteles(id);
    setState(() {
    _hoteles.clear();
      _hoteles = hoteles;
    });
  }

  void _loadhabitaciones(String id) async {
    final habitaciones = await fetchHabitaciones(id);
    setState(() {
    _habitaciones.clear();
      _habitaciones = habitaciones;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 50.0,
        ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: DropdownButtonFormField(
            value: null,
            //value: _paises.isNotEmpty ? _paises[0].paisId : null,
            items: _paises
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.paisNombre,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.paisId,
                    ))
                .toList(),
            onChanged: (val) {
              _loadVuelos(val.toString());
              _loadHoteles(val.toString());
              _habitaciones.clear();
            },
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.deepPurple,
            ),
            //dropdownColor: Colors.deepPurple.shade100,
            decoration: InputDecoration(
                labelText: "Seleccione un pais",
                prefixIcon: Icon(
                  Icons.map_sharp,
                  color: Colors.deepPurple,
                ),
                border: UnderlineInputBorder()),
          ),
        ),
        if (_paises.length == 0)
              Text(
                  'sin paises disponibles',
                  style: TextStyle(color: Colors.red),
                ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: DropdownButtonFormField(
            value: null,
            //value: _vuelos.isNotEmpty ? _vuelos[0].vuelId : null,
            items: _vuelos
                .map((e) => DropdownMenuItem(
                      child: SizedBox(
                        width:  MediaQuery.of(context).size.width * 0.80, // ajusta el ancho según tus necesidades
                        child: Text(
                          e.vuelInfo,
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      value: e.vuelId,
                    ))
                .toList(),
            onChanged: (val) {
            },
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.deepPurple,
            ),
            decoration: 
            InputDecoration(
                labelText: "Seleccione un vuelos",
                prefixIcon: Icon(
                  Icons.airplanemode_active_rounded,
                  color: Colors.deepPurple,
                ),
                border: UnderlineInputBorder()),
          ),
        ),
         if (_vuelos.length == 0)
              Text(
                  'sin vuelos disponibles',
                  style: TextStyle(color: Colors.red),
                ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: DropdownButtonFormField(
            value: null,
            //value: _hoteles.isNotEmpty ? _hoteles[0].hoteId : null,
            items: _hoteles
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.hoteNombre,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: e.hoteId,
                    ))
                .toList(),
            onChanged: (val) {
              _loadhabitaciones(val.toString());
            },
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.deepPurple,
            ),
            //dropdownColor: Colors.deepPurple.shade100,
            decoration: InputDecoration(
                labelText: "Seleccione un hotel",
                prefixIcon: Icon(
                  Icons.maps_home_work,
                  color: Colors.deepPurple,
                ),
                border: UnderlineInputBorder()),
          ),
        ),
        if (_hoteles.length == 0)
              Text(
                  'sin hoteles disponibles',
                  style: TextStyle(color: Colors.red),
                ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: DropdownButtonFormField(
            value: null,
            //value: _habitaciones.isNotEmpty ? _habitaciones[0].habiId : null,
            items: _habitaciones
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.habiNombre,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: e.habiId,
                    ))
                .toList(),
            onChanged: (val) {},
            icon: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.deepPurple,
            ),
            //dropdownColor: Colors.deepPurple.shade100,
            decoration: InputDecoration(
                labelText: "Seleccione una habitacion",
                prefixIcon: Icon(
                  Icons.house_sharp,
                  color: Colors.deepPurple,
                ),
                border: UnderlineInputBorder()),
          ),
        ),
        if (_habitaciones.length == 0)
              Text(
                  'sin habitaciones disponibles',
                  style: TextStyle(color: Colors.red),
                ),
      ]),
    );
  }
}



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


  //Future<List<Hoteles>> _loadHoteles(String id) async {
  //  var hoteles = await fetchHoteles(id);
  //  return hoteles.toList();
  //}
