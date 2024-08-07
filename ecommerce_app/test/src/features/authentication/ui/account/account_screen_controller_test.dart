import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/ui/account/account_screen_controller.dart';

import '../../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late ProviderContainer container;

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

  setUp(() {
    authRepository = MockAuthRepository();
    container = createProviderContainer(authRepository);
  });

  group('AccountScreenController', () {
    test('Initial state of AccountScreenController should be AsyncValue.data(null)', () {
      final listener = Listener<AsyncValue<void>>();
      const initialData = AsyncData<void>(null);

      container.listen(
        accountScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      verify(() => listener(null, initialData));

      verifyNoMoreInteractions(listener);
      verifyNever(authRepository.signOut);
    });

    test('signOut should return true when signOut is successful', () async {
      when(authRepository.signOut).thenAnswer((_) async => Future.value());

      final listener = Listener<AsyncValue<void>>();

      container.listen(
        accountScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const initialData = AsyncData<void>(null);
      verify(() => listener(null, initialData));

      final controller = container.read(accountScreenControllerProvider.notifier);
      final result = await controller.signOut();

      verifyInOrder([
        () => listener(initialData, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), initialData),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => authRepository.signOut()).called(1);

      expect(result, true);
    });

    test('signOut should return false when signOut is unsuccessful', () async {
      final exception = Exception('Connection failed');
      when(authRepository.signOut).thenThrow(exception);

      final listener = Listener<AsyncValue<void>>();

      container.listen(
        accountScreenControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      const initialState = AsyncData<void>(null);
      verify(() => listener(null, initialState));

      final controller = container.read(accountScreenControllerProvider.notifier);
      final result = await controller.signOut();

      verifyInOrder([
        () => listener(initialState, any(that: isA<AsyncLoading>())),
        () => listener(any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => authRepository.signOut()).called(1);

      expect(result, false);
    });
  });
}
