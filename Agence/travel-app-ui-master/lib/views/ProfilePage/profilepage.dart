import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../HomePage/state/homepageScrollListner.dart';


class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}


class _PerfilPageState extends State<PerfilPage> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, 
                            icon: Icon(Icons.arrow_back),
                            color: Colors.purple.shade900,),
        title: Text("Perfil", style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          // IconButton(onPressed: (){}, icon: icon)
        ]
      ),
      body: SingleChildScrollView(
        child: Container(

        ),
      )
    );
  }
}