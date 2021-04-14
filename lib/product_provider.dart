import 'package:flutter/material.dart';
import './Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 300,
    //   imageUrl:
    //       'https://i.pinimg.com/originals/4a/ec/ab/4aecaba5f9ff69c67aa953d1663f819e.jpg',
    //   // isFavorite: false,
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 500,
    //   imageUrl:
    //       'https://www.garphyttan.eu/4049-large_default/garphyttan-original-trouser-brown.jpg',
    //   // isFavorite: false
    // ),
  ];

  String authToken;
  ProductProvider(this.authToken, this._items);

  // var _showFavorites = false;
  // List<Product> get items {
  //   if (_showFavorites) {
  //     return _items.where((element) => element.isFavorite).toList();
  //   }
  //   return [..._items];
  // }

  // List<Product> get favoriteItems {
  //   return _items.where((element) => element.isFavorite).toList();
  // }

  // void showFavorites() {
  //   _showFavorites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavorites = false;
  //   notifyListeners();
  // }

  // Product findById(String id) {
  //   return items.firstWhere((element) => element.id == id);
  // }

  // Future<void> fetchProducts() async {
  //   final url =
  //       'https://flutter-update-31100-default-rtdb.firebaseio.com/products.json?auth=$authToken';
  //   try {
  //     final response = await http.get(url);
  //     print(json.decode(response.body));
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<Product> loadedProducts = [];
  //     extractedData.forEach((prodId, prodData) {
  //       loadedProducts.add(Product(
  //         id: prodId,
  //         title: prodData['title'],
  //         description: prodData['description'],
  //         price: prodData['price'],
  //         isFavorite: prodData['isFavorite'],
  //         imageUrl: prodData['imageUrl'],
  //       ));
  //       _items = loadedProducts;
  //       notifyListeners();
  //     });
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  Future<void> addProduct(Product details) async {
    final url =
        'https://car-park-c0947-default-rtdb.firebaseio.com/products.json?';
    return http
        .post(
      url,
      body: json.encode({
        'Name': details.title,
        'Address': details.description,
        'Phone': details.price,
      }),
    )
        .then((response) {
      final newProduct = Product(
        title: details.title,
        description: details.description,
        price: details.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
    }).catchError((error) {
      throw error;
    });
  }

  // Future<void> updateProduct(String id, Product newProduct) async {
  //   final prodIndex = _items.indexWhere((element) => element.id == id);
  //   if (prodIndex >= 0) {
  //     final url =
  //         'https://flutter-update-31100-default-rtdb.firebaseio.com/products/$id.json? auth=$authToken';
  //     await http.patch(url,
  //         body: json.encode({
  //           'title': newProduct.title,
  //           'description': newProduct.description,
  //           'imageUrl': newProduct.imageUrl,
  //           'price': newProduct.price,
  //         }));
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {}
  // }

  // void deleteProduct(String id) {
  //   final url =
  //       'https://flutter-update-31100-default-rtdb.firebaseio.com/products/$id.json? auth=$authToken';
  //   http.delete(url);
  //   _items.removeWhere((element) => element.id == id);
  //   notifyListeners();
  // }
}
