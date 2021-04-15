class Cart{
  String productName;
  num price;
  List<String> option;
  num itemCount;

  Cart({this.productName : '상품명이 아주 긴 경우',this.option,this.price : 45000,this.itemCount : 1});
  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'price': this.price,
      'option': this.option,
      'itemCount' : this.itemCount,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return new Cart(
      productName: map['productName'] as String,
      price: map['price'] as num,
      itemCount: map['itemCount'] as num,
      option: map['option'] as List<String>,
    );
  }
}