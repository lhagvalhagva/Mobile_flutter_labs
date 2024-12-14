import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import 'package:ecommerce/provider/language_provider.dart';

class Product_detail extends StatelessWidget {
  final ProductModel product; 
  static const Color primaryPurple = Color(0xFF6200EE);
  
  const Product_detail(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        final isInCart = provider.cartItems.contains(product);
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryPurple,
            title: Text(
              languageProvider.translate('productDetails'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${languageProvider.translate('category')}: ${product.category}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${languageProvider.translate('price')}: \$${product.price!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: primaryPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        languageProvider.translate('description'),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                        ? languageProvider.translate('removeFromCart')
                        : languageProvider.translate('addToCart')
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(languageProvider.translate('pleaseLoginFirst')),
                  ),
                );
              }
            },
            backgroundColor: isInCart ? Colors.red : primaryPurple,
            icon: Icon(
              isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
            ),
            label: Text(
              isInCart 
                ? languageProvider.translate('removeFromCart')
                : languageProvider.translate('addToCart')
            ),
          ),
        );
      },
    );
  }
}