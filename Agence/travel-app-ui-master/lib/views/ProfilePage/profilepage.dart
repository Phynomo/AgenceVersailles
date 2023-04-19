import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelappui/constants/colors.dart';

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.purple.shade900,
          ),
          title: Text(
            "Perfil",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            // IconButton(onPressed: (){}, icon: icon)
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).size.width < 600
              ? EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
              : EdgeInsets.symmetric(horizontal: 100.0, vertical: 30.0),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(image: AssetImage("assets/image/user.png")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Username",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
              "defaultmail@noreply.com",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 30,
            ),
            const Divider(),
            SizedBox(
              height: 20,
            ),
            ProfileMenuWidget(
              title: "Joel Papito",
              icon: Icons.person_2,
              endIcon: false,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "0501-1982-3587",
              icon: Icons.policy,
              endIcon: false,
                    onPress: () {},
                  ),
                  ProfileMenuWidget(
                    title: "02/02/1980",
                    icon: Icons.calendar_month,
                    endIcon: false,
                    onPress: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20), // Add 20 pixels of space on both sides
                    child: Divider(
                      thickness:
                          1, // Set the thickness of the divider line to 1 pixel
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    title: "Contraseña",
                    icon: Icons.key,
                    onPress: () {
                      Navigator.pushNamed(context, "/recuperar");
                    },
                  ),
                  ProfileMenuWidget(
                    title: "Cerrar sesión",
                    textColor: Colors.red,
                    icon: Icons.logout,
                    endIcon: false,
                    onPress: () {
                      Navigator.pushNamed(context, "/splash");
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kAccentColor,
                          side: BorderSide.none,
                          shape: StadiumBorder()),
                      child: Text("Administrar",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    this.title,
    this.icon,
    this.onPress,
    this.endIcon = true,
    this.textColor,
    Key key,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kAccentColor.withOpacity(0.1)),
          child: Icon(
            icon,
            color: kAccentColor,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
        ),
        trailing: endIcon
            ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.0,
                  color: Colors.grey,
                ))
            : null);
  }
}