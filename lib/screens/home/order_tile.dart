import 'package:flutter_app/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
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
                        child:Text('id: ${order.id.substring(0, 5)}'),)
                      ),
                      title: Text('ime kupca: ${order.buyerName}', style: TextStyle(fontSize: 12.0)),
                      subtitle: RaisedButton( child: Text('Proizvodi   '),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Proizvodi'),
                                  content: setupAlertDialoadContainer(),
                                );
                              });
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

  Widget setupAlertDialoadContainer() {
    return Container(// Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: Container(
        child: FractionallySizedBox(
        heightFactor: 0.5,
        child:Column(
          children: [
            Container(
              child:ListView.builder(
                shrinkWrap: true,
                itemCount: order.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(
                        '${index+1} )',
                        style: TextStyle(fontSize: 14.0)
                    ),
                    title: Text('${order.products[index].amount}  X  ${order.products[index].name}',
                        style: TextStyle(fontSize: 14.0)),
                    trailing: Text('${order.products[index].price}  din',
                        style: TextStyle(fontSize: 14.0)),
                  );
                },
              ),

            ),
            SizedBox(
             height: 50.0,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(child: Text('Ukupna cena : ')),
                  Expanded(child:SizedBox()),
                //Product totalProduct = products.fold(Product('', 0, '', '', ''), (previous, current) => Product('', previous.price + current.price, '', '', ''));
                  Expanded(child: Text('${order.products.map((x) => x.price * x.amount).fold(0, (previous, current) => previous + current)} din ',
                  style: TextStyle(color: Colors.red),)
                  )
                ],
              )
            )
          ],
        )
        ),
      )
    );
  }
}
