import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_app/src/features/orders/presentation/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/products/presentation/product_screen/product_screen.dart';
import 'package:ecommerce_app/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import 'package:ecommerce_app/src/routing/app_routes.dart';
import 'package:ecommerce_app/src/routing/not_found_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: AppRoutes.product.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductScreen(productId: productId);
          },
          routes: [
            GoRoute(
              path: 'review',
              name: AppRoutes.leaveReview.name,
              pageBuilder: (context, state) {
                final productId = state.pathParameters['id']!;
                return MaterialPage(
                  fullscreenDialog: true,
                  child: LeaveReviewScreen(productId: productId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'cart',
          name: AppRoutes.cart.name,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: ShoppingCartScreen(),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              name: AppRoutes.checkout.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: CheckoutScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'orders',
          name: AppRoutes.orders.name,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoutes.account.name,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoutes.signIn.name,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
