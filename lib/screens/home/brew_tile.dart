import 'package:flutter_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final Product product;
  ProductTile({ this.product });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(product.name),
          subtitle: Text('Cena:  ${product.price} din'),
        ),
      ),
    );
  }
}