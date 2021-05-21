import 'package:aliceblue_task/Services/Preferences.dart';
import 'package:aliceblue_task/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer{
  Future<String> name = Preferences.getString(Constants.userName);
  Future<String> mailID = Preferences.getString(Constants.userMailID);

  Widget sideDrawer() => Drawer(
    child: UserAccountsDrawerHeader(
      accountName: Text('$name'),
      accountEmail: Text("${mailID}"),
    ),
  );

}

