import 'package:flutter/foundation.dart';

class ProductModelProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModelProvider({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  factory ProductModelProvider.fromJson(Map<String, dynamic> json) {
    return ProductModelProvider(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  void changeFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
