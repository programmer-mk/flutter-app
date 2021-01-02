import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
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
        GestureDetector(
          onTap: (){
            print("Container clicked");
          },
          child:Container(
            child: Text(
              'Proizvodi',
              style: TextStyle(
                color: Colors.red[600],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )
            )
           ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductTile(product: products[index]);
              },
            ),
          )
        ],
      )
    );
  }
}

