import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';

part 'firebase_authentication_repository.g.dart';

class _FirebaseAuthenticationRepository implements AuthenticationRepository {
  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }
  @override
  Future<void> registerWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
  
  @override
  Stream<AppUser?> authStateChanges() {
    // TODO: implement authStateChange
    throw UnimplementedError();
  }
}

@Riverpod(keepAlive: true)
AuthenticationRepository firebaseAuthentication(FirebaseAuthenticationRef ref) {
  return _FirebaseAuthenticationRepository();
}
