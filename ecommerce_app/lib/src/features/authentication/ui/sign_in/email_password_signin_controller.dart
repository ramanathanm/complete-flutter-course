import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_type.dart';

part 'email_password_signin_controller.g.dart';

@riverpod
class EmailPasswordSignInController extends _$EmailPasswordSignInController {
  @override
  FutureOr<void> build() {}

  Future<bool> submit({required email, required password, required EmailPasswordSignInFormType formType}) async {
    state = const AsyncLoading();
    if (formType == EmailPasswordSignInFormType.signIn) {
      return _authenticate(username: email, password: password, formType: formType);
    } else {
      return _register(username: email, password: password, formType: formType);
    }
  }

  Future<bool> _authenticate(
      {required String username, required String password, required EmailPasswordSignInFormType formType}) async {
    final authenticationRepository = ref.read(authenticationRepositoryProvider);
    state = await AsyncValue.guard(
      () => authenticationRepository.signInWithEmailAndPassword(
        email: username,
        password: password,
      ),
    );
    return state.hasError == false;
  }

  Future<bool> _register(
      {required String username, required String password, required EmailPasswordSignInFormType formType}) async {
    final authenticationRepository = ref.read(authenticationRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => authenticationRepository.registerWithEmailAndPassword(
        email: username,
        password: password,
      ),
    );
    return state.hasError == false;
  }
}
