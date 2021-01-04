import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/add_product.dart';
import 'package:flutter_app/screens/home/product_tile.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  bool seller;

  ProductList({this.seller});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];

    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: Text('Proizvodi',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ))),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductTile(products[index], false);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
                child: Row(
              children: [
                widget.seller
                    ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 35.0, right: 35.0),
                            child: Container(
                                child: ButtonTheme(
                                    buttonColor: Colors.red,
                                    child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddProduct()));
                                        },
                                        child: Text('Dodaj proizvod',
                                            style: TextStyle(
                                                color: Colors.white)))))))
                    : SizedBox(),
                widget.seller
                    ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 35.0, right: 35.0),
                            child: Container(
                                child: ButtonTheme(
                                    buttonColor: Colors.red,
                                    child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddProduct()));
                                        },
                                        child: Text('Porudzbine',
                                            style: TextStyle(
                                                color: Colors.white)))))))
                    : SizedBox(),
              ],
            )),
            SizedBox(
              height: 30.0,
            ),
          ],
        ));
  }
}
