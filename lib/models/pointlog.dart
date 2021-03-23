class PointLog{
  bool usePoint;
  String useTitle;
  String useSubtitle;
  num useAmount;
  DateTime createdAt;

  PointLog({this.createdAt,this.useAmount,this.usePoint,this.useTitle,this.useSubtitle});

  Map<String, dynamic> toMap() {
    return {
      'usePoint': this.usePoint,
      'useTitle': this.useTitle,
      'useSubtitle': this.useSubtitle,
      'useAmount': this.useAmount,
      'createdAt': this.createdAt,
    };
  }

  factory PointLog.fromMap(Map<String, dynamic> map) {
    return new PointLog(
      usePoint: map['usePoint'] as bool,
      useTitle: map['useTitle'] as String,
      useSubtitle: map['useSubtitle'] as String,
      useAmount: map['useAmount'] as num,
      createdAt: map['createdAt'] as DateTime,
    );
  }

}