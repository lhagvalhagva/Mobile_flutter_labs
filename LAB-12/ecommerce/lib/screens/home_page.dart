import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import 'package:ecommerce/provider/language_provider.dart';
import 'bags_page.dart';
import 'shop_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  
  final List<Widget> pages = [
    const ShopPage(), 
    BagsPage(),
    const FavoritePage(), 
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        return Scaffold(
          body: pages[provider.currentIdx],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIdx,
            onTap: provider.changeCurrentIdx,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.shop),
                label: languageProvider.translate('shopping'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_basket),
                label: languageProvider.translate('bag'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite),
                label: languageProvider.translate('favorite'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: languageProvider.translate('profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}

  