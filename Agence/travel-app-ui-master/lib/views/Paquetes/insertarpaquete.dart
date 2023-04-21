// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelappui/constants/colors.dart';
import 'package:travelappui/components/appbar.dart';

import "package:flutter/material.dart";
import 'package:travelappui/services/photos_service.dart';
import 'package:travelappui/views/HomePage/homepagetodo.dart';
// import 'package:travelappui/views/HomePage/homepagetodo.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: HomeAppBar,
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            // SizedBox(height: 20.0,),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      myController: controller,
                      fieldName: 'Nombre del paquete',
                      myIcon: Icons.text_fields_rounded,
                      prefixColor: kAccentColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MyTextField(
                      myController: controller,
                      fieldName: 'Precio',
                      myIcon: Icons.monetization_on_outlined,
                      prefixColor: kAccentColor.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        if (imageFile != null)
                          Container(
                            width: 640,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                                border:
                                    Border.all(width: 8, color: Colors.grey),
                                borderRadius: BorderRadius.circular(12.0)),
                          )
                        else
                          Container(
                            width: 640,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(width: 8, color: Colors.grey),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Text(
                              'Ingrese una imagen',
                              style: TextStyle(fontSize: 26),
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {
                                getImage(source: ImageSource.gallery);
                              },
                              child: Text(
                                "Seleccionar",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {
                                getImage(source: ImageSource.camera);
                              },
                              child: Text(
                                "Cámara",
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                    MyButton(
                      onPress: () {
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Procesando info')));
                        }

                        uploadImage(imageFile);
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(200, 50),
        ),
        onPressed: onPress,
        child: Text(
          "Enviar".toUpperCase(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
      ),
    );
  }
}
