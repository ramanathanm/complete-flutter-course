import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';

void main() {
  const email = 'test@test.com';
  const password = '1234';
  final uuid = email.split('').reversed.join();

  final user = AppUser(uid: uuid, email: email);

  AuthenticationRepository createFakeAuthenticationRepository() {
    return FakeAuthenticationRepository(addDelay: false);
  }

  group('FakeAuthenticationRepository', () {
    test('currentUser should be null before login', () {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      expect(authRepository.currentUser, isNull);
    });

    test('authStateChanges should return null before login', () {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('signInWithEmailAndPassword should login user & return test@test.com', () async {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      await authRepository.signInWithEmailAndPassword(email: email, password: password);
      expect(authRepository.currentUser, user);
      expect(authRepository.authStateChanges(), emits(user));
    });

    test('registerWithEmailAndPassword should create user & return test@test.com', () async {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      await authRepository.registerWithEmailAndPassword(email: email, password: password);
      expect(authRepository.currentUser, user);
      expect(authRepository.authStateChanges(), emits(user));
    });

    test('signOut should nullify the currentUser', () async {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      await authRepository.signInWithEmailAndPassword(email: email, password: password);
      expect(authRepository.currentUser, user);
      expect(authRepository.authStateChanges(), emits(user));

      await authRepository.signOut();
      expect(authRepository.currentUser, isNull);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('SingIn after provider id disposed, should throw exception', () async {
      AuthenticationRepository authRepository = createFakeAuthenticationRepository();
      authRepository.dispose();
      expect(
        () => authRepository.signInWithEmailAndPassword(email: email, password: password),
        throwsStateError,
      );
    });
  });
}
