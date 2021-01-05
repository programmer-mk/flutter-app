import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');
  final CollectionReference bucketCollection = Firestore.instance.collection('bucket');
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference orderCollection = Firestore.instance.collection('orders');
  final DocumentReference images = Firestore.instance.collection('images').document();

  Future<void> updateUserData(String firstName, String lastName, String phone, String address, int userType) async {
    return await userCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'userType': userType,
    });
  }

  Future<void> updateOrder(List<dynamic> products) async {

    DocumentSnapshot snapshot = await userCollection.document(uid).snapshots().first;
    String firstName = snapshot.data['firstName'];

    List<Map<dynamic, dynamic>> parsedProducts = [];
    products.forEach((product) {
      Map mapProduct = new Map();
      mapProduct['name'] =  product.name;
      mapProduct['price'] =  product.price;
      mapProduct['description'] =  product.description;
      mapProduct['usage'] =  product.usage;
      mapProduct['imageUrl'] =  product.imageUrl;
      parsedProducts.add(mapProduct) ;
    });

    await orderCollection.document(uid).setData({
      'buyerName': firstName,
      'id': uid,
      'products': parsedProducts
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        phone: snapshot.data['phone'],
        address: snapshot.data['address'],
        userType: snapshot.data['userType']
    );
  }

  Future<String> uploadFile(File _image, String imageName) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('images/${imageName}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL =  fileURL;
    });
    return returnURL;
  }

  Future<String> saveImages(File _image, String imageName, DocumentReference ref) async {
      String imageURL = await uploadFile(_image, imageName);
      return imageURL;
      //ref.updateData({"image": FieldValue.arrayUnion([imageURL])});
  }

  Future<dynamic> updateProduct(String name, int price, String description, String usage, File _image) async {

    String imageUrl = await saveImages(_image, name, images);
    return await productCollection.document(Uuid().v1()).setData({
      'name': name,
      'price': price,
      'description': description,
      'usage': usage,
      'imageUrl': imageUrl
    });
  }

  List<Product> _bucketProductListFromSnapshot(DocumentSnapshot snapshot) {
      List<Product> productsResult = [];
      if(snapshot.data != null) {
        List<dynamic> bucketProducts = snapshot.data['bucketProducts'];
        for (var i=0; i<bucketProducts.length; i++) {
          productsResult.add(Product(bucketProducts[i]['name'], bucketProducts[i]['price'],
              bucketProducts[i]['description'], bucketProducts[i]['usage'], bucketProducts[i]['imageUrl']));
        }
      }
      return productsResult;
  }

  // product list from snapshot
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    var products = snapshot.documents;
    return snapshot.documents.map((doc){
      return Product(doc.data['name'] ?? '', doc.data['price'] ?? '', doc.data['description'] ?? '',
          doc.data['usage'] ?? '', doc.data['imageUrl'] ?? '');
    }).toList();
  }


  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List<Order> list = snapshot.documents.map((doc){
      List<Product> products = List<Product>.from(doc.data["products"].map((product) {
        return new Product(product['name'] ?? '', product['price'] ?? '', product['description'] ?? '',
            product['usage'] ?? '', '');
      }));
      return Order(doc.data['id'] ?? '', doc.data['buyerName'] ?? '', products ?? List<Product>.empty());
    }).toList();
      return list;
  }

  // get product stream
  Stream<List<Product>> get products {
    return productCollection.snapshots()
        .map(_productListFromSnapshot);
  }

  Stream<List<Order>> get orders {
    return orderCollection.snapshots()
        .map(_orderListFromSnapshot);
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

  List<dynamic> _addProductToBucket(DocumentSnapshot snapshot,String productName, int productPrice,
      String description, String usage, String imageUrl) {
    List<dynamic> productsResult = [];
    if(snapshot.data != null) {
      List<dynamic> bucketProducts = snapshot.data['bucketProducts'];
      for (var i=0; i<bucketProducts.length; i++) {
        productsResult.add(bucketProducts[i]);
      }
    }

    dynamic newProduct = {
      'name': productName,
      'price': productPrice,
      'description': description,
      'usage': usage,
      'imageUrl': imageUrl
    };
    productsResult.add(newProduct);
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

  Future<void> addProductToBucket(String productName, int productPrice, String description, String usage, String imageUrl)  async {
    DocumentSnapshot data = await bucketCollection.document(uid).snapshots().first;
    var filteredResult = _addProductToBucket(data, productName, productPrice, description, usage, imageUrl);
    bucketCollection.document(uid).setData({
      'bucketProducts': filteredResult,
    });
  }

  Future<void> deleteOrder(String id)  async {
    await orderCollection.document(id).delete();
  }

  Future<void> deleteBucket()  async {
    await bucketCollection.document(uid).delete();
  }

  Future<void> proceedOrder(String id)  async {
    // mock proceed for now
    await orderCollection.document(id).delete();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
}