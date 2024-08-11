import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/cart/data/item.dart';
import 'package:ecommerce_app/src/features/cart/service/cart_service.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';

part 'shopping_cart_screen_controller.g.dart';

@riverpod
class ShoppingCartScreenController extends _$ShoppingCartScreenController {
  @override
  FutureOr<void> build() {}

  Future<void> updateItemQuantity({required ProductID productId, required int quantity}) async {
    final cartService = ref.read(cartServiceProvider);
    state = const AsyncLoading();
    final item = Item(productId: productId, quantity: quantity);
    state = await AsyncValue.guard(() => cartService.setItem(item));
  }

  Future<void> removeItemById({required ProductID productId}) async {
    final cartService = ref.read(cartServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.removeItemById(productId));
  }
}
