import 'package:flutter/material.dart';

class Product {
  final String _name;
  final double _price;
  final String _image;
  final String _skinType;
  bool _selected = false;


  Product(this._name, this._price, this._image, this._skinType);

  // getters
  String get name => _name;
  double get price => _price;
  String get image => _image;
  String get skinType => _skinType;
  bool get selected => _selected;
  set selected(bool e) => _selected = e;

  // product description
  @override
  String toString() {
    return '$_name - \$$_price';
  }
}

List<Product> products = [
  // Products for Dry Skin
  Product('Hydrating Moisturizer', 25.99, 'assets/moisturizer.jpeg', 'Dry'),
  Product('SunScreen', 32.50, 'assets/sunscreen.jpeg', 'Dry'),
  Product('Gentle Cleanser', 18.99, 'assets/cleanser.jpeg', 'Dry'),

  // Products for Oily Skin
  Product('Oil-Control Face Wash', 22.99, 'assets/facewash.jpeg', 'Oily'),
  Product('SunScreen', 28.00, 'assets/sunscreeno.jpeg', 'Oily'),
  Product('Pore Minimizer Toner', 19.99, 'assets/toner.jpeg', 'Oily'),

  // Products for Normal Skin
  Product('SunScreen', 24.99, 'assets/sunscreen.jpeg', 'Normal'),
  Product('Refreshing Face Wash', 20.50, 'assets/refreshing.jpeg', 'Normal'),
  Product('Daily Serum', 35.00, 'assets/serum.jpeg', 'Normal'),
];