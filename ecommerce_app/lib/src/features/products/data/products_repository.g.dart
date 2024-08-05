// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'e99fe656510a96ce24203ba14e21694f8ac631c9';

/// See also [productsRepository].
@ProviderFor(productsRepository)
final productsRepositoryProvider =
    AutoDisposeProvider<MockProductsRepository>.internal(
  productsRepository,
  name: r'productsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsRepositoryRef = AutoDisposeProviderRef<MockProductsRepository>;
String _$productsFutureRepositoryHash() =>
    r'5617be1c2c9e337ad5e2f29dee7d236916d9c049';

/// See also [productsFutureRepository].
@ProviderFor(productsFutureRepository)
final productsFutureRepositoryProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
  productsFutureRepository,
  name: r'productsFutureRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsFutureRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsFutureRepositoryRef
    = AutoDisposeFutureProviderRef<List<Product>>;
String _$productFutureRepositoryHash() =>
    r'9ed2296ec76693a23456bb995872b5285d6cecc1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [productFutureRepository].
@ProviderFor(productFutureRepository)
const productFutureRepositoryProvider = ProductFutureRepositoryFamily();

/// See also [productFutureRepository].
class ProductFutureRepositoryFamily extends Family<AsyncValue<Product?>> {
  /// See also [productFutureRepository].
  const ProductFutureRepositoryFamily();

  /// See also [productFutureRepository].
  ProductFutureRepositoryProvider call(
    String id,
  ) {
    return ProductFutureRepositoryProvider(
      id,
    );
  }

  @override
  ProductFutureRepositoryProvider getProviderOverride(
    covariant ProductFutureRepositoryProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productFutureRepositoryProvider';
}

/// See also [productFutureRepository].
class ProductFutureRepositoryProvider
    extends AutoDisposeFutureProvider<Product?> {
  /// See also [productFutureRepository].
  ProductFutureRepositoryProvider(
    String id,
  ) : this._internal(
          (ref) => productFutureRepository(
            ref as ProductFutureRepositoryRef,
            id,
          ),
          from: productFutureRepositoryProvider,
          name: r'productFutureRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productFutureRepositoryHash,
          dependencies: ProductFutureRepositoryFamily._dependencies,
          allTransitiveDependencies:
              ProductFutureRepositoryFamily._allTransitiveDependencies,
          id: id,
        );

  ProductFutureRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Product?> Function(ProductFutureRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductFutureRepositoryProvider._internal(
        (ref) => create(ref as ProductFutureRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductFutureRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFutureRepositoryProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductFutureRepositoryRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductFutureRepositoryProviderElement
    extends AutoDisposeFutureProviderElement<Product?>
    with ProductFutureRepositoryRef {
  _ProductFutureRepositoryProviderElement(super.provider);

  @override
  String get id => (origin as ProductFutureRepositoryProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
