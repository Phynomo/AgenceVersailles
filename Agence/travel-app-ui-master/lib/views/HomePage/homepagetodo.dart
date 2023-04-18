import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travelappui/components/appbar.dart';
import 'package:travelappui/components/travelplacedart.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/theme.dart';
import 'package:travelappui/views/HomePage/state/homepageScrollListner.dart';
import 'package:travelappui/views/HomePage/state/homepageStateProvider.dart';

import '../../models/placesModel.dart';

get controller => null;

class HomePageAll extends StatefulWidget {
  @override
  _HomePageAllState createState() => _HomePageAllState();
}

class _HomePageAllState extends State<HomePageAll> {
  ScrollController _mainScrollController = ScrollController();

  final double _bottomBarHeight = 90;
  HomepageSrollListner _model;

  String query = '';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = HomepageSrollListner.initialise(_mainScrollController);
  }

  List<PlaceModel> allPlaces;
  var place;

  @override
  Widget build(BuildContext context) {
    HomePageStateProvider homepagestate =
        Provider.of<HomePageStateProvider>(context);
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: HomeAppBarPersonalized(
        onChanged: searchPlace,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _mainScrollController,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: StreamBuilder(
                        stream: homepagestate.getAllPlaces(query).asStream(),
                        builder: (context, snapshot) {
                          allPlaces = snapshot.data;
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

                          return GridView.builder(
                              itemCount: allPlaces.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                final place = allPlaces[index];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/view", arguments: {
                                        "paqueteObject": allPlaces[index]
                                      });
                                    },
                                    child: TravelCard(place));
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
                                      size: 36,
                                      color: kAppTheme.accentColor
                                          .withOpacity(0.35)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/Popular");
                                  }),
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
                                      size: 36, color: kAppTheme.accentColor),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.person,
                                      size: 36,
                                      color: kAppTheme.accentColor
                                          .withOpacity(0.35)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/perfil");
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

  Future searchPlace(String query) async {
    final places = await HomePageStateProvider().getAllPlaces(query);

    if(!mounted) return;

    setState((){
      this.query = query;
      this.allPlaces = places;
    });
}
}