import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');
  final CollectionReference bucketCollection = Firestore.instance.collection('bucket');
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String firstName, String lastName, String phone, String address) async {
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        phone: snapshot.data['phone'],
        address: snapshot.data['address']
    );
  }

  List<Product> _bucketProductListFromSnapshot(DocumentSnapshot snapshot) {
      List<Product> productsResult = [];
      List<dynamic> bucketProducts = snapshot.data['bucketProducts'];
      for (var i=0; i<bucketProducts.length; i++) {
        productsResult.add(Product(bucketProducts[i]['name'], bucketProducts[i]['price'], bucketProducts[i]['description']));
      }
      return productsResult;
  }

  // brew list from snapshot
  List<Product> _brewListFromSnapshot(QuerySnapshot snapshot) {
    var products = snapshot.documents;
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Product(doc.data['name'] ?? '', doc.data['price'] ?? '', doc.data['description'] ?? '');
    }).toList();
  }

  // get brews stream
  Stream<List<Product>> get products {
    return productCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  Stream<List<Product>> get bucketProducts {
    return bucketCollection.document(uid).snapshots()
        .map(_bucketProductListFromSnapshot);
  }

  List<dynamic> _filterBucketProductListFromSnapshot(DocumentSnapshot snapshot, String productName, int productPrice) {
    List<dynamic> productsResult = [];
    List<dynamic> bucketProducts = snapshot.data['bucketProducts'];
    for (var i=0; i<bucketProducts.length; i++) {
      if(bucketProducts[i]['name'] == productName && bucketProducts[i]['price'] == productPrice) {
        //delete
      }else {
        productsResult.add(bucketProducts[i]);
      }
    }
    return productsResult;
  }

  Future<void> deleteBucketProducts(String productName, int productPrice)  async {
    // TODO: create unique product uuid, for now primary key of product is identifed by (productName + productPrice)

    DocumentSnapshot data = await bucketCollection.document(uid).snapshots().first;
    var filteredResult = _filterBucketProductListFromSnapshot(data, productName, productPrice);
    bucketCollection.document(uid).setData({
      'bucketProducts': filteredResult,
    });
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}