import 'package:flutter_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/product_detail.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool renderDeleteButton;

  ProductTile(this.product, this.renderDeleteButton);

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetail(
                  product.name, product.price, product.description, product.imageUrl)),
        );
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
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Container(
            height: 80.0,
            child:ListTile(
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 80.0,
                    minHeight: 80.0,
                    maxWidth: 90.0,
                    maxHeight: 90.0,
                  ),
                  child: Image.network(product.imageUrl)
                ),
                title: Text(product.name),
                subtitle: Text('Cena:  ${product.price} din'),
                trailing: renderDeleteButton ? ButtonTheme(
                  buttonColor: Colors.red,
                  minWidth: 50.0,
                  height: 32.0,
                  child: RaisedButton(
                    onPressed: () {
                      DatabaseService(uid: user.uid).deleteBucketProducts(product.name, product.price);
                    },
                    child: Text("Obrisi", style: TextStyle(color: Colors.white)),
                  ),
                ): SizedBox()),
          )
        ),
      ),
    );
  }
}
