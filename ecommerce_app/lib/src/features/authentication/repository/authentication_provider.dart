import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/repository/firebase_authentication_repository.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';
import 'package:ecommerce_app/src/utils/app_context.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(AuthenticationRepositoryRef ref) {
  final authenticationRepository = AppContext.isMocked()
      ? ref.watch(fakeAuthenticationRepositoryProvider)
      : ref.watch(firebaseAuthenticationProvider);

  ref.onDispose(() => authenticationRepository.dispose());

  return authenticationRepository;
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authenticationRepository = ref.watch(authenticationRepositoryProvider);
  return authenticationRepository.authStateChanges();
}
