import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ecommerce_app/src/features/authentication/repository/fake_authentication_repository.dart';

class MockAuthRepository extends Mock implements FakeAuthenticationRepository {}
class MockProductRepository extends Mock implements FakeProductsRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
