import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Droplist extends StatefulWidget {
  const Droplist({Key key}) : super(key: key);

  @override
  State<Droplist> createState() => _DroplistState();
}

class _DroplistState extends State<Droplist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MyDropdownButton(),
      ),
    );
  }
}




class Hoteles {
  String hoteNombre;
  int hoteId;

  Hoteles({this.hoteNombre, this.hoteId});

  factory Hoteles.fromJson(Map<String, dynamic> json) {
    return Hoteles(
      hoteNombre: json['hote_Nombre'],
      hoteId: json['hote_Id'],
    );
  }
}

Future<List<Hoteles>> fetchHoteles() async {
  final response = await http.get(Uri.parse(
      'http://phynomo-001-site1.atempurl.com/api/Hotel/Listado'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var data = jsonResponse['data'];
    final List<dynamic> paquetesJson = data;
    return paquetesJson.map((json) => Hoteles.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los paquetes');
  }
}




class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

String _selectedValue = 'Seleccione un estado civil';
String _estadocivil="";

class _MyDropdownButtonState extends State<MyDropdownButton> {

List<Hoteles> _hoteles = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final hoteles = await fetchHoteles();
    setState(() {
      _hoteles = hoteles;
    });
  }



  List<Map<String, dynamic>> estadosCiviles = [
    {"id": 1, "nombre": "Soltero(a)"},
    {"id": 2, "nombre": "Casado(a)"},
    {"id": 3, "nombre": "Divorciado(a)"},
    {"id": 4, "nombre": "Viudo(a)"},
  ];
  void _showDropdown() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: _hoteles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  _hoteles[index].hoteNombre,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedValue = _hoteles[index].hoteNombre;
                    _estadocivil = _hoteles[index].hoteId.toString();
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 40.0,
            child: ElevatedButton(
              onPressed: _showDropdown,
              child: Text(_selectedValue),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 252, 252, 1),
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                      color: Color.fromRGBO(255, 252, 252, 1), width: 1),
                  // Puedes personalizar los otros lados de la misma manera
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
