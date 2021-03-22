import 'dart:async';
import 'package:shoppingapp/constants/firestore_path.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/providers/firebase_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Firebase CloudStore CRUD 하는 곳
class FirestoreRepository {
  final Reader read;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String get uid => read(firebaseAuthProvider).currentUser.uid;
  FirestoreRepository({this.read});

  Future<int> getUserState() async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.data() == null) return 0;
    return userSnapshot.data()['userState'];
  }

  Future<User> fetchUserData() async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    DocumentSnapshot userSnapshot = await userRef.get();
    User user = User.fromJson(userSnapshot.data(), userSnapshot.id);
    return user;
  }

  updateUser(Map<String, dynamic> updateData) async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    await userRef.update(updateData);
  }

  Future<void> setUserData(User user) async {
    Map<String, dynamic> userInfo = user.toJson();
    print(userInfo);
    print("uid : $uid");
    await firestore.collection('user').doc(uid).set(userInfo);
    print("data update");
  }

  Future<List<Product>> fetchCartData() async {
    Query cartQry = firestore.collection(FirestorePath.cart(uid));
    QuerySnapshot snapshots = await cartQry.get();
    List<Product> cartList = [];
    if (snapshots.size != 0) {
      cartList = snapshots.docs.map((e) => Product.fromJson(e.data())).toList();
    }
    return cartList;
  }

  addCartItem(Product product) async {
    Map<String,dynamic> newCartItem  = product.toJson();
    DocumentReference userRef = firestore.doc(FirestorePath.cart(uid));
    await userRef.update(newCartItem);
  }

  removeCartItem(Product product) async {
    DocumentReference userRef = firestore.doc(FirestorePath.cartItem(uid,product.title));
    await userRef.delete();
  }

  clearCart() async{
    DocumentReference userRef = firestore.doc(FirestorePath.cart(uid));
    await userRef.delete();
  }

  Future<List<Product>> fetchFavorite() async {
    Query cartQry = firestore.collection(FirestorePath.favorite(uid));
    QuerySnapshot snapshots = await cartQry.get();
    List<Product> cartList = [];
    if (snapshots.size != 0) {
      cartList = snapshots.docs.map((e) => Product.fromJson(e.data())).toList();
    }
    return cartList;
  }

  addFavoriteItem(Product product) async {
    Map<String,dynamic> newCartItem  = product.toJson();
    DocumentReference userRef = firestore.doc(FirestorePath.favorite(uid));
    await userRef.update(newCartItem);
  }

  removeFavoriteItem(Product product) async {
    DocumentReference userRef = firestore.doc(FirestorePath.favoriteItem(uid,product.title));
    await userRef.delete();
  }

  clearFavoriteList() async{
    DocumentReference userRef = firestore.doc(FirestorePath.favorite(uid));
    await userRef.delete();
  }
}