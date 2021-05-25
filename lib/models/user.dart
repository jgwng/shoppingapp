class User{
  String userUID;
  String name;
  String phoneNumber;
  List<dynamic> address;
  int userState;
  bool isMan;
  bool isAdmin;
  String birth;
  String userToken;
  int characterIndex;
  int level;
  int couponAmount;
  int useAmount;
  List<dynamic> refundAccount;
  User({this.userUID, this.name,this.phoneNumber,this.address,this.characterIndex : 0,
   this.userState : 0,this.isAdmin :false,this.userToken,this.birth,
    this.couponAmount : 0,this.level : 1,this.useAmount : 0,this.refundAccount,this.isMan : false
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
      'isMan' : this.isMan,
      'birthday' : this.birth
    };
  }
  @override
  String toString(){
    return 'user : refund ${this.refundAccount.runtimeType} address ${this.address.runtimeType}';
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return new User(
      userUID: map['userUID'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as List<dynamic>,
      userState: map['userState'] as int,
      isAdmin: map['isAdmin'] as bool,
      userToken: map['userToken'] as String,
      characterIndex: map['characterIndex'] as int,
      birth: map['birthday'] as String,
      level: map['level'] as int,
      couponAmount: map['couponAmount'] as int,
      useAmount: map['useAmount'] as int,
      refundAccount: map['refundAccount'] as List<dynamic>,
      isMan: map['isMan'] as bool
    );
  }

}
class CheckInState{
  bool isEnter;

  CheckInState({this.isEnter});

  Map<String, dynamic> toMap() {
    return {
      'isEnter': this.isEnter,
    };
  }

  factory CheckInState.fromJson(Map<String, dynamic> map) {
    return new CheckInState(
      isEnter: map['isEnter'] as bool,
    );
  }
}