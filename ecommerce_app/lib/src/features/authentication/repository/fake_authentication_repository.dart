import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ecommerce_app/src/exception/app_exceptions.dart';
import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:ecommerce_app/src/features/authentication/model/fake_app_user.dart';
import 'package:ecommerce_app/src/features/authentication/repository/authentication_repository.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/inmemory_store.dart';

part 'fake_authentication_repository.g.dart';

class FakeAuthenticationRepository implements AuthenticationRepository {
  FakeAuthenticationRepository({ this.addDelay = true });

  final _authState = InmemoryStore<AppUser?>(null);
  final bool addDelay;
    // List to keep track of all user accounts
  final List<FakeAppUser> _users = [];

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  Future<void> registerWithEmailAndPassword({required String email, required String password}) async {
    await delay(addDelay);
    // check if the email is already in use
    for (final u in _users) {
      if (u.email == email) {
        throw EmailAlreadyInUseException();
      }
    }
    // minimum password length requirement
    if (password.length < 8) {
      throw WeakPasswordException();
    }
    // create new user
    _createNewUser(email, password);
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    await delay(addDelay);
    for (final u in _users) {
      // matching email and password
      if (u.email == email && u.password == password) {
        _authState.value = FakeAppUser.toAppUser(u);
        return;
      }
      // same email, wrong password
      if (u.email == email && u.password != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  @override
  void dispose() => _authState.close();

  void _createNewUser(String email, String password) {
    // create new user
    final user = FakeAppUser(
      uid: email.split('').reversed.join(),
      email: email,
      password: password,
    );
    // register it
    _users.add(user);
    // update the auth state
    _authState.value = FakeAppUser.toAppUser(user);
  }

}

@Riverpod(keepAlive: true)
AuthenticationRepository fakeAuthenticationRepository(FakeAuthenticationRepositoryRef ref) {
  debugPrint("fakeAuthenticationRepositoryProvider created");
  return FakeAuthenticationRepository();
}
