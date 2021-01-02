import 'package:flutter/material.dart';
import 'package:flutter_app/shared/popup.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          elevation: 0.0,
          title: Text('Medenjaci'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              label: Text(''),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      PopUpMenu.buildPopupDialog(context),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      Container(
                          child: Text('Dobrodosli',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.red,
                              ))),
                      SizedBox(height: 20.0),
                      Container(
                        child: Image.asset('assets/images/medenjaci-welcome.png')
                      )
                    ],
                  ),
                ),
                ],
              ),
            ));
    }
  }