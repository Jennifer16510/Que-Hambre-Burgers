import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier { //actualiza automáticamente
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount { //se suman las cantidades 
    int c = 0;
    _items.forEach((_, item) => c += item.quantity);
    return c;
  }

  double get totalPrice { //Calcula el precio total del carrito
    double t = 0.0;
    _items.forEach((_, item) => t += item.product.price * item.quantity);
    return t;
  }

  void addToCart(Product p) { //agrega productos 
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity += 1; //Si el producto ya estaba en el carrito → aumenta la cantidad.
    } else {
      _items[p.id] = CartItem(product: p); //Si no estaba → lo agrega con cantidad 1
    }
    notifyListeners();
  }

  void removeSingle(String productId) { //Quitar productos
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeProduct(String productId) { //Quita el producto completamente del carrito
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {  //Vaciar carrito
    notifyListeners();
  }
}
