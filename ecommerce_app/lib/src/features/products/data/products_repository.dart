import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

abstract class ProductRepository {
  List<Product> getProducts();

  Product? getProductById(String id);

  Future<List<Product>> fetchProducts();

  Future<Product?> fetchProductById(String id);

  Stream<List<Product>> watchProducts();

  Stream<Product?> watchProductById(String id);
}

@riverpod
ProductRepository productsRepository(ProductsRepositoryRef ref) {
  return FakeProductsRepository();
}

@riverpod
Future<List<Product>> productsFutureRepository(ProductsFutureRepositoryRef ref) async {
  final productRepository = ref.read(productsRepositoryProvider);
  return await productRepository.fetchProducts();
}

@riverpod
Future<Product?> productFutureRepository(ProductFutureRepositoryRef ref, String id) async {
  final productsRepository = ref.watch(productsFutureRepositoryProvider);
  return productsRepository.value!.firstWhere((product) => product.id == id);
}

@riverpod
Stream<List<Product>> productStream(ProductStreamRef ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProducts();
}