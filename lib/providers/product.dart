import 'package:flutter/material.dart';
import 'package:flutter_shop/models/htpp_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavorite() async {
    final url =
        'https://flutter-shop-7763b-default-rtdb.firebaseio.com/products/$id.json';

    final oldIsFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({'isFavorite': isFavorite}));

      if (response.statusCode >= 400) {
        throw HttpException('Could not update product.');
      }
    } catch (error) {
      isFavorite = oldIsFavorite;
      notifyListeners();
      rethrow;
    }
  }
}
