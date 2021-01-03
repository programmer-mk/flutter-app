import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BucketProductList extends StatefulWidget {
  @override
  _BucketProductListState createState() => _BucketProductListState();
}

class _BucketProductListState extends State<BucketProductList> {
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
            Container(
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {

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

