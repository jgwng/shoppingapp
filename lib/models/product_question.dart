class ProductQuestion{
  DateTime createdAt;
  bool isAnswered;
  String category;
  String question;
  String answer;
  bool isSelected;
  ProductQuestion({this.createdAt,this.isAnswered,this.category,this.question,this.answer,this.isSelected});

  Map<String, dynamic> toMap() {
    return {
      'createdAt': this.createdAt,
      'isAnswered': this.isAnswered,
      'category': this.category,
      'question': this.question,
      'answer': this.answer,
      'isSelected': this.isSelected,
    };
  }

  factory ProductQuestion.fromMap(Map<String, dynamic> map) {
    return new ProductQuestion(
      createdAt: map['createdAt'] as DateTime,
      isAnswered: map['isAnswered'] as bool,
      category: map['category'] as String,
      question: map['question'] as String,
      answer: map['answer'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

}