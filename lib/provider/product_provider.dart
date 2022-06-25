import 'package:flutter/material.dart';
import 'dart:math';
import '../model/product.dart';

// A list of products
final List<Product> initialData = List.generate(
    20,
    (index) =>
        Product(title: "Product ${index + 1}", price: Random().nextInt(100)));

class ProductProvider with ChangeNotifier {
  // All products (that will be displayed on the Home screen)
  final List<Product> _products = initialData;

  // Retrieve all products
  List<Product> get products => _products;

  // Favorite products (that will be shown on the MyList screen)
  final List<Product> _myList = [];

  // Retrieve favorite products
  List<Product> get myList => _myList;

  // Adding a product to the favorites list
  void addToList(Product product) {
    _myList.add(product);

    notifyListeners();
  }

  // Removing a product from the favorites list
  void removeFromList(Product product) {
    _myList.remove(product);
    notifyListeners();
  }
}
