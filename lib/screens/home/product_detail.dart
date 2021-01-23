import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/bucket.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/toast_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  String productName = '';
  int productPrice = 0;
  String productDescription = '';
  String productUsage = '';
  String imageUrl = '';
  String uid = '';

  ProductDetail(this.uid, this.productName, this.productPrice,
      this.productDescription, this.productUsage, this.imageUrl);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int currentProductAmount = 1;
  List<int> productAmounts = <int>[1, 2, 3, 4, 5, 6, 7, 8];

  Future<UserData> getUserType(User user) async {
    UserData u = await DatabaseService(uid: user.uid).getUser();
    return u;
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
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
                // empty for now
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: getUserType(user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              debugPrint('build widget: ${snapshot.data}');
              // Build the widget with data.
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Container(
                              child: Text(widget.productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                    color: Colors.red,
                                  ))),
                          SizedBox(height: 25.0),
                          Container(child: Image.network(widget.imageUrl), height: 500.0, width: 500.0,),
                          SizedBox(height: 45.0),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text('Cena po jedinici : ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.black26,
                                          ))),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Container(
                                      child: Text('${widget.productPrice} din',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.red,
                                          )))
                                ],
                              )),
                          SizedBox(height: 30.0),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text('Opis : ',
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.black26,
                                          ))),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Container(
                                      child: Text(
                                        '${widget.productDescription}',
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: Colors.red,
                                        ),
                                        //overflow: TextOverflow.ellipsis,
                                        //textAlign: TextAlign.justify,
                                      ),
                                    ),
                                ],
                              )),
                          SizedBox(height: 30.0),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text('Nacin koriscenja : ',
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.black26,
                                          ))),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Container(
                                    child:  Text(
                                        '${widget.productUsage}', maxLines: 4,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: Colors.red,
                                        ),
                                        //overflow: TextOverflow.ellipsis,
                                        //textAlign: TextAlign.justify,
                                      ),
                                    ),

                                ],
                              )),
                          SizedBox(height: 30.0),
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Container(
                                  child: Text('Kolicina : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                        color: Colors.black26,
                                      ))),
                              SizedBox(
                                width: 15.0,
                              ),
                              Container(
                                  child: DropdownButton<int>(
                                    value: currentProductAmount,
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.red),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.red,
                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        currentProductAmount = newValue;
                                      });
                                    },
                                    items: productAmounts
                                        .map<DropdownMenuItem<int>>((
                                        int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text('${value}'),
                                      );
                                    }).toList(),
                                  )),
                            ]),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text('Ukupna cena : ',
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.black26,
                                          ))),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Container(
                                      child: Text(
                                        '${widget.productPrice *
                                            currentProductAmount} din',
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: Colors.red,
                                        ),
                                        //overflow: TextOverflow.ellipsis,
                                        //textAlign: TextAlign.justify,
                                      ),
                                    ),
                                ],
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          userData.userType == 0 ? Container(
                            child: ElevatedButton(
                              onPressed: () {
                                /*
                           save product to bucket
                          */
                                DatabaseService(uid: widget.uid)
                                    .addProductToBucket(
                                    widget.productName,
                                    widget.productPrice,
                                    widget.productDescription,
                                    '',
                                    widget.imageUrl,
                                    currentProductAmount)
                                    .then((v) => ToastService.showMessage(
                                    "Proizvod uspesno dodat u korpu"));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Bucket()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text(
                                "Dodaj u korpu",
                              ),
                            ),
                          ) : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // We can show the loading view until the data comes back.
              debugPrint('waiting user data...');
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
