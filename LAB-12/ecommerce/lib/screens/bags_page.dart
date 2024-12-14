import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import 'package:ecommerce/provider/language_provider.dart';

class BagsPage extends StatelessWidget {

  BagsPage({super.key});
  static const Color primaryPurple = Color(0xFF6200EE);
 
   @override
  Widget build(BuildContext context) {

      return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        final total = provider.totalPrice;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryPurple,
              title: Text(
                languageProvider.translate('myBag'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                if (provider.cartItems.isNotEmpty)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(languageProvider.translate('clearCart')),
                          content: Text(languageProvider.translate('areYouSureRemoveAll')),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(languageProvider.translate('cancel')),
                            ),
                            TextButton(
                              onPressed: () {
                                provider.clearCart();
                                Navigator.pop(context);
                              },
                              child: Text(
                                languageProvider.translate('clear'),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
            body: provider.cartItems.isEmpty 
                ? Center(
                    child: Text(
                      languageProvider.translate('yourCartIsEmpty'),
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = provider.cartItems[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Бүтээгдэхүүний зураг
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(item.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Б��тээгдэхүүний мэдээлэл
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${item.price!.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: primaryPurple,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Тоо ширхэг өөрчлөх хэсэг
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              // Хасах товч
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  // Тоо ширхэг хасах
                                                  provider.decreaseQuantity(item);
                                                },
                                                constraints: const BoxConstraints(
                                                  minWidth: 32,
                                                  minHeight: 32,
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              // Тоо ширхэг
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(
                                                  '${provider.getQuantity(item)}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              // Нэмэх товч
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  // Тоо ширхэг нэмэх
                                                  provider.increaseQuantity(item);
                                                },
                                                constraints: const BoxConstraints(
                                                  minWidth: 32,
                                                  minHeight: 32,
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        // Устгах товч
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            provider.removeFromCart(item);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageProvider.translate('totalPrice'),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryPurple,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: provider.cartItems.isEmpty ? null : () {
                      // Checkout logic
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      languageProvider.translate('buyAll'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
      });
}
}