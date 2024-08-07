import 'package:mocktail/mocktail.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';

class MockAuthRepository extends Mock implements FakeAuthenticationRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
