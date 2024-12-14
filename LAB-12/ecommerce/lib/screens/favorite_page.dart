import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import 'package:ecommerce/provider/language_provider.dart';
import '../widgets/ProductView.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  static const Color primaryPurple = Color(0xFF6200EE);
  
  @override
  Widget build(BuildContext context) {
    return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryPurple,
            title: Text(
              languageProvider.translate('favorites'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: !provider.isLoggedIn 
              ? Center(
                  child: Text(
                    languageProvider.translate('pleaseLoginToViewFavorites'),
                  ),
                )
              : provider.favorites.isEmpty
                  ? Center(
                      child: Text(
                        languageProvider.translate('noFavoritesYet'),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              languageProvider.translate('myFavoriteItems'),
                              style: const TextStyle(
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