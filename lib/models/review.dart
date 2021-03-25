class Review{
  int starRate;
  String review;
  List<String> attachedImage;

  Review({this.starRate,this.review,this.attachedImage});

  Map<String, dynamic> toMap() {
    return {
      'starRate': this.starRate,
      'review': this.review,
      'attachedImage': this.attachedImage,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return new Review(
      starRate: map['starRate'] as int,
      review: map['review'] as String,
      attachedImage: map['attachedImage'] as List<String>,
    );
  }

}