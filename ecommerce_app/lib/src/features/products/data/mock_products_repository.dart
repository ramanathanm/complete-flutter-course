import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';


class MockProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProducts() {
    return _products;
  }

  Product? getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProducts() {
    return Future.value(_products);
  }

  Future<Product?> fetchProductById(String id) {
    return Future.value(_products.firstWhere((product) => product.id == id));
  }
}

