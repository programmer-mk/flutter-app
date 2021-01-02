import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/popup.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;


  // text field state
  String email = '';
  String password = '';

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
      body: Container(
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
                  labelText: "Email",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
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
              RaisedButton(
                  color: Colors.red[600],
                  child: Text(
                    'Prijavi se',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Ne mozete da se prijavite sa tim kredencijalima';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}