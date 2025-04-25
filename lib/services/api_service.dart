import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Cache for API responses
  final Map<String, dynamic> _cache = {};
  final Duration _cacheDuration = const Duration(minutes: 15);
  final Map<String, DateTime> _cacheTimestamps = {};

  // Client with timeout
  final http.Client _client = http.Client();
  final Duration _timeout = const Duration(seconds: 10);

  // Check if cache is valid
  bool _isCacheValid(String cacheKey) {
    if (!_cache.containsKey(cacheKey) ||
        !_cacheTimestamps.containsKey(cacheKey)) {
      return false;
    }

    final timestamp = _cacheTimestamps[cacheKey]!;
    final now = DateTime.now();
    return now.difference(timestamp) < _cacheDuration;
  }

  // Store data in cache
  void _cacheData(String cacheKey, dynamic data) {
    _cache[cacheKey] = data;
    _cacheTimestamps[cacheKey] = DateTime.now();
  }

  // Fetch all products from the API with caching
  Future<List<Product>> fetchProducts() async {
    const cacheKey = 'all_products';

    // Return from cache if valid
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as List<Product>;
    }

    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/products'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((item) => Product.fromJson(item)).toList();

        // Store in cache
        _cacheData(cacheKey, products);

        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Connection timeout while fetching products');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // Fetch a single product by ID with caching
  Future<Product> fetchProductById(int id) async {
    final cacheKey = 'product_$id';

    // Return from cache if valid
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as Product;
    }

    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/products/$id'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final product = Product.fromJson(data);

        // Store in cache
        _cacheData(cacheKey, product);

        return product;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Connection timeout while fetching product');
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  // Fetch products by category with caching
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final cacheKey = 'category_$category';

    // Return from cache if valid
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as List<Product>;
    }

    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/products/category/$category'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((item) => Product.fromJson(item)).toList();

        // Store in cache
        _cacheData(cacheKey, products);

        return products;
      } else {
        throw Exception(
          'Failed to load products by category: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Connection timeout while fetching products by category');
    } catch (e) {
      throw Exception('Failed to load products by category: $e');
    }
  }

  // Fetch all categories with caching
  Future<List<String>> fetchCategories() async {
    const cacheKey = 'all_categories';

    // Return from cache if valid
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as List<String>;
    }

    try {
      final response = await _client
          .get(Uri.parse('$baseUrl/products/categories'))
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final categories = data.map((item) => item.toString()).toList();

        // Store in cache
        _cacheData(cacheKey, categories);

        return categories;
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Connection timeout while fetching categories');
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  // Clear the cache
  void clearCache() {
    _cache.clear();
    _cacheTimestamps.clear();
  }

  // Dispose the client
  void dispose() {
    _client.close();
  }
}
