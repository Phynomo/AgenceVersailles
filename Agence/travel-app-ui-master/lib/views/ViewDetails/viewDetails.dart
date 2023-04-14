import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travelappui/components/rating,.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';
import 'package:provider/provider.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  int numberPackage = 0;

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
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments;
    final argMap = arguments as Map<String, dynamic>;
    final paqueteObject = argMap['paqueteObject'];
    if(arguments == null){
      Navigator.pushNamed(context, "/home");
    }

    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.menu),
        onPressed: () {},
      ),
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
                image: AssetImage(paqueteObject.imgUrl),
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
                    Text(paqueteObject.placeTitle, style: appTheme.textTheme.headline2),
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
                    Rating(rating: 4.5, color: Colors.black),
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
                          style: appTheme.textTheme.caption
                              .merge(TextStyle(color: appTheme.accentColor)),
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
                          style: appTheme.textTheme.caption
                              .merge(TextStyle(color: appTheme.accentColor)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Detalles",
                      style: appTheme.textTheme.headline3
                          .merge(TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      paqueteObject.description,
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                      style: appTheme.textTheme.bodyText1,
                    ),
                    SizedBox(height: size.height*0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "\$" + paqueteObject.rateperpackage.toString(),
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
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: appTheme.accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'PlayFair',
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Reservar",
                                style: appTheme.textTheme.headline3,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}