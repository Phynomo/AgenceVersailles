import 'package:flutter/material.dart';
import 'package:travelappui/views/HomePage/state/homepageScrollListner.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';
import 'package:provider/provider.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/components/appbar.dart';
import 'package:travelappui/components/featuredcard.dart';
import 'package:travelappui/theme.dart';

class MisReservacionesPage extends StatefulWidget {
  const MisReservacionesPage({Key key}) : super(key: key);

  @override
  State<MisReservacionesPage> createState() => _MisReservacionesPageState();
}

class _MisReservacionesPageState extends State<MisReservacionesPage> {
  ScrollController _mainScrollController = ScrollController();

  final double _bottomBarHeight = 90;
  HomepageSrollListner _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    Size size = MediaQuery.of(context).size;

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Text("Mis reservaciones",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: size.height,
                    child: StreamBuilder(
                      stream: homepagestate.getPaquetesXPersona(1).asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData) {
                          return Stack(
                            children: [
                              ListView(),
                              Center(
                                child: Text(
                                  "Aún no tienes reservaciones",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.only(bottom: 150),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/viewReservacion", arguments: {
                                    "paqueteObject": snapshot.data[index]
                                  });
                                },
                                child: FeaturedCard(
                                  placeModel: snapshot.data[index],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
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
                                      size: 36,
                                      color: kAppTheme.accentColor
                                          .withOpacity(0.35)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/Popular");
                                  }),
                              IconButton(
                                  icon: Icon(Icons.calendar_today_rounded,
                                      size: 36, color: kAppTheme.accentColor),
                                  onPressed: () {}),
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
                                  onPressed: () {})
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
