import 'package:ecommerce_app/src/routing/go_router_refresh_stream.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/ui/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_screen.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_type.dart';
import 'package:ecommerce_app/src/features/cart/ui/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/checkout/presentation/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_app/src/features/orders/ui/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/products/ui/product_screen/product_screen.dart';
import 'package:ecommerce_app/src/features/products/ui/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/reviews/ui/leave_review_screen/leave_review_screen.dart';
import 'package:ecommerce_app/src/routing/app_routes.dart';
import 'package:ecommerce_app/src/routing/not_found_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authenticationRepositoryProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,

    // Do not remove this comment - this helps with VS code formatting to retain neccessary line breaks line breaks
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

    redirect: (context, state) {
      final authRepository = ref.read(authenticationRepositoryProvider);
      final isLoggedIn = authRepository.currentUser != null;
      final signInPath = AppRoutes.signIn.fullPath;

      if (isLoggedIn) {
        if (state.uri.path == signInPath) {
          return AppRoutes.home.fullPath;
        }
      } else {
        if (state.uri.path == AppRoutes.account.fullPath || state.uri.path == AppRoutes.orders.fullPath) {
          return AppRoutes.home.fullPath;
        }
      }

      return null;
    },

    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),

    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
