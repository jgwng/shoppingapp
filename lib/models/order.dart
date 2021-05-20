class Order{
  String orderNumber;
  DateTime createdAt;
  String orderQuantity;
  num orderAmount;
  num orderState;
  String deliveryNumber;
  List<OrderItem> orderItem;
  String howToPay;
  List<String> orderInfo;


  Order({this.orderNumber,this.createdAt,this.orderQuantity,this.orderAmount,this.orderState,
  this.deliveryNumber,this.orderItem,this.howToPay,this.orderInfo});
  Map<String, dynamic> toMap() {
    return {
      'orderNumber': this.orderNumber,
      'createdAt': this.createdAt,
      'orderQuantity': this.orderQuantity,
      'orderAmount': this.orderAmount,
      'orderState': this.orderState,
      'deliveryNumber': this.deliveryNumber,
      'orderItem': this.orderItem,
      'howToPay': this.howToPay,
      'orderInfo': this.orderInfo,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return new Order(
      orderNumber: map['orderNumber'] as String,
      createdAt: map['createdAt'] as DateTime,
      orderQuantity: map['orderQuantity'] as String,
      orderAmount: map['orderAmount'] as num,
      orderState: map['orderState'] as num,
      deliveryNumber: map['deliveryNumber'] as String,
      orderItem: map['orderItem'] as List<OrderItem>,
      howToPay: map['howToPay'] as String,
      orderInfo: map['orderInfo'] as List<String>,
    );
  }

}






class OrderItem{
  String productName;
  String quantity;
  String amount;
  String color;
  String size;

  OrderItem({this.productName = 'aaaa',this.quantity = '1',this.amount = '40000',this.color = '보라',this.size = 'XL'});

}