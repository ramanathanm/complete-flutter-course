import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';

class MockProductRepository {
  MockProductRepository._();

  static final MockProductRepository instance = MockProductRepository._();
  final List<Product> _product = kTestProducts;

  List<Product> getProducts() {
    return _product;
  }

  Product? getProductById(String id) {
    return _product.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProducts() async {
    return Future.value(_product);
  }

  Future<Product?> fetchProductById(String id) async {
    Product? product = _product.firstWhere((product) => product.id == id);
    return Future.value(product);
  }

  Stream<List<Product>> watchProducts() {
    return Stream.value(_product);
  }

  Stream<Product?> watchProductById(String id) {
    return watchProducts().map((products) => products.firstWhere((product) => product.id == id));
  }
}
