import 'package:flutter_app/models/product.dart';

class Order {

  final String id;
  final String buyerName;
  final List<Product> products;

  Order(this.id,  this.buyerName, this.products);

}