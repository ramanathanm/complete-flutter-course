import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/src/features/authentication/ui/account/account_screen.dart';

class AuthRobot {
  AuthRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpAccountScreen({FakeAuthenticationRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null) authenticationRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapAppBarLogoutButton() async {
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);

    await tester.tap(logoutButton);
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapLogoutDialogCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);

    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }

  Future<void> tapLogoutDialogLogoutButton() async {
    final logoutDialogLogoutButton = find.byKey(kDialogDefaultKey);
    expect(logoutDialogLogoutButton, findsOneWidget);

    await tester.tap(logoutDialogLogoutButton);
    await tester.pump();
  }

  void expectLogoutDialogError() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsOneWidget);
  }

  void expectLogoutDialogErrorNotFound() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsNothing);
  }

  void expectCircularLoadingIndicator() {
    final circularLoadingIndicator = find.byType(CircularProgressIndicator);
    expect(circularLoadingIndicator, findsOneWidget);
  }


}
