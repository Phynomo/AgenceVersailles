import 'dart:math';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappui/components/rating,.dart';
import 'package:travelappui/models/usuarioModel.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';
import 'package:provider/provider.dart';
import 'package:travelappui/models/reservacionesModel.dart';
import 'dart:convert';
import 'package:travelappui/views/Login/login.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  int numberPackage = 0;

  UsuarioModel usuarioModel;

  removePackage() {
    setState(() {
      numberPackage--;
      numberPackage = max(numberPackage, 0);
    });
  }

  addPackage() {
    setState(() {
      numberPackage++;
      numberPackage = min(numberPackage, 5);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoPersona();
  }

  Future<void> infoPersona() async {
    String usuarioJson = await storage.read(key: 'usuario');
    if (usuarioJson != null) {
      Map<String, dynamic> usuarioData = jsonDecode(usuarioJson);
      usuarioModel = UsuarioModel.fromJson(usuarioData);
    }
  }

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    final arguments = ModalRoute.of(context).settings.arguments;
    final argMap = arguments as Map<String, dynamic>;
    final paqueteObject = argMap['paqueteObject'];

    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return FutureBuilder(
        future: infoPersona(),
        builder: (context, snapshot) {
          return Scaffold(
            floatingActionButton: Transform.translate(
                offset: Offset(0, 16),
                child: FloatingActionButton(
                  elevation: 0,
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: size.height * 0.7,
                    color: Colors.grey,
                    child: Image(
                      image: NetworkImage(paqueteObject.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(top: 26, left: 20, right: 20),
                      height: size.height * 0.54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(paqueteObject.placeTitle,
                              style: appTheme.textTheme.headline2),
                          SizedBox(height: 4),
                          Row(children: [
                            Icon(
                              Icons.location_pin,
                              size: 14,
                            ),
                            SizedBox(width: 12),
                            Text(
                              paqueteObject.locationShort,
                              style: appTheme.textTheme.caption,
                            )
                          ]),
                          SizedBox(height: 8),
                          Rating(
                              rating: paqueteObject.rating,
                              color: Colors.black),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              // IconButton(
                              //     icon: Icon(
                              //       Icons.remove,
                              //       color: appTheme.accentColor,
                              //     ),
                              //     splashColor: appTheme.accentColor,
                              //     onPressed: () {
                              //       removePackage();
                              //     }),
                              // Container(
                              //   padding: EdgeInsets.only(left: 8, right: 8),
                              //   child: Text(
                              //     numberPackage.toString(),
                              //     style: appTheme.textTheme.caption,
                              //   ),
                              // ),
                              // IconButton(
                              //     icon: Icon(Icons.add),
                              //     onPressed: () {
                              //       addPackage();
                              //     }),
                              Icon(
                                Icons.calendar_today,
                                color: appTheme.accentColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                paqueteObject.fechaSalida,
                                style: appTheme.textTheme.caption.merge(
                                    TextStyle(color: appTheme.accentColor)),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.people,
                                color: appTheme.accentColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                paqueteObject.personas + " Personas",
                                style: appTheme.textTheme.caption.merge(
                                    TextStyle(color: appTheme.accentColor)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Text(
                          //   "Detalles",
                          //   style: appTheme.textTheme.headline3
                          //       .merge(TextStyle(color: Colors.black)),
                          // ),
                          SizedBox(height: 12),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                "Disfruta de tu viaje con " +
                                    paqueteObject.agencia +
                                    " en el maravilloso " +
                                    paqueteObject.hotelNombre +
                                    ", saliendo desde el " +
                                    paqueteObject.aeropuerto +
                                    ", " +
                                    paqueteObject.ciudadSalida,
                                maxLines: 4,
                                overflow: TextOverflow.fade,
                                style: appTheme.textTheme.bodyText1,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "\$" +
                                          paqueteObject.rateperpackage
                                              .toString(),
                                      style: TextStyle(
                                          color: appTheme.accentColor,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "/Paquete",
                                      style: TextStyle(
                                          color: appTheme.accentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold))
                                ]),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      // padding: EdgeInsets.zero,
                                      primary: appTheme.accentColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 0,
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'PlayFair',
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () async {
                                    String usuarioJson =
                                        await storage.read(key: 'usuario');
                                    if (usuarioJson == null) {
                                      ElegantNotification.info(
                                        // title:  Text("Exitoso"),
                                        description: Text(
                                          "Antes debes iniciar sesión",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        toastDuration:
                                            const Duration(milliseconds: 5000),
                                        animationDuration:
                                            const Duration(milliseconds: 700),
                                      ).show(context);
                                      Navigator.pushNamed(context, "/login");
                                    } else {
                                      ReservacionModel reservacion =
                                          ReservacionModel(
                                              persId: int.parse(
                                                  usuarioModel.persId),
                                              paquId: paqueteObject.paquId,
                                              reseId: 0);
                                      homepagestate.insertReservacion(
                                          reservacion, context);
                                      reservacion = null;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Reservar",
                                      style: appTheme.textTheme.headline3,
                                    ),
                                  )),
                              SizedBox(height: 12),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
