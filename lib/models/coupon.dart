class Coupon{
  String couponTitle;
  num discountAmount;
  num minOrderAmount;
  DateTime expiredDate;
  String couponCode;
  List<String> couponNoticeList;
  Coupon({this.couponTitle, this.discountAmount, this.minOrderAmount, this.expiredDate,this.couponCode,this.couponNoticeList});

  Map<String, dynamic> toMap() {
    return {
      'couponTitle': this.couponTitle,
      'discountAmount': this.discountAmount,
      'minOrderAmount': this.minOrderAmount,
      'expiredDate': this.expiredDate,
      'couponCode': this.couponCode,
      'couponNoticeList': this.couponNoticeList,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return new Coupon(
      couponTitle: map['couponTitle'] as String,
      discountAmount: map['discountAmount'] as num,
      minOrderAmount: map['minOrderAmount'] as num,
      expiredDate: map['expiredDate'] as DateTime,
      couponCode: map['couponCode'] as String,
      couponNoticeList: map['couponNoticeList'] as List<String>,
    );
  }

}