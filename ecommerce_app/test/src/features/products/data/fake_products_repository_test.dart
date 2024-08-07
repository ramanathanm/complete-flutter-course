import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';

void main() {
  FakeProductsRepository createFakeProductsRepository() {
    return FakeProductsRepository(addDelay: false);
  }

  group('FakeProductsRepository', () {
    test('getProducts: should return the global kTestProducts', () {
      final fakeProductsRepository = createFakeProductsRepository();
      expect(fakeProductsRepository.getProducts(), kTestProducts);
    });

    test('getProductById(1): should return the product with the given id', () {
      final fakeProductsRepository = createFakeProductsRepository();
      final product = fakeProductsRepository.getProductById('1');
      expect(product, kTestProducts[0]);
    });

    test('getProductById(100): should return null', () {
      final fakeProductsRepository = createFakeProductsRepository();
      final product = fakeProductsRepository.getProductById('100');
      expect(product, null);
    });
  });

  test('fetchProducts: should return the global kTestProducts', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final products = await fakeProductsRepository.fetchProducts();
    expect(products, kTestProducts);
  });

  test('fetchProductById(1): should return the product with the given id', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final product = await fakeProductsRepository.fetchProductById('1');
    expect(product, kTestProducts[0]);
  });

  test('fetchProductById(100): should return null', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final product = await fakeProductsRepository.fetchProductById('100');
    expect(product, null);
  });

  test('watchProducts: should return a Stream of the global kTestProducts', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final productsStream = fakeProductsRepository.watchProducts();
    await expectLater(productsStream, emits(kTestProducts));
  });

  test('watchProductById(1): should return a Stream of the product with the given id', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final productStream = fakeProductsRepository.watchProductById('1');
    await expectLater(productStream, emits(kTestProducts[0]));
  });

  test('watchProductById(100): should return a Stream of null', () async {
    final fakeProductsRepository = createFakeProductsRepository();
    final productStream = fakeProductsRepository.watchProductById('100');
    await expectLater(productStream, emits(null));
  });
}
