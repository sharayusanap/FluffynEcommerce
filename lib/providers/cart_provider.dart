import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // Map of product ID to CartItem
  final Map<int, CartItem> _items = {};

  // Getters
  Map<int, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  // Calculate the total amount in the cart
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // Add an item to the cart
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Increase quantity if already in cart
      _items.update(
        product.id!,
        (existingCartItem) =>
            existingCartItem.copyWith(quantity: existingCartItem.quantity + 1),
      );
    } else {
      // Add new item to cart
      _items.putIfAbsent(product.id!, () => CartItem(product: product));
    }
    notifyListeners();
  }

  // Remove an item from the cart
  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Reduce the quantity of an item in the cart
  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      // Reduce quantity
      _items.update(
        productId,
        (existingCartItem) =>
            existingCartItem.copyWith(quantity: existingCartItem.quantity - 1),
      );
    } else {
      // Remove if quantity becomes 0
      _items.remove(productId);
    }
    notifyListeners();
  }

  // Clear the cart
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
