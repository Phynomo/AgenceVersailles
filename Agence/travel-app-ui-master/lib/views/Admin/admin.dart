import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:travelappui/constants/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Paquete {
  String paisNombre;
  int cantidadPaquetes;

  Paquete({this.paisNombre, this.cantidadPaquetes});

  factory Paquete.fromJson(Map<String, dynamic> json) {
    return Paquete(
      paisNombre: json['pais_Nombre'],
      cantidadPaquetes: json['cantidadPaquetes'],
    );
  }
}

Future<List<Paquete>> fetchPaquetes() async {
  final response = await http.get(Uri.parse(
      'http://www.agenciaversalles.somee.com/api/Paquete/PaquetesPorPais'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Paquete.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los paquetes');
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Paquete> _paquetes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final paquetes = await fetchPaquetes();
    setState(() {
      _paquetes = paquetes;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(63, 63, 156, 1),
                Color.fromRGBO(99, 70, 170, 1),
              ])),
              width: double.infinity,
              height: size.height * 0.4,
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: double.infinity,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 220,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    //height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          )
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Top 5 paises con mas paquetes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SfCircularChart(
                          series: <CircularSeries<Paquete, String>>[
                            PieSeries<Paquete, String>(
                              dataSource: _paquetes,
                              xValueMapper: (Paquete data, _) =>
                                  data.paisNombre,
                              yValueMapper: (Paquete data, _) =>
                                  data.cantidadPaquetes,
                              explode: true,
                              explodeIndex: 0,
                              explodeOffset: '10%',
                              dataLabelMapper: (Paquete data, _) =>
                                  '${data.paisNombre}: ${data.cantidadPaquetes}',
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //ElevatedButton(onPressed: null, child: Text("Pollo"),)
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          disabledColor: Colors.grey,
                          color: Colors.deepPurple.shade700,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            child: Text(
                              "Agregar un paquete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/insertPaquete");
                          },
                        ),

                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             Positioned(
            left: 0,
            //right: 0,
            top: 0,
            child: SafeArea(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FloatingActionButton(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                          foregroundColor: Colors.purple.shade900,
                          elevation: 0,
                          child: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pushNamed(context, "/Popular"),
                        ),
               ),
             ),
          ),
          ],
        ),
      ),
    );
  }
}
