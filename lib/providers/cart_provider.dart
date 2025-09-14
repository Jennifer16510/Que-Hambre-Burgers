import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    int c = 0;
    _items.forEach((_, item) => c += item.quantity);
    return c;
  }

  double get totalPrice {
    double t = 0.0;
    _items.forEach((_, item) => t += item.product.price * item.quantity);
    return t;
  }

  void addToCart(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity += 1;
    } else {
      _items[p.id] = CartItem(product: p);
    }
    notifyListeners();
  }

  void removeSingle(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
