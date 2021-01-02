import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter_app/screens/home/welcome.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool show = false;

  @override
  Widget build(BuildContext context) {
    if(show) {
      return Welcome();
    }else {
      // dummy
      return SignIn();
    }

  }
}