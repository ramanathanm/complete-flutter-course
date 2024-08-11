import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/data/item.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/service/cart_service.dart';

import '../../../mocks.dart';

void main() {
  late AuthenticationRepository authRepository;
  late LocalCartRepository localCartRepository;
  late RemoteCartRepository remoteCartRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
  });

  CartService makeCartservice() {
    final container = ProviderContainer(
      overrides: [
        authenticationRepositoryProvider.overrideWithValue(authRepository),
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
        remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
      ],
    );

    addTearDown(container.dispose);

    return container.read(cartServiceProvider);
  }

  setUpAll(() {
    registerFallbackValue(const Cart());
  });

  group('CartService', () {
    test('''
          Given a user is not logged in
          When addItem is called
          Then the item should be added to local cart
         ''', () async {

      const expectedCart = Cart({'123': 1});
      final cartService = makeCartservice();
      when(() => authRepository.currentUser).thenReturn(null);
      when(localCartRepository.fetchCart).thenAnswer((_) => Future.value(const Cart()));
      when(() => localCartRepository.setCart(expectedCart)).thenAnswer((_) => Future.value());

      await cartService.addItem(const Item(productId: '123', quantity: 1));

      verify(() => localCartRepository.setCart(expectedCart)).called(1);
      verifyNever(() => remoteCartRepository.setCart(any(), any()));
    });

  test('''
          Given a user is logged in
          When addItem is called
          Then the item should be added to remote cart
         ''', () async {

      const item = Item(productId: '123', quantity: 1);
      const expectedCart = Cart({'123': 1});
      const user = AppUser(uid: '123', email: 'test@test.com');

      final cartService = makeCartservice();
      when(() => authRepository.currentUser).thenReturn(user);
      when(() => remoteCartRepository.fetchCart(user.uid)).thenAnswer((_) => Future.value(const Cart()));
      when(() => remoteCartRepository.setCart(user.uid, expectedCart)).thenAnswer((_) => Future.value());

      await cartService.addItem(item);

      verify(() => remoteCartRepository.setCart(user.uid, expectedCart)).called(1);
      verifyNever(() => localCartRepository.setCart(any()));
    });

  });
}
