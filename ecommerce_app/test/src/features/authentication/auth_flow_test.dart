import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  const email = 'test@test.com';
  const password = 'password';

  group('Auth Flow', () {
    testWidgets('Email SignIn screen loads successfully', (tester) async {
      final r = Robot(tester);

      await r.pumpApp();

      await r.tapOnAppBarSignInButton();
      await r.signIn.enterEmail(email);
      await r.signIn.enterPassword(password);
      await r.signIn.tapOnSignInButton();
    });

    testWidgets('Email SignIn e2e success', (tester) async {
      final r = Robot(tester);

      await r.pumpApp();

      await r.tapOnAppBarSignInButton();
      await r.signIn.enterEmail(email);
      await r.signIn.enterPassword(password);
      await r.signIn.tapOnSignInButton();
      r.signIn.expectNoValidationErrors();
      // r.signIn.expectNoSignButtonInAppbar();

      r.expectHomeScreenLoaded();
    });
  });
}
