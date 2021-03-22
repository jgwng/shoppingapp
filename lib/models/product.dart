import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({@required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
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
    );
  }
}