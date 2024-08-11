import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/inmemory_store.dart';

class FakeLocalCartRepository extends LocalCartRepository {
  FakeLocalCartRepository({this.addDelay = true});

  final _cart = InmemoryStore(const Cart());
  final bool addDelay;

  @override
  Future<Cart> fetchCart() async {
    if (addDelay) await delay(addDelay);
    return _cart.value;
  }

  @override
  Stream<Cart> watchCart() async* {
    yield _cart.value;
  }

  @override
  Future<void> setCart(Cart cart) async {
    if (addDelay) await delay(addDelay);
    _cart.value = cart;
  }
}
