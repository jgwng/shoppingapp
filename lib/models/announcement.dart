class Announcement{
 String title;
 String content;
 DateTime createdAt;

 Announcement({this.createdAt,this.content,this.title});



 Map<String, dynamic> toMap() {
   return {
     'title': this.title,
     'content': this.content,
     'createdAt': this.createdAt,
   };
 }

 factory Announcement.fromJson(Map<String, dynamic> map) {
   return new Announcement(
     title: map['title'] as String,
     content: map['content'] as String,
     createdAt: map['createdAt'] as DateTime,
   );
 }

}