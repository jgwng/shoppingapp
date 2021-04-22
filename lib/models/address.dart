class Address{
  List<dynamic> address;
  bool isBasic;

  Address({this.address,this.isBasic});

  Map<String, dynamic> toMap() {
    return {
      'address': this.address,
      'isBasic': this.isBasic,
    };
  }

  factory Address.fromJson(Map<String, dynamic> map) {
    return new Address(
      address: map['address'] as List<dynamic>,
      isBasic: map['isBasic'] as bool,
    );
  }
}