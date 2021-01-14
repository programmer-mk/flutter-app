import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/product_tile.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/toast_service.dart';
import 'package:provider/provider.dart';

class BucketProductList extends StatefulWidget {

  User user;
  BucketProductList({this.user});

  @override
  _BucketProductListState createState() => _BucketProductListState();
}

class _BucketProductListState extends State<BucketProductList> {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<List<Product>>(context) ?? [];

    int totalProductPrice = products.fold(0,(previous, current) => previous + current.amount * current.price);

    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: Text(
                    'Korpa',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )
                )
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductTile(products[index], true);
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child : Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                      child:Text(
                          'Ukupna cena : ',
                          style: TextStyle(
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )
                      ),
                      )
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                              '${totalProductPrice} din',
                              style: TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )
                          )
                        )
                      )
                    ],
                  )
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              child: RaisedButton(
                color: Colors.red,
                onPressed: products.isEmpty  ? null : ()  {
                  DatabaseService(uid: widget.user.uid).updateOrder(products)
                      .then((value) => DatabaseService(uid: widget.user.uid).deleteBucket())
                      .then((v) =>  ToastService.showMessage("Porudzbina je uspesno poslata"));
                  //Navigator.pop(context);
                },
                child: Text(
                    'Kupi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )
                ),
              )
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        )
    );
  }
}

