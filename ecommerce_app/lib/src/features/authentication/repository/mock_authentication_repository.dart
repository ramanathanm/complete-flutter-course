import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/utils/inmemory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_authentication_repository.g.dart';

class _MockAuthenticationRepository implements AuthenticationRepository {

  final _authState = InmemoryStore<AppUser?>(null);

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Stream<AppUser?> authStateChanges() {
    return _authState.stream;
  }

  @override
  Future<void> registerWithEmailAndPassword({required String email, required String password}) async {
    _createUser(email);
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    _createUser(email);
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void dispose() => _authState.close();

  void _createUser(String email) {
    if (currentUser == null) {
      _authState.value = AppUser(email: email, uid: email.split('').reversed.join());
    }
  }
}

@Riverpod(keepAlive: true)
AuthenticationRepository mockAuthenticationRepository(MockAuthenticationRepositoryRef ref) {
  return _MockAuthenticationRepository();
}
