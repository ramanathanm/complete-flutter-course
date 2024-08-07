import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/inmemory_store.dart';

part 'fake_authentication_repository.g.dart';

class FakeAuthenticationRepository implements AuthenticationRepository {
  FakeAuthenticationRepository({
    this.addDelay = true,
  });

  final _authState = InmemoryStore<AppUser?>(null);
  final bool addDelay;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Stream<AppUser?> authStateChanges() {
    return _authState.stream;
  }

  @override
  Future<void> registerWithEmailAndPassword({required String email, required String password}) async {
    return await _createUser(email);
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    return await _createUser(email);
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void dispose() => _authState.close();

  Future<void> _createUser(String email) async {
    await delay(addDelay);

    if (currentUser == null) {
      _authState.value = AppUser(email: email, uid: email.split('').reversed.join());
    }
  }
}

@Riverpod(keepAlive: true)
AuthenticationRepository fakeAuthenticationRepository(FakeAuthenticationRepositoryRef ref) {
  return FakeAuthenticationRepository();
}
