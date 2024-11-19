import 'package:flutter/material.dart';
import 'item.dart';

class Customer {
  Customer({
    required this.name,
    required this.imageProvider,
    required this.email,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final String email;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '₮${(totalPriceCents).toStringAsFixed(0)}';
  }
}

// Тогтмол хэрэглэгч
final defaultCustomer = Customer(
  name: 'Болд',
  email: 'bold@example.com',
  imageProvider: const AssetImage('assets/images/avatar.jpeg'),
); 