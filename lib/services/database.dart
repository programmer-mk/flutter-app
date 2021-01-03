import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      List<dynamic> bucketProducts = snapshot.data['bucketProducts'];
      for (var i=0; i<bucketProducts.length; i++) {
        productsResult.add(Product(bucketProducts[i]['name'], bucketProducts[i]['price'],
            bucketProducts[i]['description'], bucketProducts[i]['usage'], bucketProducts[i]['imageUrl']));
      }
      return productsResult;
  }

  // brew list from snapshot
  List<Product> _brewListFromSnapshot(QuerySnapshot snapshot) {
    var products = snapshot.documents;
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Product(doc.data['name'] ?? '', doc.data['price'] ?? '', doc.data['description'] ?? '',
          doc.data['usage'] ?? '', doc.data['imageUrl'] ?? '');
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