import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/popup.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String phone = '';
  String address = '';

  int _radioValue = -1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                      Container(
                          child: Text('Registracija',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.red,
                              ))),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) => val.isEmpty ? 'Unesi email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Unesi sifru 6+ karaktera duzine'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Ime",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) => val.length < 6 ? 'Unesi ime' : null,
                        onChanged: (val) {
                          setState(() => firstName = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Prezime",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) =>
                            val.length < 6 ? 'Unesi prezime' : null,
                        onChanged: (val) {
                          setState(() => lastName = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Telefon",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) =>
                            val.length < 6 ? 'Unesi telefon' : null,
                        onChanged: (val) {
                          setState(() => phone = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Adresa",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        obscureText: false,
                        validator: (val) =>
                            val.length < 6 ? 'Unesi adresu' : null,
                        onChanged: (val) {
                          setState(() => address = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            'Kupac',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            'Prodavac',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.red[600],
                          child: Text(
                            'Registruj se',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, firstName, lastName, phone, address, _radioValue).then((x) =>  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false));
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Molim vas unesite validnu email adresu';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ])));
  }
}
