import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/brew_list.dart';
import 'package:flutter_app/screens/home/change_profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/popup.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Product>>.value(
      value: DatabaseService().products,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Medenjaci'),
          backgroundColor: Colors.red[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                  Icons.person,
                color: Colors.white,
              ),
              label: Text(
                  'izloguj se',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                  'izmeni profil',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeProfileInfo()),
                );
              },
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}