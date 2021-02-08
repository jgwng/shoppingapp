class Notice{
  String noticeKey;
  String title;
  String content;
  DateTime createdAt;
  bool isRead;

  Notice({this.noticeKey, this.title, this.content, this.createdAt,this.isRead});

  Map<String, dynamic> toJson() {
    return {

      'noticeKey': this.noticeKey,
      'title': this.title,
      'content': this.content,
      'createdAt': this.createdAt,
      'isRead': this.isRead,

    };
  }

  factory Notice.fromJson(Map<String, dynamic> map,String noticeKey) {
    return new Notice(
      noticeKey: map['noticeKey']as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as DateTime,
      isRead: map['isRead'] as bool,

    );
  }









}