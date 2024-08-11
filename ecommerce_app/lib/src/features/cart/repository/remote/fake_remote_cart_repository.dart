// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';
import 'package:ecommerce_app/src/features/products/data/product.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/inmemory_store.dart';

class FakeRemoteCartRepository extends RemoteCartRepository {
  FakeRemoteCartRepository({this.addDelay = true});

  final bool addDelay;
  final _carts = InmemoryStore<Map<String, Cart>>({});

  @override
  Future<Cart> fetchCart(String uid) async {
    if (addDelay) await delay(addDelay);

    return Future.value(_carts.value[uid] ?? const Cart());
  }

  @override
  Future<void> setCart(String uid, Cart cart) async {
    if (addDelay) delay(addDelay);

    final carts = _carts.value;
    carts[uid] = cart;
    _carts.value = carts;
  }

  @override
  Stream<Cart> watchCart(String uid) {
    return _carts.stream.map((carts) => carts[uid] ?? const Cart());
  }
}
