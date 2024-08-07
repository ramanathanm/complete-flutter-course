
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

@riverpod
FakeProductsRepository productsRepository(ProductsRepositoryRef ref) {
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
