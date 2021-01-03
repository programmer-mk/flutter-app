import 'dart:io';

import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/popup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  int price = 0;
  String description ='';
  String usage = '';

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return loading
        ? Loading()
        : Scaffold(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Container(
                          child: Text('Prijava',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.red,
                              ))),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Ime",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Unesite ime proizvoda' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Cena",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) =>
                            val.isEmpty ? 'Unesite cenu proizvoda' : null,
                        onChanged: (val) {
                          setState(() => price = int.parse(val));
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Opis",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Unesite opis proizvoda' : null,
                        onChanged: (val) {
                          setState(() => description = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Nacin koriscenja",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) => val.isEmpty
                            ? 'Unesite nacin koriscenja proizvoda'
                            : null,
                        onChanged: (val) {
                          setState(() => usage = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        child:Center(
                          child: _image == null
                              ? Text('Slika nije selektovana.')
                              : Image.file(_image),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        child: FloatingActionButton(
                          onPressed: getImage,
                          tooltip: 'Odaberite sliku',
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      RaisedButton(
                          color: Colors.red[600],
                          child: Text(
                            'Dodaj proizvod',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              await DatabaseService(uid: user.uid).updateProduct(name, price, description, usage, _image);
                              Navigator.pop(context);
                              // if (result == null) {
                              //   setState(() {
                              //     loading = false;
                              //     error = 'Neuspesno dodavanje proizvoda!';
                              //   });
                              // }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
