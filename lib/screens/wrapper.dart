import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatefulWidget {


  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    }else {
      //Navigator.pop(context);
      return Home();
    }
  }
}