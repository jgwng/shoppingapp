class Review{
  int starRate;
  String review;
  List<String> attachedImage;
  String product;
  String uid;
  List<String> productOpt;
  DateTime createdAt;
  Review({this.starRate,this.review,this.attachedImage,this.productOpt,this.product,this.uid,this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'starRate': this.starRate,
      'review': this.review,
      'attachedImage': this.attachedImage,
      'product': this.product,
      'uid': this.uid,
      'productOpt': this.productOpt,
      'createdAt': this.createdAt,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return new Review(
      starRate: map['starRate'] as int,
      review: map['review'] as String,
      attachedImage: map['attachedImage'] as List<String>,
      product: map['product'] as String,
      uid: map['uid'] as String,
      productOpt: map['productOpt'] as List<String>,
      createdAt: map['createdAt'].toDate() as DateTime,
    );
  }

}