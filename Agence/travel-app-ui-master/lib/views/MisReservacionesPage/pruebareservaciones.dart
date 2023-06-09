import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappui/components/travelplacedart.dart';
import 'package:travelappui/models/usuarioModel.dart';
import 'package:travelappui/views/HomePage/state/homepageScrollListner.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';
import 'package:provider/provider.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/components/appbar.dart';
import 'package:travelappui/components/featuredcard.dart';
import 'package:travelappui/theme.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Login/login.dart';

class Prueba extends StatefulWidget {
  const Prueba({Key key}) : super(key: key);

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  ScrollController _mainScrollController = ScrollController();
  final double _bottomBarHeight = 90;
  HomepageSrollListner _model;
  UsuarioModel usuarioModel;

  @override
  void initState() {
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
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
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
        future: infoPersona(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: HomeAppBarReservacion,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _mainScrollController,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(2),
                          child: StreamBuilder(
                              stream: homepagestate
                                  .getPaquetesXPersona(1)
                                  .asStream(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator());
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator());

                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    // gridDelegate:
                                    //     SliverGridDelegateWithFixedCrossAxisCount(
                                    //         mainAxisSpacing: 16,
                                    //         crossAxisSpacing: 16,
                                    //         crossAxisCount: 1),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/view", arguments: {
                                              "paqueteObject":
                                                  snapshot.data[index]
                                            });
                                          },
                                          child: FeaturedCard(
                                            placeModel: snapshot.data[index],
                                          ));
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _model,
                      builder: (context, child) {
                        return Positioned(
                            bottom: _model.bottom,
                            right: 22,
                            left: 22,
                            child: Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        color: Colors.black.withOpacity(0.4))
                                  ],
                                  borderRadius: BorderRadius.circular(45)),
                              height: 75,
                              alignment: Alignment.center,
                              child: Material(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.home_rounded,
                                            size: 36,
                                            color: kAppTheme.accentColor),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: Icon(Icons.calendar_today_rounded,
                                            size: 36,
                                            color: kAppTheme.accentColor
                                                .withOpacity(0.35)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/reservaciones");
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.search,
                                            size: 36,
                                            color: kAppTheme.accentColor
                                                .withOpacity(0.35)),
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/Todo");
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.person,
                                            size: 36,
                                            color: kAppTheme.accentColor
                                                .withOpacity(0.35)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/perfil");
                                        })
                                  ],
                                ),
                              ),
                            ));
                      })
                ],
              ),
            );
          }
        });
  }
}
