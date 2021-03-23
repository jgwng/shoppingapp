class FirestorePath{

  FirestorePath._();

  static String user(String userUid) => 'user/$userUid';

  static String cart(String userUid) => 'user/$userUid/cart';
  static String cartItem(String userUid,String product) => 'user/$userUid/cart/$product';

  static String favorite(String userUid) => 'user/$userUid/favorite';
  static String favoriteItem(String userUid,String product) => 'user/$userUid/favorite/$product';

  static String coupon(String userUid) => 'user/$userUid/coupon';


}