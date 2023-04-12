import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "http://www.agenciaversalles.somee.com/api/Usuario/Listado";

Future<dynamic> _getListado() async {
  final respuesta = await http.get(Uri.parse(url));
  if (respuesta.statusCode == 200) {
    final json = respuesta.body;
    return jsonDecode(json);
  } else {
    print("Error en la respuesta");
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de categorías"),
      ),
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, item) {
          if (item.hasData) {
            return ListView(
              children: listado(item.data),
            );
          } else if(item.hasError)
          {
            return Text(item.error.toString());
          }
          else {
            return Text(item.data);
          }
        },
      ),
    );
  }
}

List<Widget> listado(List<dynamic> info) {
  List<Widget> lista = [];
  info.forEach((element) {
    lista.add(Text(element["usua_NombreUsuario"]));
  });
  return lista;
}
