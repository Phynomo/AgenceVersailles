import 'package:flutter/material.dart';
import 'package:travelappui/constants/constants.dart';

AppBar HomeAppBar = AppBar(
  title: Center(
      child: Text(
    "Discover",
    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2),
  )),
  leading: PopupMenuButton(
     offset: Offset.fromDirection(2, 58),
    onSelected: (value){

    },
    icon: Icon(Icons.menu),
    itemBuilder: (context) {
      return kAppBarMenuOptions
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: Container(
                width: 120,
                child: Text(option,style: TextStyle(color: Colors.black),),
              ),
            ),
          )
          .toList();
    },
  ),
  actions: [
    IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 36,
        ),
        onPressed: () {})
  ],
);

class HomeAppBarPersonalized extends AppBar {
  final Function(String) onChanged;

  HomeAppBarPersonalized({this.onChanged})
      : super(
          title: Center(
            child: Text(
              "Discover",
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2,),
            ),
          ),
          leading: PopupMenuButton(
            offset: Offset.fromDirection(2, 58),
            onSelected: (value) {},
            icon: Icon(Icons.menu),
            itemBuilder: (context) {
              return kAppBarMenuOptions
                  .map(
                    (option) => PopupMenuItem(
                      value: option,
                      child: Container(
                        width: 120,
                        child: Text(
                          option,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                  .toList();
            },
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.account_circle,
                  size: 36,
                ),
                onPressed: () {})
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: onChanged,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Buscar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kAccentColor),
                  ),
                ),
              ),
            ),
          ),
        );
}