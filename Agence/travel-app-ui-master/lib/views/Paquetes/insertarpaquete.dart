import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/components/appbar.dart';

import "package:flutter/material.dart";
import 'package:travelappui/views/HomePage/homepagetodo.dart';

import '../HomePage/state/homepageScrollListner.dart';

class FormPaquetePage extends StatefulWidget {
  @override
  _FormPaquetePageState createState() => _FormPaquetePageState();
}

final _formKey = GlobalKey<FormState>();

class _FormPaquetePageState extends State<FormPaquetePage> {
  ScrollController _mainScrollController = ScrollController();
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
      backgroundColor: kPrimaryColor,
      appBar: HomeAppBar,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    
                  )
                ]),
              )
          ],
        ),
      ),
    );
  }
}