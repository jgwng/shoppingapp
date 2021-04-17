import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  bool isFavorite;

  Product({this.id = 'aaaa',
     this.title = '제품 이름이 들어갈 공간입니다.',
     this.description = 'aaaa',
     this.price = 50000,
     this.imageUrl,
    this.category ='',
    this.isFavorite = false});


  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl,
      'isFavorite': this.isFavorite,
      'category' : this.category
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return new Product(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      isFavorite: map['isFavorite'] as bool,
      category: map['category'] as String
    );
  }
}