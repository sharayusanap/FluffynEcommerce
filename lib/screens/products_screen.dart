import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/product_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_list_item.dart';
import '../widgets/cart_badge.dart';
import '../widgets/theme_switch.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'add_edit_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isInit = true;
  bool _isGrid = true; // Toggle between grid and list view

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<ProductProvider>(context).fetchProducts();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final apiProducts =
        productProvider.products.where((p) => !p.isUserAdded).toList();
    final userProducts = productProvider.userAddedProducts;
    final isLoading = productProvider.isLoading;
    final error = productProvider.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluffyn Shop'),
        actions: [
          // Toggle view button
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
          ),
          // Theme switch
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: ThemeSwitch(),
          ),
          // Cart button with badge
          const CartBadge(),
          // Profile button
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body:
          isLoading
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator()
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                          duration: 1200.ms,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading products...',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
              : error.isNotEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 60,
                      color: Colors.red,
                    ).animate().scale(
                      duration: 700.ms,
                      curve: Curves.easeOut,
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1.0, 1.0),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading products',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(error),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isInit = true;
                          didChangeDependencies();
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // API Products
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        'All Products',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: _isGrid ? 500 : 400,
                      child:
                          _isGrid
                              ? ProductGrid(products: apiProducts)
                              : ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: apiProducts.length,
                                itemBuilder:
                                    (ctx, i) =>
                                        ProductListItem(product: apiProducts[i])
                                            .animate(delay: (50 * i).ms)
                                            .fadeIn(
                                              duration: 300.ms,
                                              curve: Curves.easeOut,
                                            )
                                            .slideY(
                                              begin: 0.1,
                                              end: 0,
                                              curve: Curves.easeOut,
                                              duration: 300.ms,
                                            ),
                              ),
                    ),

                    // User Added Products
                    if (userProducts.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 24,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'My Products',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${userProducts.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _isGrid ? 400 : 300,
                        child:
                            _isGrid
                                ? ProductGrid(products: userProducts)
                                : ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: userProducts.length,
                                  itemBuilder:
                                      (ctx, i) => ProductListItem(
                                            product: userProducts[i],
                                          )
                                          .animate(delay: (50 * i).ms)
                                          .fadeIn(
                                            duration: 300.ms,
                                            curve: Curves.easeOut,
                                          )
                                          .slideY(
                                            begin: 0.1,
                                            end: 0,
                                            curve: Curves.easeOut,
                                            duration: 300.ms,
                                          ),
                                ),
                      ),
                    ],
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddEditProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ).animate().scale(
        duration: 300.ms,
        curve: Curves.elasticOut,
        delay: 300.ms,
      ),
    );
  }
}
