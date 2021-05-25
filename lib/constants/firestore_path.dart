class FirestorePath{

  FirestorePath._();

  static String user(String userUid) => 'user/$userUid';

  static String cart(String userUid) => 'user/$userUid/cart';
  static String cartItem(String userUid,String product) => 'user/$userUid/cart/$product';

  static String favorite(String userUid) => 'user/$userUid/favorite';
  static String favoriteItem(String userUid,String product) => 'user/$userUid/favorite/$product';

  static String address(String userUid) => 'user/$userUid/address';
  static String addressItem(String userUid,String docId) => 'user/$userUid/address/$docId';

  static String coupon(String userUid) => 'user/$userUid/coupon';
  static String couponInfo(String couponCode) => 'coupon/$couponCode';

  static String review(String userUid,String product) => 'product/$product/review/$userUid';

  static String notices(String userUid) => 'user/$userUid/notices';
  static String checkIn(String userUid) => 'user/$userUid/checkIn';
}