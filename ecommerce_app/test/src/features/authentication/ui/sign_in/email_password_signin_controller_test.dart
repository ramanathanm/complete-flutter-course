// ignore: library_annotations
@Timeout(Duration(milliseconds: 500))

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_controller.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_type.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer createProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authenticationRepositoryProvider.overrideWithValue(authRepository),
      ],
    );

    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });

  group('EmailPasswordSignInController: submit', () {
    test('submit with formType is signIn, should be successful', () async {
      final authRepository = MockAuthRepository();
      final container = createProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();

      const formType = EmailPasswordSignInFormType.signIn;
      const email = "test@test.com";
      const password = "1234";
      const initalState = AsyncData<void>(null);

      when(() => authRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => Future.value());

      container.listen(emailPasswordSignInControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, initalState));

      final controller = container.read(emailPasswordSignInControllerProvider.notifier);
      bool result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );

      expect(result, true);
      verifyInOrder([
        () => listener(initalState, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncData>())),
      ]);

      verify(() => authRepository.signInWithEmailAndPassword(email: email, password: password)).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('submit with signIn formType, should return false when signInWithEmailAndPassword fails', () async {
      final authRepository = MockAuthRepository();
      final container = createProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();

      const formType = EmailPasswordSignInFormType.signIn;
      const email = "test@test.com";
      const password = "1234";
      const initialData = AsyncData<void>(null);

      when(() => authRepository.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(Exception('Connection failed'));

      container.listen(emailPasswordSignInControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, initialData));

      final controller = container.read(emailPasswordSignInControllerProvider.notifier);
      bool result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );

      expect(result, false);
      verifyInOrder([
        () => listener(initialData, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verify(
        () => authRepository.signInWithEmailAndPassword(email: email, password: password),
      ).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('submit with formType register should return true', () async {
      final authRepository = MockAuthRepository();
      final container = createProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();

      const formType = EmailPasswordSignInFormType.register;
      const email = 'test@test.com';
      const password = '1234';
      const initialData = AsyncData<void>(null);

      when(() => authRepository.registerWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) async => Future.value());

      container.listen(emailPasswordSignInControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, initialData));

      final controller = container.read(emailPasswordSignInControllerProvider.notifier);
      bool result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );

      expect(result, true);
      verifyInOrder([
        () => listener(initialData, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncData>())),
      ]);
      verify(() => authRepository.registerWithEmailAndPassword(email: email, password: password)).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('submit with register formType, should return false when registerWithEmailAndPassword fails', () async {
      final authRepository = MockAuthRepository();
      final container = createProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();

      const formType = EmailPasswordSignInFormType.register;
      const email = 'test@test.com';
      const password = '1234';
      const initialData = AsyncData<void>(null);

      when(() => authRepository.registerWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(Exception('Connection failed'));

      container.listen(emailPasswordSignInControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, initialData));

      final controller = container.read(emailPasswordSignInControllerProvider.notifier);
      bool result = await controller.submit(
        email: email,
        password: password,
        formType: formType,
      );

      expect(result, false);
      verifyInOrder([
        () => listener(initialData, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => authRepository.registerWithEmailAndPassword(email: email, password: password)).called(1);
    });

    group('EmailPasswordSignInController: toggleFormType', () {
      test('toggleFormType should return true when formType is signIn', () async {});
    });
  });
}
