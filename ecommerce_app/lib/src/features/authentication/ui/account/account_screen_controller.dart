import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/repository/authentication_provider.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {
    state = const AsyncData(null);
  }

  Future<bool> signOut() async {
    final authRepository = ref.read(authenticationRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
    return state.hasError == false;
  }
}
