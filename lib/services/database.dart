import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference productCollection = Firestore.instance.collection('products');
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

  // brew list from snapshot
  List<Product> _brewListFromSnapshot(QuerySnapshot snapshot) {
    var products = snapshot.documents;
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Product(
          name: doc.data['name'] ?? '',
          price: doc.data['price'] ?? '',
          description: doc.data['description'] ?? ''
      );
    }).toList();
  }

  // get brews stream
  Stream<List<Product>> get products {
    return productCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}