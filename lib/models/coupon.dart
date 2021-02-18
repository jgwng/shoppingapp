class Coupon{
  String couponTitle;
  num discountAmount;
  num minOrderAmount;
  DateTime expiredDate;
  String couponCode;
  List<String> couponNoticeList;
  Coupon({this.couponTitle, this.discountAmount, this.minOrderAmount, this.expiredDate,this.couponCode,this.couponNoticeList});

}