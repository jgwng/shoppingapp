class User{
  String userUID;
  String name;
  String phoneNumber;
  List<String> postNumber;
  List<String> firstAddress;
  List<String> secondAddress;
  int userState;
  bool isAdmin;
  String userToken;
  int characterIndex;
  int level;
  int couponAmount;
  int useAmount;
  List<String> refundAccount;
  User({this.userUID, this.name,this.phoneNumber,this.firstAddress,this.characterIndex : 0,
    this.secondAddress,this.postNumber,this.userState : 0,this.isAdmin :false,this.userToken,
    this.couponAmount : 0,this.level : 1,this.useAmount : 0,this.refundAccount
  });

  Map<String, dynamic> toJson() {
    return {
      'userUID': this.userUID,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'postNumber': this.postNumber,
      'firstAddress': this.firstAddress,
      'secondAddress': this.secondAddress,
      'userState': this.userState,
      'isAdmin': this.isAdmin,
      'userToken': this.userToken,
      'characterIndex': this.characterIndex,
      'level': this.level,
      'couponAmount': this.couponAmount,
      'useAmount': this.useAmount,
      'refundAccount': this.refundAccount,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return new User(
      userUID: map['userUID'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      postNumber: map['postNumber'] as List<String>,
      firstAddress: map['firstAddress'] as List<String>,
      secondAddress: map['secondAddress'] as List<String>,
      userState: map['userState'] as int,
      isAdmin: map['isAdmin'] as bool,
      userToken: map['userToken'] as String,
      characterIndex: map['characterIndex'] as int,
      level: map['level'] as int,
      couponAmount: map['couponAmount'] as int,
      useAmount: map['useAmount'] as int,
      refundAccount: map['refundAccount'] as List<String>,
    );
  }

}