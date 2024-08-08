import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/src/app.dart';
import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/ui/home_app_bar/more_menu_button.dart';
import 'package:ecommerce_app/src/features/products/ui/products_list/product_card.dart';

import 'features/authentication/auth_robot.dart';
import 'features/authentication/signin_robot.dart';

class Robot {
  Robot(this.tester)
      : auth = AuthRobot(tester),
        signIn = SignInRobot(tester);

  final WidgetTester tester;
  final AuthRobot auth;
  final SignInRobot signIn;

  Future<void> pumpApp() async {
    final authRepository = FakeAuthenticationRepository(addDelay: false);
    final productsRepository = FakeProductsRepository(addDelay: false);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticationRepositoryProvider.overrideWithValue(authRepository),
          productsRepositoryProvider.overrideWithValue(productsRepository),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();
  }

  Future<void> tapOnAppBarSignInButton() async {
    final moreButton = find.byType(MoreMenuButton);
    if (moreButton.evaluate().isNotEmpty) {
      await tester.tap(moreButton);
      await tester.pump();
    }
    await tester.tap(find.byKey(MoreMenuButton.signInKey));
    await tester.pumpAndSettle();
  }

  void expectHomeScreenLoaded() {
    final productGridItems = find.byType(ProductCard);
    expect(productGridItems, findsNWidgets(kTestProducts.length));
  }
}
