import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
  });
}
