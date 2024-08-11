import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException()
      : super('email-already-in-use', 'Email already in use'.hardcoded);
}

class WeakPasswordException extends AppException {
  WeakPasswordException()
      : super('weak-password', 'Password is too weak'.hardcoded);
}

class WrongPasswordException extends AppException {
  WrongPasswordException()
      : super('wrong-password', 'Wrong password'.hardcoded);
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found'.hardcoded);
}