import 'package:ecommerce_app/src/features/cart/ui/shopping_cart/shopping_cart_screen_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/service/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/ui/shopping_cart/shopping_cart_item.dart';
import 'package:ecommerce_app/src/features/cart/ui/shopping_cart/shopping_cart_items_builder.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/routing/app_routes.dart';

/// Shopping cart screen showing the items in the cart (with editable
/// quantities) and a button to checkout.
class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: Consumer(builder: (_, ref, __) {
        final cartItems = ref.watch(cartProvider);
        final shoppingCartController = ref.watch(shoppingCartScreenControllerProvider);
        
        return AsyncValueWidget<Cart>(
          value: cartItems,
          data: (cart) {
            return ShoppingCartItemsBuilder(
              items: cart.toItemsList(),
              itemBuilder: (_, item, index) => ShoppingCartItem(
                item: item,
                itemIndex: index,
              ),
              ctaBuilder: (_) => PrimaryButton(
                isLoading: shoppingCartController.isLoading,
                text: 'Checkout'.hardcoded,
                onPressed: () => context.goNamed(AppRoutes.checkout.name),
              ),
            );
          },
        );
      }),
    );
  }
}
