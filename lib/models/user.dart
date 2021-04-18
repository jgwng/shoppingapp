class User{
  String userUID;
  String name;
  String phoneNumber;
  List<String> address;
  int userState;
  bool isMan;
  bool isAdmin;
  String userToken;
  int characterIndex;
  int level;
  int couponAmount;
  int useAmount;
  List<String> refundAccount;
  User({this.userUID, this.name,this.phoneNumber,this.address,this.characterIndex : 0,
   this.userState : 0,this.isAdmin :false,this.userToken,
    this.couponAmount : 0,this.level : 1,this.useAmount : 0,this.refundAccount,this.isMan
  });

  Map<String, dynamic> toJson() {
    return {
      'userUID': this.userUID,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'userState': this.userState,
      'isAdmin': this.isAdmin,
      'userToken': this.userToken,
      'characterIndex': this.characterIndex,
      'level': this.level,
      'couponAmount': this.couponAmount,
      'useAmount': this.useAmount,
      'refundAccount': this.refundAccount,
      'isMan' : this.isMan
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return new User(
      userUID: map['userUID'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as List<String>,
      userState: map['userState'] as int,
      isAdmin: map['isAdmin'] as bool,
      userToken: map['userToken'] as String,
      characterIndex: map['characterIndex'] as int,
      level: map['level'] as int,
      couponAmount: map['couponAmount'] as int,
      useAmount: map['useAmount'] as int,
      refundAccount: map['refundAccount'] as List<String>,
      isMan: map['isMan'] as bool
    );
  }

}