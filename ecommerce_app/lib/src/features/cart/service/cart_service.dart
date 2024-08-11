import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/data/item.dart';
import 'package:ecommerce_app/src/features/cart/data/mutable_cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/ui/cart_total/cart_total_text.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_service.g.dart';

class CartService {
  CartService({required this.authRepository, required this.localCartRepository, required this.remoteCartRepository});

  final AuthenticationRepository authRepository;
  final LocalCartRepository localCartRepository;
  final RemoteCartRepository remoteCartRepository;

  Future<Cart> _fetchCart() async {
    if (!_userLoggedIn()) {
      return localCartRepository.fetchCart();
    } else {
      return remoteCartRepository.fetchCart(authRepository.currentUser!.uid);
    }
  }

  Future<void> _setCart(Cart cart) async {
    if (!_userLoggedIn()) {
      return localCartRepository.setCart(cart);
    } else {
      return remoteCartRepository.setCart(authRepository.currentUser!.uid, cart);
    }
  }

  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.addItem(item);
    await _setCart(updatedCart);
  }

  Future<void> removeItemById(ProductID id) async {
    final cart = await _fetchCart();
    final updatedCart = cart.removeItemById(id);
    await _setCart(updatedCart);
  }

  bool _userLoggedIn() {
    return authRepository.currentUser != null;
  }

  Future<Cart> setItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.setItem(item);
    await _setCart(updatedCart);
    return updatedCart;
  }
}

@Riverpod(keepAlive: true)
CartService cartService(CartServiceRef ref) {
  return CartService(
    authRepository: ref.read(authenticationRepositoryProvider),
    localCartRepository: ref.read(localCartRepositoryProvider),
    remoteCartRepository: ref.read(remoteCartRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
Stream<Cart> cart(CartRef ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
  } else {
    return ref.watch(localCartRepositoryProvider).watchCart();
  }
}

@Riverpod(keepAlive: true)
int itemAvailableQuantity(ItemAvailableQuantityRef ref, Product product) {
  final cart = ref.watch(cartProvider).value;

  if (cart != null) {
    // get the current quantity for the given product in the cart
    final quantity = cart.items[product.id] ?? 0;
    // subtract it from the product available quantity
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
}

@Riverpod(keepAlive: true)
int cartItemsCount(CartItemsCountRef ref) {
  return ref.watch(cartProvider).maybeMap(
        data: (cart) => cart.value.items.length,
        orElse: () => 0,
      );
}

@riverpod
double cartTotal(CartTotalRef ref) {
  final cart = ref.watch(cartProvider).value ?? const Cart();
  final productsList = ref.watch(productStreamProvider).value ?? [];

  if (cart.items.isNotEmpty && productsList.isNotEmpty) {
    var total = 0.0;
    for (final item in cart.items.entries) {
      final product =
          productsList.firstWhere((product) => product.id == item.key);
      total += product.price * item.value;
    }
    return total;
  } else {
    return 0.0;
  }
}
