import 'package:aliceblue_task/Home/OrdersList.dart';
import 'package:aliceblue_task/Home/SchemeList.dart';
import 'package:aliceblue_task/Services/Preferences.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:aliceblue_task/Utils/Widgets.dart';
import 'package:aliceblue_task/Utils/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:aliceblue_task/Utils/MyColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String _name,_email,_userId;
   int _currentIndex = 0;
   final List<Widget> _children = [SchemeLists(),OrdersList()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

   void onTabTapped(int index) {
     setState(() {
       _currentIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: BottomNavigationBar(
        onTap:onTabTapped ,
        elevation: 5.0,
        backgroundColor: Colors.grey[200],
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedItemColor:Colors.grey ,
        selectedIconTheme: IconThemeData(color: MyColors.buttonColor),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedItemColor: MyColors.buttonColor,
        selectedLabelStyle: TextStyle(color: MyColors.buttonColor),
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
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
      ),
      body: _children[_currentIndex],

    );
  }

  void getUserDetails() async{
    String name = await Preferences.getString(Constants.userName);
    String email = await Preferences.getString(Constants.userMailID);

    setState(() {
      _name = name;
      _email = email;
    });

  }
}
