import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/globalProvider.dart';

class Product_detail extends StatelessWidget {
  final ProductModel product; 
  static const Color primaryPurple = Color(0xFF6200EE);
  
  const Product_detail(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        final isInCart = provider.cartItems.contains(product);
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryPurple,
            title: const Text('Product Details'),
            actions: [
              IconButton(
                icon: Icon(
                  provider.favorites.contains(product) 
                      ? Icons.favorite 
                      : Icons.favorite_border,
                  color: provider.favorites.contains(product) 
                      ? Colors.red 
                      : Colors.white,  // Icon өнгө
                ),
                onPressed: () {
                  try {
                    provider.toggleFavorite(product);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      product.image!,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    product.title!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'PRICE: \$${product.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              try {
                provider.addCartItems(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isInCart 
                          ? 'Removed from cart' 
                          : 'Added to cart'
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            backgroundColor: isInCart ? Colors.red : primaryPurple,  // FAB өнгө
            icon: Icon(
              isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
            ),
            label: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
          ),
        );
      },
    );
  }
}