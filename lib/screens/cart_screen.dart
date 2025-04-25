import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/theme_switch.dart';
import '../theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final totalAmount = cartProvider.totalAmount;
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ThemeSwitch(),
          ),
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Clear Cart'),
                        content: const Text(
                          'Are you sure you want to remove all items from your cart?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              cartProvider.clear();
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Cart cleared'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text(
                              'Clear All',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child:
                cartItems.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ).animate().scale(
                            duration: 600.ms,
                            curve: Curves.elasticOut,
                            begin: const Offset(0.6, 0.6),
                            end: const Offset(1.0, 1.0),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: theme.textTheme.titleLarge,
                          ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                          const SizedBox(height: 8),
                          Text(
                            'Add some products to your cart',
                            style: TextStyle(color: Colors.grey[600]),
                          ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.shopping_bag),
                                label: const Text('Start Shopping'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              )
                              .animate()
                              .fadeIn(delay: 800.ms, duration: 500.ms)
                              .slideY(
                                begin: 0.5,
                                end: 0,
                                delay: 800.ms,
                                duration: 500.ms,
                                curve: Curves.easeOutCubic,
                              ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder:
                          (ctx, i) => CartItemWidget(cartItem: cartItems[i])
                              .animate(delay: (i * 50).ms)
                              .fadeIn(duration: 300.ms)
                              .slideX(
                                begin: 0.1,
                                end: 0,
                                curve: Curves.easeOutCubic,
                                duration: 300.ms,
                              ),
                    ),
          ),

          // Order Summary
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Order summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total (${cartItems.length} item${cartItems.length > 1 ? 's' : ''})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currencyFormat.format(totalAmount),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 300.ms),

                  const SizedBox(height: 16),

                  // Checkout button
                  SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            // Show a confirmation dialog for checkout
                            showDialog(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: const Text('Checkout'),
                                    content: const Text(
                                      'This is a demo app. In a real app, this would proceed to the checkout process.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.payment),
                              SizedBox(width: 8),
                              Text(
                                'CHECKOUT',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 300.ms, delay: 200.ms)
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 300.ms,
                        curve: Curves.easeOutCubic,
                      ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
