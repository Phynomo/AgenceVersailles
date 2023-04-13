import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url = "http://www.agenciaversalles.somee.com/api/Paquete/Listado";
String urlTop5Caros =
    "http://www.agenciaversalles.somee.com/api/Usuario/Listado";
String urlTop10Baratos =
    "http://www.agenciaversalles.somee.com/api/Usuario/Listado";

Future<dynamic> _getListado() async {
  final respuesta = await http.get(Uri.parse(url));
  if (respuesta.statusCode == 200) {
    final json = respuesta.body;
    final jsonMap = jsonDecode(json);
    return jsonMap["data"];
  } else {
    print("Error en la respuesta");
    throw Exception('Failed to load listado');
  }
}

Future<dynamic> _getListadoBaratos() async {
  final respuesta = await http.get(Uri.parse(urlTop10Baratos));
  if (respuesta.statusCode == 200) {
    final json = respuesta.body;
    final jsonMap = jsonDecode(json);
    return jsonMap["data"];
  } else {
    print("Error en la respuesta");
    throw Exception('Failed to load listado');
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
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paquetes"),
        backgroundColor: const Color.fromRGBO(255, 211, 0, 1),
      ),
      body: FutureBuilder<dynamic>(
        future: _getListado(),
        builder: (context, item) {
          if (item.hasData) {
            return Container(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                    crossAxisCount: 2, children: listado(item.data)));
          } else if (item.hasError) {
            return Text(item.data.toString());
          } else {
            return Text(item.data);
          }
        },
      ),
    );
  }
}

// Container(
//       constraints: const BoxConstraints(
//       minHeight: 50.0, // Establece una altura mínima de 200.0
//       ),
//       decoration: BoxDecoration(
//       image: DecorationImage(
//         image: NetworkImage(element["paqu_Imagen"]), // Ruta de la imagen de fondo
//         fit: BoxFit.cover,
//       ),
//     ),
//     child: Text(element["usua_NombreUsuario"]),
//     )

List<Widget> listado(List<dynamic> info) {
  List<Widget> lista = [];
  info.forEach((element) {
    lista.add(Card(
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                  image: NetworkImage(
                      element["paqu_Imagen"])),
              Text(
                element["paqu_Nombre"],
                style: const TextStyle(fontSize: 17.0),
              ),
            ],
          ),
        )));
    // lista.add(Text(element["usua_Correo"]));
  });
  return lista;
}



// body: Container(
//         height: size.height,
//         width: size.width,
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               controller: _mainScrollController,
//               child: Column(
//                 children: [
//                   Container(
//                     width: size.width,
//                     height: size.height * 0.33,
//                     child: FutureBuilder<dynamic>(
//                       future: _getListado(),
//                       builder: (context, item) {
//                         if (item.hasData) {
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             itemCount: item.data.length,
//                             itemBuilder: (context, index){
//                               return GestureDetector(
//                                 onTap: (){},
//                               );
//                             }
//                           );
//                         } else if(item.hasError)
//                         {
//                           return Text(item.data.toString());
//                         }
//                         else {
//                           return Container(
//                                 alignment: Alignment.center,
//                                 width: 50,
//                                 height: 50,
//                                 child: const CircularProgressIndicator());
//                         }
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       )



// class PlaceModel{

//   String paqu_Nombre;
//   String paqu_Imagen;
//   double paqu_Precio;

//   PlaceModel({required this.paqu_Nombre,required this.paqu_Imagen,required this.paqu_Precio});

// }
