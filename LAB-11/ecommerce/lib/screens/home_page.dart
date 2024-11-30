import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
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
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: pages[provider.currentIdx],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.currentIdx,
            onTap: provider.changeCurrentIdx,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: 'Shopping'),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Bag'),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'favorite'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'),
            ]
          ),
        );
      }
    );
  }
}

  