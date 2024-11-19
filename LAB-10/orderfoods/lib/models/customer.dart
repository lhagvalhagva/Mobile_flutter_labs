import 'package:flutter/material.dart';
import 'item.dart';

class Customer {
  Customer({
    required this.name,
    required this.email,
    required List<Item> items,
    required this.imageProvider,
  }) : _items = items,
       itemsNotifier = ValueNotifier(items);

  final String name;
  final String email;
  final ImageProvider imageProvider;
  final List<Item> _items;
  final ValueNotifier<List<Item>> itemsNotifier;

  List<Item> get items => _items;

  String get formattedTotalItemPrice {
    final total = _items.fold<int>(0, (sum, item) => sum + item.totalPriceCents);
    return '₮${total.toStringAsFixed(0)}';
  }
}

final defaultCustomer = Customer(
  name: 'Болд',
  email: 'bold@example.com',
  items: [],
  imageProvider: const AssetImage('assets/images/avatar.jpeg'),
);


