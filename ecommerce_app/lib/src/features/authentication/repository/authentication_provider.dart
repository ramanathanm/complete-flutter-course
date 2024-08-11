import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/repository/firebase_authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';
import 'package:ecommerce_app/src/utils/app_context.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(AuthenticationRepositoryRef ref) {
  final fakeAuthRepository = ref.watch(fakeAuthenticationRepositoryProvider);
  final firebaseAuthRepository = ref.watch(firebaseAuthenticationProvider);

  final authRepository = AppContext.isMocked() ? fakeAuthRepository : firebaseAuthRepository;

  ref.onDispose(() => authRepository.dispose());

  return authRepository;
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  debugPrint('authStateChangesProvider created');
  final authRepository = ref.watch(authenticationRepositoryProvider);
  return authRepository.authStateChanges().map((user) {
    debugPrint('authStateChangesProvider emitted: $user');
    return user;
  });
}
