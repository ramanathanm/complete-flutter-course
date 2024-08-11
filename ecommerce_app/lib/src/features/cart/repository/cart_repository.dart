import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_repository.g.dart';

abstract class LocalCartRepository {
  Future<Cart> fetchCart();

  Stream<Cart> watchCart();

  Future<void> setCart(Cart cart);
}

abstract class RemoteCartRepository {
  Future<Cart> fetchCart(String uid);

  Stream<Cart> watchCart(String uid);

  Future<void> setCart(String uid, Cart cart);
}

@Riverpod(keepAlive: true)
LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  debugPrint('localCartRepository called');

  /// As Sembast initialization is async, returning a FutureProvider would not be ideal.
  /// Hence this is initialized in the main function, that way it is guaranteed to be initialized before the app starts.
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
RemoteCartRepository remoteCartRepository(RemoteCartRepositoryRef ref) {
  return FakeRemoteCartRepository();
}
