import 'dart:math';

import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/cart/data/item.dart';
import 'package:ecommerce_app/src/features/cart/data/mutable_cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';

part 'cart_sync_service.g.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }

  final Ref ref;

  void _init() {

    debugPrint('CartSyncService _init: registering authStateChanges listener');
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider, (previous, current) {
      debugPrint('CartSyncService authStateChangesProvider listener called');
      final previousUser = previous?.value;

      if (previousUser == null && current.value != null) {
        // Sync cart with the server
        _syncCartWithServer(current.value!);
      }
    });
  }

  Future<void> _syncCartWithServer(final AppUser user) async {
    final localCartRepository = ref.read(localCartRepositoryProvider);
    final remoteCartRepository = ref.read(remoteCartRepositoryProvider);

    final localCart = await localCartRepository.fetchCart();
    var remoteCart = await remoteCartRepository.fetchCart(user.uid);

    localCart.items.forEach((localProductId, localQuantity) {
      final remoteQuantity = remoteCart.items[localProductId] ?? 0;
      final newQuantity = min(localQuantity + remoteQuantity, 5);

      final updatedItem = Item(productId: localProductId, quantity: newQuantity);
      remoteCart = remoteCart.setItem(updatedItem);
    });

    await remoteCartRepository.setCart(user.uid, remoteCart);
    await localCartRepository.setCart(const Cart());
  }
}

@Riverpod(keepAlive: true)
CartSyncService cartSyncService(final CartSyncServiceRef ref) {
  return CartSyncService(ref);
}