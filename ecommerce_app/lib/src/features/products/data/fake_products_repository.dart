// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/utils/delay.dart';

class FakeProductsRepository extends ProductRepository {

  FakeProductsRepository({this.addDelay = true});

  final List<Product> _products = kTestProducts;
  final bool addDelay;

  @override
  List<Product> getProducts() {
    return _products;
  }

  @override
  Product? getProductById(String id) {
    return _getProductById(_products, id);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    await delay(addDelay);
    return Future.value(_products);
  }

  @override
  Future<Product?> fetchProductById(String id) async {
    await delay(addDelay);
    return Future.value(_getProductById(_products, id));
  }

  @override
  Stream<List<Product>> watchProducts() async* {
    await delay(addDelay);
    yield _products;
  }

  @override
  Stream<Product?> watchProductById(String id) {
    return watchProducts().map((products) => _getProductById(products, id));
  }

  static Product? _getProductById(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
