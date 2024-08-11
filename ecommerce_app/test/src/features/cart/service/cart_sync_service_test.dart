import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/service/cart_sync_service.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockLocalCartRepository localCartRepository;
  late MockRemoteCartRepository remoteCartRepository;
  late MockProductsRepository productRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
    productRepository = MockProductsRepository();
  });

  CartSyncService makeCartSyncService() {
    final container = ProviderContainer(
      overrides: [
        authenticationRepositoryProvider.overrideWithValue(authRepository),
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
        remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
        productsRepositoryProvider.overrideWithValue(productRepository),
      ],
    );

    addTearDown(container.dispose);

    return container.read(cartSyncServiceProvider);
  }

  group('CartSyncService', () {
    Future<void> runCartSyncServiceTest({
      required Map<ProductID, int> localCartItems,
      required Map<ProductID, int> remoteCartItems,
      required Map<ProductID, int> expectedCartItems,
    }) async {
      const uid = '123';
      const email = 'test@test.com';

      when(authRepository.authStateChanges).thenAnswer((_) => Stream.value(const AppUser(uid: uid, email: email)));
      when(productRepository.fetchProducts).thenAnswer((_) => Future.value(kTestProducts));
      when(localCartRepository.fetchCart).thenAnswer((_) => Future.value(Cart(localCartItems)));
      when(() => remoteCartRepository.fetchCart(uid)).thenAnswer((_) => Future.value(Cart(remoteCartItems)));
      when(() => remoteCartRepository.setCart(uid, Cart(expectedCartItems))).thenAnswer((_) => Future.value());  
      when(() => localCartRepository.setCart(const Cart())).thenAnswer((_) => Future.value());

      makeCartSyncService();
      await Future.delayed(const Duration());

      verify(() => remoteCartRepository.setCart(uid, Cart(expectedCartItems))).called(1);
      verify(() => localCartRepository.setCart(const Cart())).called(1);
    }

    test('cart syncs empty local cart with empty remote cart', () async {
      await runCartSyncServiceTest(
        localCartItems: {},
        remoteCartItems: {},
        expectedCartItems: {},
      );
    });

    test('cart sync with local items only', () async {
      await runCartSyncServiceTest(
        localCartItems: {
          '1': 1,
          '2': 2,
        },
        remoteCartItems: {},
        expectedCartItems: {
          '1': 1,
          '2': 2,
        },
      );
    });

    test('cart sync with remote items only', () async {
      await runCartSyncServiceTest(
        localCartItems: {},
        remoteCartItems: {
          '1': 1,
          '2': 2,
        },
        expectedCartItems: {
          '1': 1,
          '2': 2,
        },
      );
    });

    test('cart sync with local and remote items', () async {
      await runCartSyncServiceTest(
        localCartItems: {
          '1': 1,
          '2': 2,
        },
        remoteCartItems: {
          '1': 1,
          '2': 2,
        },
        expectedCartItems: {
          '1': 2,
          '2': 4,
        },
      );
    });

    test('cart sync with local and remote items exceeding max quantity', () async {
      await runCartSyncServiceTest(
        localCartItems: {
          '1': 3,
          '2': 4,
        },
        remoteCartItems: {
          '1': 2,
          '2': 3,
        },
        expectedCartItems: {
          '1': 5,
          '2': 5,
        },
      );
    });
  });
}
