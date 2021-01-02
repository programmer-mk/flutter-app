import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/register.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter_app/screens/home/welcome.dart';

class PopUpMenu {

  static Widget buildPopupDialog(BuildContext context) {
    return
      Container(
        height: 100,
        child: AlertDialog(
          content:  Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 150,
                child: FlatButton(
                  child:Text(
                    "Pocetna",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome()),
                    );
                  },
                )
              ),
              SizedBox(
                height: 5.0
              ),
              Container(
                height: 30,
                width: 150,
                child: FlatButton(
                child:Text(
                  "Registracija",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
               )
              ),
              SizedBox(
                  height: 5.0
              ),
              Container(
                  height: 30,
                  width: 150,
                  child: FlatButton(
                    child:Text(
                      "Prijava",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                  )
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 6.0),
              height: 20,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Colors.red,
                child: const Text('Zatvori'),
              ),
            )
          ],
        ),
      );
  }
}