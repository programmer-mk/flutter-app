import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/product_detail.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return GestureDetector(
      onTap: () {
        // nothing for now
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.black,
              width: 0.1,
            ),
          ),
          margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
          child: Container(
              height: 80.0,
              child: Container(
                  height: 80.0,
                  width: 200.0,
                  child: ListTile(
                      leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 60.0,
                            minHeight: 60.0,
                            maxWidth: 90.0,
                            maxHeight: 90.0,
                          ),

                      child: Center(
                        child:Text('id: ${order.id}'),)
                      ),
                      title: Text('ime kupca: ${order.buyerName}', style: TextStyle(fontSize: 12.0)),
                      subtitle: RaisedButton( child: Text('Proizvodi   '),
                        onPressed: () {

                        },
                      ),
                      trailing: Container(
                        width: 100.0,
                          child: Column(
                        children: [
                          Container(
                            height: 20.0,
                            child: ButtonTheme(
                              buttonColor: Colors.red,
                              minWidth: 50.0,

                              child: RaisedButton(
                                onPressed: () {
                                  DatabaseService(uid: user.uid)
                                      .deleteOrder(order.id);
                                },
                                child: Text("Obrisi",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),

                          ),
                          SizedBox(height:12.0),
                         Container(
                           height: 20.0,
                           child:ButtonTheme(
                             buttonColor: Colors.red,
                             minWidth: 50.0,

                             child: RaisedButton(
                               onPressed: () {
                                 DatabaseService(uid: user.uid).proceedOrder(order.id);
                               },
                               child: Text("Obradi",
                                   style: TextStyle(color: Colors.white)),
                             ),
                           ),
                         ),
                        ],
                      ))))),
        ),
      ),
    );
  }
}
