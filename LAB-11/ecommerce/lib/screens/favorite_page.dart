import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import '../widgets/ProductView.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
 static const Color primaryPurple = Color(0xFF6200EE);
  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: primaryPurple,
              title: const Text(
              'Favorites',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              
            ),
          ),
          body: !provider.isLoggedIn 
              ? const Center(
                  child: Text('Please login to view favorites'),
                )
              : provider.favorites.isEmpty
                  ? const Center(
                      child: Text('No favorites yet'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'My Favorite Items',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 10,
                              children: provider.favorites
                                  .map((product) => ProductViewShop(product))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}