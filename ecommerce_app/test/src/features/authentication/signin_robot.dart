import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_screen.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class SignInRobot {
  SignInRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpEmailPasswordSignInScreen({
    required AuthenticationRepository authRepository,
    VoidCallback? onSignIn,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticationRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: EmailPasswordSignInFormType.signIn,
              onSignedIn: onSignIn,
            ),
          ),
        ),
      ),
    );
  }

  void expectEmailPasswordFields() {
    expect(find.byKey(EmailPasswordSignInScreen.emailKey), findsOneWidget);
    expect(find.byKey(EmailPasswordSignInScreen.passwordKey), findsOneWidget);
  }

  Future<void> tapOnSignInButton() async {
    final submitButton = find.byType(PrimaryButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();
  }

  void expectEmptyValidationErrors() {
    expect(find.text('Email can\'t be empty'), findsOneWidget);
    expect(find.text('Password can\'t be empty'), findsOneWidget);
  }

  void expectNoValidationErrors() {
    expect(find.text('Email can\'t be empty'), findsNothing);
    expect(find.text('Email can\'t be empty'), findsNothing);
  }

  Future<void> enterEmail(email) async {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    await tester.enterText(emailField, email);
  }

  void expectInvalidEmailError() {
    expect(find.text('Invalid email'), findsOneWidget);
  }

  Future<void> enterPassword(password) async {
    final passwordField = find.byKey(EmailPasswordSignInScreen.passwordKey);
    await tester.enterText(passwordField, password);
  }

  void expectInvalidPasswordError() {
    expect(find.text('Password is too short'), findsOneWidget);
  }
}
