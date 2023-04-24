import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travelappui/components/appbar.dart';
import 'package:travelappui/components/featuredcard.dart';
import 'package:travelappui/components/travelplacedart.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/theme.dart';
import 'package:travelappui/views/HomePage/components/featurelist.dart';
import 'package:travelappui/views/HomePage/state/homepageScrollListner.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';
import 'package:http/http.dart' as http;

import '../Login/login.dart';

class HomePageContinent extends StatefulWidget {
  final String continenteNombre;

  HomePageContinent({this.continenteNombre});

  @override
  _HomePageContinentState createState() => _HomePageContinentState();
}

class _HomePageContinentState extends State<HomePageContinent> {
  ScrollController _mainScrollController = ScrollController();

  final double _bottomBarHeight = 90;
  HomepageSrollListner _model;

  @override
  void initState() {
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    Size size = MediaQuery.of(context).size;
    print(widget.continenteNombre);
    return Scaffold(  
      backgroundColor: kPrimaryColor,
      appBar: HomeAppBar,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _mainScrollController,
              child: Column(
                children: [
                  TopFeaturedList(nombrePag: widget.continenteNombre),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: StreamBuilder(
                        stream: homepagestate.getPaquetesXContinete(widget.continenteNombre).asStream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator());
                          if (snapshot.connectionState == ConnectionState.waiting)
                            return Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator());

                          return GridView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/view", arguments: {"paqueteObject": snapshot.data[index]});
                                    },
                                    child: TravelCard(snapshot.data[index]));
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.home_rounded,
                                      size: 36, color: kAppTheme.accentColor),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_rounded,
                                      size: 36,
                                      color: kAppTheme.accentColor
                                          .withOpacity(0.35)),
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
                                      Navigator.pushNamed(
                                          context, "/reservaciones");
                                    }
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
                                    Navigator.pushNamed(context, "/perfil");
                                    }
                                  })
                            ],
                          ),
                        ),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
