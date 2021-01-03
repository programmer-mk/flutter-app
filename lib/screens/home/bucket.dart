import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/brew_list.dart';
import 'package:flutter_app/screens/home/bucket_products.dart';
import 'package:flutter_app/screens/home/change_profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class Bucket extends StatefulWidget {

  @override
  _BucketState createState() => _BucketState();
}


class _BucketState extends State<Bucket> {

  final AuthService _auth = AuthService();

  int currentTotalPrice;


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamProvider<List<Product>>.value(
      value: DatabaseService(uid: user.uid).bucketProducts,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
              'Medenjaci',
              style: TextStyle(
                fontSize: 14.0
            )
          ),
          backgroundColor: Colors.red[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 14.0,
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
                  size: 15.0
              ),
              label: Text(
                  'izmeni profil',
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
              onPressed: () {

              },
            ),
          ],
        ),
        body: BucketProductList(),
      ),
    );
  }
}