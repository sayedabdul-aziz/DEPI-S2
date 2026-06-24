// BASEURL AND ENDPOINTS

class Apis {
  static const String baseUrl = "https://codingarabic.online/api";

  // auth
  static const String login = "/login";
  static const String register = "/register";

  // home
  static const String sliders = "/sliders";
  static const String bestSellers = "/products-bestseller";

  // wishlist
  static const String wishlist = "/wishlist";
  static const String addToWishlist = "/add-to-wishlist";
  static const String removeFromWishlist = "/remove-from-wishlist";

  // cart
  static const String cart = "/cart";
  static const String addToCart = "/add-to-cart";
  static const String removeFromCart = "/remove-from-cart";
  static const String updateCart = "/update-cart";

  // checkout
  static const String governorates = "/governorates";
  static const String checkout = "/checkout";
  static const String placeOrder = "/place-order";

  // profile
  static const String profile = "/profile";
  static const String updateProfile = "/update-profile";

  // search
  static const String productsSearch = "/products-search";
}
