import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:travelappui/constants/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

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
      'http://phynomo-001-site1.atempurl.com/api/Paquete/PaquetesPorPais'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Paquete.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los paquetes');
  }
}

class ConocenosPage extends StatefulWidget {
  const ConocenosPage({Key key}) : super(key: key);

  @override
  State<ConocenosPage> createState() => _ConocenosPageState();
}

class _ConocenosPageState extends State<ConocenosPage> {
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
     int _current = 0;
  final CarouselController _controller = CarouselController();
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Conócenos"),
      //   backgroundColor: Color.fromRGBO(63, 63, 156, 1),
      // ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
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
              height: size.height * 0.5,
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: FloatingActionButton(
                        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                        foregroundColor: Colors.purple.shade900,
                        elevation: 0,
                        child: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
             ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: double.infinity,
                child: Image(
                  height: 150.0,
                  image: AssetImage('assets/image/LogoBlanco.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 220,
                  ),
                  CarouselSlider(
                    
            carouselController: _controller,
        options: CarouselOptions(
          
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 1.05,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
                    items: [
                      Container(
                        margin: EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Misión",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Proporcionamos experiencias de viaje inolvidables, con un servicio personalizado, confiable y de alta calidad, mientras fomentamos relaciones duraderas con nuestros clientes y nos comprometemos con la sostenibilidad y la responsabilidad social.",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Visión",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Convertirnos en la agencia líder del mercado, reconocidos por nuestro servicio excepcional y experiencias únicas, siendo innovadores con tecnología avanzada y comprometidos con la sostenibilidad y la responsabilidad social.",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Valores",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Excelencia, Integridad, Personalización, Innovación y Sostenibilidad. Nos comprometemos a reflejar estos valores en todo lo que hacemos para ofrecer un servicio excepcional y diferenciado en la industria de viajes.",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
