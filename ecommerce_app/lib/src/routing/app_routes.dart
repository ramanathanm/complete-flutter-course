enum AppRoutes {
  home("home", "/", "/"),
  product("product", "/product/:id", "product/:id"),
  leaveReview("leaveReview", "/product/:id/review", "review"),
  cart("cart", "/cart", "cart"),
  checkout("checkout", "/cart/checkout", "checkout"),
  orders("orders", "/orders", "orders"),
  account("account", "/account", "account"),
  signIn("signIn", "/signIn", "signIn"),;

  const AppRoutes(this.name, this.fullPath, this.goRouterPath);

  final String name;
  final String fullPath;
  final String goRouterPath;
}