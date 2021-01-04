import 'package:flutter/material.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/add_product.dart';
import 'package:flutter_app/screens/home/order_tile.dart';
import 'package:flutter_app/screens/home/product_tile.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];

    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: Text('Porudzbine',
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
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderTile(orders[index]);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
                child: Row(
              children: [
                Expanded(
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
                                            color: Colors.white))))))),
                Expanded(
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
                                        style:
                                            TextStyle(color: Colors.white)))))))
              ],
            )),
            SizedBox(
              height: 30.0,
            ),
          ],
        ));
  }
}
