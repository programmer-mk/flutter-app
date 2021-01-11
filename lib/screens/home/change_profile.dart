import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:provider/provider.dart';

class ChangeProfileInfo extends StatefulWidget {
  @override
  _ChangeProfileInfoState createState() => _ChangeProfileInfoState();
}

class _ChangeProfileInfoState extends State<ChangeProfileInfo> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentFirstName;
  String _currentLastName;
  String _currentPhone;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
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
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            'Izmeni licne podatke',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Center(
                                        child: Text('Ime : ',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: userData.firstName,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Molimo vas unesite vase ime'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => _currentFirstName = val),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10)
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Center(
                                        child: Text('Prezime : ',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: userData.lastName,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Molimo vas unesite vase prezime'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => _currentLastName = val),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10)
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Center(
                                        child: Text('Telefon : ',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: userData.phone,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Molimo vas unesite vas telefon'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => _currentPhone = val),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10)
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Center(
                                        child: Text('Adresa : ',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: userData.address,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? 'Molimo vas unesite vasu adresu'
                                        : null,
                                    onChanged: (val) =>
                                        setState(() => _currentAddress = val),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 10)
                              ],
                            ),
                          ),
                          SizedBox(height: 35.0),
                          RaisedButton(
                              color: Colors.red[600],
                              child: Text(
                                'Sacuvaj',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DatabaseService(uid: user.uid)
                                      .updateUserData(
                                          _currentFirstName ??
                                              snapshot.data.firstName,
                                          _currentLastName ??
                                              snapshot.data.lastName,
                                          _currentPhone ??
                                              snapshot.data.phone,
                                          _currentAddress ??
                                              snapshot.data.address,
                                          // userType cannot be changed
                                          userData.userType);
                                  Navigator.pop(context);
                                }
                              }),
                        ],
                      ),
                    ))
              ]));
            } else {
              print('ovde greska');
              return Loading();
            }
          }),
    );
  }
}
