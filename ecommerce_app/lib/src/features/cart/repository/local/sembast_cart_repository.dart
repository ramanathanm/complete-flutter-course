import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

import 'package:ecommerce_app/src/features/cart/data/cart.dart';
import 'package:ecommerce_app/src/features/cart/repository/cart_repository.dart';

class SembastCartRepository extends LocalCartRepository {
  SembastCartRepository(this.db) {
    debugPrint('SembastCartRepository initialized');
  }

  final Database db;
  final store = StoreRef.main();

  static const cartItemsKey = 'cartItems';

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      return await databaseFactoryIo.openDatabase(filename);
    } else {
      return await databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastCartRepository> makeDefault(String filename) async {
    final db = await createDatabase(filename);
    return SembastCartRepository(db);
  }

  @override
  Future<Cart> fetchCart() async {
    final cartJson = await store.record(cartItemsKey).get(db) as String?;
    return cartJson == null ? const Cart() : Cart.fromJson(cartJson);
  }

  @override
  Future<void> setCart(Cart cart) async {
    final cartJson = cart.toJson();
    await store.record(cartItemsKey).put(db, cartJson);
  }

  @override
  Stream<Cart> watchCart() {
    final record = store.record(cartItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot == null) {
        return const Cart();
      } else {
        return Cart.fromJson(snapshot.value as String);
      }
    });
  }
}
