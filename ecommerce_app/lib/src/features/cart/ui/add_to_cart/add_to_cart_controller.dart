import 'package:riverpod_annotation/riverpod_annotation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/src/features/cart/data/item.dart';
import 'package:ecommerce_app/src/features/cart/service/cart_service.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';

part 'add_to_cart_controller.g.dart';

@riverpod
class AddToCartController extends _$AddToCartController {
  @override
  FutureOr<void> build() {}

  Future<void> addItem(ProductID productId) async {
    final cartService = ref.read(cartServiceProvider);
    final quantity = ref.read(itemQuantityControllerProvider);

    final cartItem = Item(productId: productId, quantity: quantity);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.addItem(cartItem));
    if (!state.hasError) {
      ref.read(itemQuantityControllerProvider.notifier).updateQuantity(quantity);
    }
  }
}

@riverpod
class ItemQuantityController extends _$ItemQuantityController {
  @override
  int build() {
    return 1;
  }

  void updateQuantity(int quantity) {
    state = quantity;
  }
}