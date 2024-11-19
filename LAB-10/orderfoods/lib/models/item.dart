import 'package:flutter/material.dart';

@immutable
class Item {
  const Item({
    required this.totalPriceCents,
    required this.name,
    required this.uid,
    required this.imageProvider,
  });
  
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  
  String get formattedTotalItemPrice =>
      '₮${(totalPriceCents).toStringAsFixed(0)}';
}

final List<Item> menuItems = [
  Item(
    name: 'Цуйван',
    totalPriceCents: 12000,
    uid: '1',
    imageProvider: const AssetImage('assets/images/food1.jpg'),
  ),
  Item(
    name: 'Будаатай хуурга',
    totalPriceCents: 10000,
    uid: '2', 
    imageProvider: const AssetImage('assets/images/food2.jpeg'),
  ),
    Item(
    name: 'Пирошки',
    totalPriceCents: 1500,
    uid: '3',
    imageProvider: const AssetImage('assets/images/food3.jpg'),
  ),
      Item(
    name: 'Мантуун бууз',
    totalPriceCents: 1500,
    uid: '4',
    imageProvider: const AssetImage('assets/images/food4.jpeg'),
  ),
    Item(
    name: 'Гурилтай шөл',
    totalPriceCents: 10000,
    uid: '5',
    imageProvider: const AssetImage('assets/images/food5.jpg'),
  ),
        Item(
    name: 'Хуушуур',
    totalPriceCents: 1800,
    uid: '6',
    imageProvider: const AssetImage('assets/images/food6.jpeg'),
  ),
    Item(
    name: 'Ногоотой шөл',
    totalPriceCents: 10000,
    uid: '7',
    imageProvider: const AssetImage('assets/images/food7.jpeg'),
  ),

]; 