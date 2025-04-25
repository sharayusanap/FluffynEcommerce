import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  List<Product> _userAddedProducts = [];
  bool _isLoading = false;
  String _error = '';

  // Getters
  List<Product> get products => [..._products, ..._userAddedProducts];
  List<Product> get userAddedProducts => [..._userAddedProducts];
  bool get isLoading => _isLoading;
  String get error => _error;

  // Initialize by fetching products from API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final fetchedProducts = await _apiService.fetchProducts();
      _products = fetchedProducts;
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new product (locally)
  void addProduct(Product product) {
    // Generate a unique negative ID for local products
    // API products typically have positive IDs, so we use negative to avoid conflicts
    final newId =
        _userAddedProducts.isEmpty
            ? -1
            : _userAddedProducts
                    .map((p) => p.id ?? 0)
                    .reduce((a, b) => a < b ? a : b) -
                1;

    final newProduct = product.copyWith(id: newId, isUserAdded: true);

    _userAddedProducts.add(newProduct);
    notifyListeners();
  }

  // Update an existing user-added product
  void updateProduct(Product updatedProduct) {
    final index = _userAddedProducts.indexWhere(
      (p) => p.id == updatedProduct.id,
    );

    if (index >= 0) {
      _userAddedProducts[index] = updatedProduct;
      notifyListeners();
    }
  }

  // Delete a user-added product
  void deleteProduct(int id) {
    _userAddedProducts.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  // Find a product by ID
  Product? findById(int id) {
    try {
      if (id > 0) {
        return _products.firstWhere((product) => product.id == id);
      } else {
        return _userAddedProducts.firstWhere((product) => product.id == id);
      }
    } catch (e) {
      return null;
    }
  }
}
