import 'dart:async';
import 'package:shoppingapp/constants/firestore_path.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/models/address.dart';
import 'package:shoppingapp/models/notice.dart';
import 'package:shoppingapp/models/coupon.dart';
import 'package:shoppingapp/models/review.dart';
import 'package:shoppingapp/models/announcement.dart';
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
    print(userSnapshot.data());
    User user = User.fromJson(userSnapshot.data());
    print(user);
    print(user.toString());
    return user;
  }

  Stream<bool> checkInStream() {
    final Query checkInQry = firestore.collection(FirestorePath.checkIn(uid));
    final Stream<QuerySnapshot> snapshots = checkInQry.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs.map((snapshot) => CheckInState.fromJson(snapshot.data()));
      return result.first.isEnter;
    });
  }






  Stream<List<Notice>> noticeStream() {
    final Query noticeQry = firestore.collection(FirestorePath.notices(uid)).orderBy('createdAt', descending: true);
    final Stream<QuerySnapshot> snapshots = noticeQry.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs.map((snapshot) => Notice.fromJson(snapshot.data(), snapshot.id)).toList();
      return result;
    });
  }

  updateUserInfo(Map<String, dynamic> updateData) async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    await userRef.update(updateData);
  }

  updateAddressList(List<Address> addressList) async {
    WriteBatch batch = firestore.batch();
    for(int i = 0;i<addressList.length;i++){
      DocumentReference addressRef = firestore.collection(FirestorePath.address(uid)).doc();
      batch.set(addressRef,addressList[i].toMap());
    }
    await batch.commit();
  }
  
  deleteAddressList(Address address) async{
    QuerySnapshot addressRef  = await firestore.collection(FirestorePath.address(uid)).where("address", isEqualTo: address.address).get();
    await firestore.doc(FirestorePath.addressItem(uid,addressRef.docs[0].id)).delete();
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

  Future<List<Announcement>> fetchAllAnnouncement() async{
    Query announcementQuery = firestore.collection('announcement');
    QuerySnapshot snapshots = await announcementQuery.get();
    List<Announcement> announcementList = [];
    if (snapshots.size != 0) {
      announcementList = snapshots.docs.map((e) => Announcement.fromJson(e.data())).toList();
    }
    return announcementList;
  }
  addReview(Review review) async {
    review.uid = uid;
    Map<String,dynamic> newReview  = review.toJson();
    DocumentReference userRef = firestore.doc(FirestorePath.review(review.product,uid));
    await userRef.set(newReview);
  }

  addFavoriteItem(Product product) async {
    Map<String,dynamic> newCartItem  = product.toJson();
    print(newCartItem);
    DocumentReference userRef = firestore.doc(FirestorePath.favoriteItem(uid,product.title));
    await userRef.set(newCartItem);
  }

  removeFavoriteItem(Product product) async {
    DocumentReference userRef = firestore.doc(FirestorePath.favoriteItem(uid,product.title));
    await userRef.delete();
  }

  clearFavoriteList() async{
    DocumentReference userRef = firestore.doc(FirestorePath.favorite(uid));
    await userRef.delete();
  }

  Future<void> addCart(Cart cart ) async {
    Map<String,dynamic> newCartItem  = cart.toMap();
    DocumentReference userRef = firestore.doc(FirestorePath.cartItem(uid,cart.productName));
    await userRef.set(newCartItem);
  }
  Future<dynamic> getCouponInfo(String couponCode) async{
    var result;
    Query cartQry = firestore.collection(FirestorePath.couponInfo(couponCode));
    QuerySnapshot snapshots = await cartQry.get();
    if(snapshots.size != 0){
      result =  snapshots.docs.map((e) => Coupon.fromJson(e.data()));
    }else{
      result = -1;
    }
    return result;
  }
  Future<List<Coupon>> fetchAllCoupon() async{
    Query cartQry = firestore.collection(FirestorePath.coupon(uid));
    QuerySnapshot snapshots = await cartQry.get();
    List<Coupon> couponList = [];
    if (snapshots.size != 0) {
      couponList = snapshots.docs.map((e) => Coupon.fromJson(e.data())).toList();
    }
    return couponList;
  }

}