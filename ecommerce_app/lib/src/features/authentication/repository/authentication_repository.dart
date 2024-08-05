import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';

abstract class AuthenticationRepository {
  AppUser? get currentUser;

  Stream<AppUser?> authStateChanges();

  Future<void> signInWithEmailAndPassword({ required String email, required String password });

  Future<void> registerWithEmailAndPassword({ required String email, required String password });

  Future<void> signOut();

  void dispose() {}
}