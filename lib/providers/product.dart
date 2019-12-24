import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavorite(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token) async {
    final url = 'https://shop-app-3d66f.firebaseio.com/products/$id.json?auth=$token';
    final oldStatus = isFavorite;

    _setFavorite(!isFavorite);    

    final response = await http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );

    if (response.statusCode >= 400) {
      _setFavorite(oldStatus);    
    }
  }
}
