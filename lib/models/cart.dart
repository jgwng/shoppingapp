class Cart{
  String productName;
  num price;
  List<String> option;

  Cart({this.productName,this.option,this.price});
  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'price': this.price,
      'option': this.option,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return new Cart(
      productName: map['productName'] as String,
      price: map['price'] as num,
      option: map['option'] as List<String>,
    );
  }
}