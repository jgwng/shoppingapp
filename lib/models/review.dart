class Review{
  int starRate;
  String review;
  List<String> attachedImage;
  String product;
  String uid;
  List<String> productOpt;
  Review({this.starRate,this.review,this.attachedImage,this.productOpt,this.product,this.uid});

  Map<String, dynamic> toMap() {
    return {
      'starRate': this.starRate,
      'review': this.review,
      'attachedImage': this.attachedImage,
      'product': this.product,
      'uid': this.uid,
      'productOpt': this.productOpt,
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
    );
  }

}