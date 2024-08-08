import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel Logout dialog', (tester) async {
    AuthRobot r = AuthRobot(tester);

    await r.pumpAccountScreen();

    await r.tapAppBarLogoutButton();
    r.expectLogoutDialogFound();

    await r.tapLogoutDialogCancelButton();
    r.expectLogoutDialogNotFound();
  });

  testWidgets('Logout success', (tester) async {
    AuthRobot r = AuthRobot(tester);

    await r.pumpAccountScreen();

    await tester.runAsync(() async {
      await r.tapAppBarLogoutButton();
      await r.tapLogoutDialogLogoutButton();
    });

    r.expectLogoutDialogNotFound();
  });

  testWidgets('Logout failure', (tester) async {
    AuthRobot r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    final exception = Exception('Connection failed');
    const user = AppUser(uid: "123", email: "test@test.com");

    when(authRepository.signOut).thenThrow(exception);
    when(authRepository.authStateChanges).thenAnswer((_) => Stream.value(user));

    await r.pumpAccountScreen(authRepository: authRepository);
    await r.tapAppBarLogoutButton();
    r.expectLogoutDialogFound();

    await r.tapLogoutDialogLogoutButton();
    r.expectLogoutDialogError();
  });

  testWidgets('Logout loading state is shown', (tester) async {
    AuthRobot r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    const user = AppUser(uid: "123", email: "test@test.com");

    when(authRepository.signOut).thenAnswer(
      (_) async => Future.delayed(const Duration(seconds: 1)),
    );

    when(authRepository.authStateChanges).thenAnswer((_) => Stream.value(user));

    await r.pumpAccountScreen(authRepository: authRepository);
    await tester.runAsync(() async {
      await r.tapAppBarLogoutButton();
      r.expectLogoutDialogFound();
      await r.tapLogoutDialogLogoutButton();
    });

    r.expectCircularLoadingIndicator();
  });
}
