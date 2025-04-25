import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utility class containing common functions used across the app
class AppUtils {
  /// Format a price with currency symbol
  static String formatPrice(double price) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    return currencyFormat.format(price);
  }

  /// Format a date in a user-friendly way
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Validate an email address
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate a phone number (very basic validation)
  static bool isValidPhone(String phone) {
    return phone.length >= 10 && RegExp(r'^\+?[0-9\s\-\(\)]+$').hasMatch(phone);
  }

  /// Show a custom snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    bool isError = false,
    SnackBarAction? action,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: isError ? Colors.red : colorScheme.primary,
        action: action,
      ),
    );
  }

  /// Show a loading dialog
  static void showLoadingDialog(
    BuildContext context, {
    String message = 'Loading...',
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(message, style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
    );
  }

  /// Show a confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(cancelLabel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(
                  confirmLabel,
                  style: TextStyle(color: isDestructive ? Colors.red : null),
                ),
              ),
            ],
          ),
    );

    return result ?? false;
  }

  /// Get truncated text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  /// Capitalize first letter of a string
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Get a color based on the product category
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Colors.blue;
      case 'jewelery':
        return Colors.purple;
      case 'men\'s clothing':
        return Colors.green;
      case 'women\'s clothing':
        return Colors.pink;
      default:
        return Colors.orange;
    }
  }
}
