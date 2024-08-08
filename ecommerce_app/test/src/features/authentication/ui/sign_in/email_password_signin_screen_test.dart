import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../signin_robot.dart';

void main() {
  const email = 'test@test.com';
  const password = 'password';

  group('EmailPasswordSignInScreen', () {
    testWidgets('Email SignIn screen loads successfully', (tester) async {
      SignInRobot r = SignInRobot(tester);
      final authRepository = MockAuthRepository();

      await r.pumpEmailPasswordSignInScreen(authRepository: authRepository);
      r.expectEmailPasswordFields();
    });

    testWidgets('Clicking on Submit should show validation errors', (tester) async {
      SignInRobot r = SignInRobot(tester);
      final authRepository = MockAuthRepository();

      await r.pumpEmailPasswordSignInScreen(authRepository: authRepository);
      r.expectEmailPasswordFields();

      await r.tapOnSignInButton();
      r.expectEmptyValidationErrors();

      await r.enterEmail('test');
      await r.tapOnSignInButton();
      r.expectInvalidEmailError();

      await r.enterPassword('123');
      await r.tapOnSignInButton();
      r.expectInvalidPasswordError();
    });

    testWidgets('Clicking on Submit with valid inputs should be successful', (tester) async {
      SignInRobot r = SignInRobot(tester);
      final authRepository = MockAuthRepository();
      var onSignInCalled = false;

      when(() => authRepository.signInWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) => Future.value());

      await r.pumpEmailPasswordSignInScreen(
        authRepository: authRepository,
        onSignIn: () => onSignInCalled = true,
      );
      r.expectEmailPasswordFields();

      await r.enterEmail(email);
      await r.enterPassword(password);
      await r.tapOnSignInButton();
      r.expectNoValidationErrors();

      expect(onSignInCalled, true);
      // expect to navigate to the next screen
    });
  });
}
