// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/components/appbar.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import 'package:travelappui/services/photos_service.dart';
import 'package:travelappui/views/Admin/admin.dart';
import 'package:travelappui/views/HomePage/homepagetodo.dart';
import 'package:travelappui/views/Paquetes/cargardatos/datos.dart';
import 'package:travelappui/views/Paquetes/models_ddl/modelsddl.dart';
// import 'package:travelappui/views/HomePage/homepagetodo.dart';

import '../HomePage/state/homepageScrollListner.dart';


class FormPaquetePage extends StatefulWidget {
  @override
  _FormPaquetePageState createState() => _FormPaquetePageState();
}


class _FormPaquetePageState extends State<FormPaquetePage> {
  List<Hoteles> _hoteles = [];
  List<Habitaciones> _habitaciones = [];
  List<Vuelos> _vuelos = [];
  List<Paises> _paises = [];
TextEditingController controllerNombrePaquete = TextEditingController();
TextEditingController controllerPrecio = TextEditingController();
TextEditingController controllerPersonas = TextEditingController();
int habitacionId = 0;
int vueloId = 0;
int hotelId = 0;
int paisId = 0;

final _formKey = GlobalKey<FormState>();
  void _loadAll(String id) async {
    try {
      _loadVuelos(id);
    await _loadHoteles(id);
    if (_hoteles.length > 0) {
      await _loadhabitaciones(_hoteles[0].hoteId.toString());
    } else {
      setState(() {
        _habitaciones.clear();
      });
      if (_habitaciones.length > 0) {
        setState(() {
          habitacionId = _habitaciones[0].habiId;
        });
      } else {
        setState(() {
          habitacionId = 0;
        });
      }
      if (_vuelos.length > 0) {
        setState(() {
          vueloId = _vuelos[0].vuelId;
        });
      } else {
        setState(() {
          vueloId = 0;
        });
      }
      if (_hoteles.length > 0) {
        setState(() {
          hotelId = _hoteles[0].hoteId;
        });
      } else {
        setState(() {
          hotelId = 0;
        });
      }
    }
    } catch (e) {
      setState(() {
          vueloId = 0;
          habitacionId = 0;
          hotelId = 0;
        });
    }
    
  }

  void _loadPaises() async {
    try {
      final paises = await fetchPaises();
    setState(() {
      _paises.clear();
      _paises = paises;
    });
    if (_paises.length > 0) {
        setState(() {
          paisId = 0;
          //paisId = _paises[0].paisId;
        });
      } else {
        setState(() {
          paisId = 0;
        });
      }
    } catch (e) {
       setState(() {
          paisId = 0;
        });
    }
    
  }

  void _loadVuelos(String id) async {
    try {
      final vuelos = await fetchVuelos(id);
    setState(() {
      _vuelos.clear();
      _vuelos = vuelos;
    });
    if (_vuelos.length > 0) {
      setState(() {
        vueloId = _vuelos[0].vuelId;
      });
    } else {
      setState(() {
        vueloId = 0;
      });
    }
    } catch (e) {
      setState(() {
        vueloId = 0;
      });
    }
  }

  void _loadHoteles(String id) async {
    try {
      final hoteles = await fetchHoteles(id);
    setState(() {
      _hoteles.clear();
      _hoteles = hoteles;
    });
    if (_hoteles.length > 0) {
        setState(() {
          hotelId = _hoteles[0].hoteId;
        });
      } else {
        setState(() {
          hotelId = 0;
        });
      }
    } catch (e) {
      setState(() {
          hotelId = 0;
        });
    }
    
  }

  void _loadhabitaciones(String id) async {
    
    try {
      final habitaciones = await fetchHabitaciones(id);
    setState(() {
      _habitaciones.clear();
      _habitaciones = habitaciones;
    });
    if (_habitaciones.length > 0) {
      setState(() {
        habitacionId = _habitaciones[0].habiId;
      });
    } else {
      setState(() {
        habitacionId = 0;
      });
    }
    } catch (e) {
      setState(() {
        habitacionId = 0;
      });
    }
  }

  ScrollController _mainScrollController = ScrollController();
  HomepageSrollListner _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPaises();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  File imageFile;
  // final _productController = TextEditingController();

  // pickAndUploadFile() async {
  //   bool loading = true;
  //   setState(() {});

  //   FilePickerResult result =
  //       await FilePicker.platform.pickFiles(type: FileType.image);

  //   if (result != null) {
  //     File file = File(result.files.single.path);
  //     await PhotoService().upload(file);
  //     loading = false;
  //     setState(() {});
  //   }
  // }
  bool seleccioneVuelo = false;
  bool seleccioneImagen = false;
  bool seleccioneHabitacion = false;
  bool seleccionePais = false;
  bool seleccioneHotel = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(63, 63, 156, 1),
          title: Text(
            "Ingresar paquetes",
            style: TextStyle(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            // SizedBox(height: 20.0,),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      myController: controllerNombrePaquete,
                      fieldName: 'Nombre del paquete',
                      myIcon: Icons.text_fields_rounded,
                      prefixColor: kAccentColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MyTextField(
                      myController: controllerPersonas,
                      fieldName: 'Cantidad de personas',
                      myIcon: Icons.people_alt,
                      prefixColor: kAccentColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MyTextField(
                      myController: controllerPrecio,
                      fieldName: 'Precio',
                      myIcon: Icons.monetization_on_outlined,
                      prefixColor: kAccentColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          _loadAll(val.toString());
                          setState(() {
                            paisId = val;
                          });
                          setState(() {
                            seleccioneHabitacion = false;
                            seleccioneVuelo = false;
                            seleccionePais = false;
                            seleccioneHotel = false;
                            });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: kAccentColor.withOpacity(0.7),
                        ),
                        //dropdownColor: Colors.deepPurple.shade100,
                        decoration: InputDecoration(
                            labelText: "Seleccione un pais",
                            prefixIcon: Icon(
                              Icons.map_sharp,
                              color: kAccentColor.withOpacity(0.7),
                            ),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                    if (_paises.length == 0 && seleccionePais == false)
                      Text(
                        'sin paises disponibles',
                        style: TextStyle(color: Colors.red.shade800),
                      ), 
                      if (seleccionePais == true)
                      Text(
                        'Seleccione un pais',
                        style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: DropdownButtonFormField(
                        //value: null,
                        value: _vuelos.isNotEmpty ? _vuelos[0].vuelId : null,
                        items: _vuelos
                            .map((e) => DropdownMenuItem(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.70, // ajusta el ancho según tus necesidades
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
                          setState(() {
                            vueloId = val;
                          });
                          setState(() {
                            seleccioneHabitacion = false;
                            seleccioneVuelo = false;
                            seleccionePais = false;
                            seleccioneHotel = false;
                            });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: kAccentColor.withOpacity(0.7),
                        ),
                        decoration: InputDecoration(
                            labelText: "Seleccione un vuelos",
                            prefixIcon: Icon(
                              Icons.airplanemode_active_rounded,
                              color: kAccentColor.withOpacity(0.7),
                            ),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                    if (_vuelos.length == 0 && seleccioneVuelo == false)
                      Text(
                        'sin vuelos disponibles',
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                    if (seleccioneVuelo == true)
                      Text(
                        'Seleccione un vuelo',
                        style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: DropdownButtonFormField(
                        //value: null,
                        value: _hoteles.isNotEmpty ? _hoteles[0].hoteId : null,
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
                          setState(() {
                            hotelId = val;
                          });
                          setState(() {
                            seleccioneHabitacion = false;
                            seleccioneVuelo = false;
                            seleccionePais = false;
                            seleccioneHotel = false;
                            });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: kAccentColor.withOpacity(0.7),
                        ),
                        //dropdownColor: Colors.deepPurple.shade100,
                        decoration: InputDecoration(
                            labelText: "Seleccione un hotel",
                            prefixIcon: Icon(
                              Icons.maps_home_work,
                              color: kAccentColor.withOpacity(0.7),
                            ),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                    if (_hoteles.length == 0 && seleccioneHotel == false)
                      Text(
                        'sin hoteles disponibles',
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                       if (seleccioneHotel == true)
                      Text(
                        'Seleccione un hotel',
                        style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: DropdownButtonFormField(
                        //value: null,
                        value: _habitaciones.isNotEmpty
                            ? _habitaciones[0].habiId
                            : null,
                        items: _habitaciones
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e.habiNombre,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  value: e.habiId,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            habitacionId = val;
                          });
                          setState(() {
                            seleccioneHabitacion = false;
                            seleccioneVuelo = false;
                            seleccionePais = false;
                            seleccioneHotel = false;
                            });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: kAccentColor.withOpacity(0.7),
                        ),
                        //dropdownColor: Colors.deepPurple.shade100,
                        decoration: InputDecoration(
                            labelText: "Seleccione una habitacion",
                            prefixIcon: Icon(
                              Icons.house_sharp,
                              color: kAccentColor.withOpacity(0.7),
                            ),
                            border: UnderlineInputBorder()),
                      ),
                    ),
                    if (_habitaciones.length == 0 && seleccioneHabitacion == false)
                      Text(
                        'sin habitaciones disponibles',
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                      if (seleccioneHabitacion == true)
                      Text(
                        'Seleccione una habitacion',
                        style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
                      ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Subir foto",
                      textAlign: TextAlign.left,
                    ),
                    Column(
                      children: [
                        if (imageFile != null)
                          Container(
                            width: 640,
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 228, 228, 228),
                                image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    width: 2,
                                    color: kAccentColor.withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(12.0)),
                          )
                        else
                          Container(
                              width: 640,
                              height: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 228, 228, 228),
                                  border: Border.all(
                                      width: 2,
                                      color: kAccentColor.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 80.0,
                                    color: Colors.white,
                                  ),
                                  // Text(
                                  //    'Ingrese una imagen',
                                  //    style: TextStyle(fontSize: 20, color: Colors.black),
                                  //  ),
                                ],
                              )),
                               if (seleccioneImagen == true)
                      Text(
                        'Seleccione una imagen',
                        style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
                      ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(200, 38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              onPressed: () {
                                getImage(source: ImageSource.gallery);
                              },
                              child: Text(
                                "Seleccionar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(200, 38),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              onPressed: () {
                                getImage(source: ImageSource.camera);
                              },
                              child: Text(
                                "Cámara",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                    MyButton(
                      onPress: () {
                        String urlimage = "";
                        setState(() {
                            seleccioneHabitacion = false;
                            seleccioneVuelo = false;
                            seleccionePais = false;
                            seleccioneHotel = false;
                            });
                        if (_formKey.currentState.validate() && vueloId != 0 && habitacionId != 0 && imageFile != null && isNumeric(controllerPrecio.text) && isNumeric(controllerPersonas.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Procesando info')));

                              Future<void> enviarJson() async {
                              var data = {
                                'paqu_Nombre': controllerNombrePaquete.text,
                                'paqu_Imagen': urlimage,
                                'vuel_Id': vueloId,
                                'habi_Id': habitacionId,
                                'paqu_Personas': controllerPersonas.text,
                                "paqu_Precio": controllerPrecio.text,
                              };

                              var jsonBody = jsonEncode(data);
                              final url = Uri.parse(
                                  'http://www.agenciaversalles.somee.com/api/Paquete/Insertar');
                              final response = await http.post(
                                url,
                                body: jsonBody,
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                              );
                              if (response.statusCode == 200) {
                                var jsonResponse = jsonDecode(response.body);
                                var message = jsonResponse['message'];
                                if (message ==
                                    "El registro ha sido insertado con éxito") {
                                      
                                  ElegantNotification.success(
                                    // title:  Text("Exitoso"),
                                    description: Text(
                                      "Paquete creado correctamente",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    toastDuration:
                                        const Duration(milliseconds: 5000),
                                    animationDuration:
                                        const Duration(milliseconds: 700),
                                  ).show(context);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()),
                                  );
                                } else {
                                  ElegantNotification.error(
                                    // title:  Text("Exitoso"),
                                    description: Text(
                                      "Solicitud denegada",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    toastDuration:
                                        const Duration(milliseconds: 5000),
                                    animationDuration:
                                        const Duration(milliseconds: 700),
                                  ).show(context);
                                }
                              } else {
                               ElegantNotification.error(
                                    // title:  Text("Exitoso"),
                                    description: Text(
                                      "Conexion incorrecta",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    toastDuration:
                                        const Duration(milliseconds: 5000),
                                    animationDuration:
                                        const Duration(milliseconds: 700),
                                  ).show(context);

                              }
                            }


                              Future<void> terminarRegistro() async {
                                var urlobtenida = await uploadImage(imageFile);
                                setState(() {
                                  urlimage = urlobtenida.toString();
                                });
                              await enviarJson();
                              }

                            terminarRegistro();

                        }else{
                         
                          if(!isNumeric(controllerPrecio.text) && !controllerPrecio.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('El precio solo debe contener digitos')));
                          }

                          if(!isNumeric(controllerPersonas.text) && !controllerPersonas.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Ingresa bien la cantidad de personas')));
                          }
                          if(vueloId == 0){
                            setState(() {
                            seleccioneVuelo = true;
                            });
                          }
                          if(habitacionId == 0){
                            setState(() {
                            seleccioneHabitacion = true;
                            });
                          }
                          if(hotelId == 0){
                            setState(() {
                            seleccioneHotel = true;
                            });
                          }
                          if(paisId == 0){
                            setState(() {
                            seleccionePais = true;
                            });
                          }
                          if(imageFile == null){
                            setState(() {
                            seleccioneImagen = true;
                            });
                          }

                        }

                        //uploadImage(imageFile);
                      },
                    ),
                  ],
                )),
          ]),
        ));
  }

  void getImage({ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    this.fieldName,
    this.myController,
    this.myIcon,
    this.prefixColor,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Complete el campo';
          } else
            return null;
        },
        controller: myController,
        style:
            TextStyle(color: Colors.black), // add this line to set text color
        decoration: InputDecoration(
            labelText: fieldName,
            prefixIcon: Icon(
              myIcon,
              color: prefixColor,
            ),
            // border: OutlineInputBorder(),
            // focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.deepPurple.shade300)),
            labelStyle: TextStyle(color: Colors.black54)),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key key,
    // this.paqueteName
    this.onPress,
  }) : super(key: key);

  // final String paqueteName;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
          child: Text(
            "Enviar".toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


bool isNumeric(String str) {
  return RegExp(r'^[0-9]+$').hasMatch(str);
}