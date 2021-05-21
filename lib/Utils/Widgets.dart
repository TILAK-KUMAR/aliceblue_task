import 'package:aliceblue_task/Utils/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

Widget Loader() =>Center(child: CircularProgressIndicator(),);

Widget BottomTabs() =>BottomNavigationBar(
  elevation: 5.0,
  backgroundColor: Colors.grey[200],
  unselectedLabelStyle: TextStyle(color: Colors.grey),
  unselectedItemColor:Colors.grey ,
  selectedIconTheme: IconThemeData(color: MyColors.buttonColor),
  unselectedIconTheme: IconThemeData(color: Colors.grey),
    selectedItemColor: MyColors.buttonColor,
  selectedLabelStyle: TextStyle(color: MyColors.buttonColor),
  currentIndex: 0, // this will be set when a new tab is tapped
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      title: new Text('Schemes'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.card_travel),
      title: new Text('Orders'),
    ),
  ],
);

Widget NavDrawer() => Drawer(
    child: ListView(
      children: <Widget>[
        Container(
          color: MyColors.buttonColor,
          child: UserAccountsDrawerHeader(
            accountName: Text('${Constants.userName}'),
            accountEmail: Text('${Constants.userMailID}'),
          ),
        ),
      ],
    )
);