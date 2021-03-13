class User{
  String userUID;
  String name;
  String phoneNumber;
  String firstAddress;
  String secondAddress;
  int userState;
  bool isAdmin;
  String userToken;
  User({this.userUID, this.name,this.phoneNumber,this.firstAddress,
    this.secondAddress,this.userState : 0,this.isAdmin :false,this.userToken});



  Map<String, dynamic> toJson() {
    return {
      'userKey': this.userUID,
      'name': this.name,
      'phoneNumber': this.phoneNumber,
      'firstAddress': this.firstAddress,
      'secondAddress': this.secondAddress,
      'userState': this.userState,
      'isAdmin': this.isAdmin,
    };
  }

  factory User.fromJson(Map<String, dynamic> map,String userKey) {
    return new User(
      userUID: map['userUID']as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      firstAddress: map['firstAddress'] as String,
      secondAddress: map['secondAddress'] as String,
      userState: map['userState'] as int,
      isAdmin: map['isAdmin'] as bool,
    );
  }
}