import 'package:flutter/material.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';

// ignore: camel_case_types
class Global_provider extends ChangeNotifier{
  List<ProductModel> products =[];
  List <ProductModel> cartItems = [];
  List<ProductModel> favorites = [];
  User? currentUser;
  int currentIdx=0;

  // Бараа бүрийн тоо ширхэгийг хадгалах Map
  final Map<int?, int> _quantities = {};

  bool get isLoggedIn => currentUser != null;

  void setProducts( List<ProductModel> data){
    // Одоогийн favorite ID-уудыг хадгалах
    final favoriteIds = favorites.map((product) => product.id).toList();
    
    // Шинэ products дээр favorite төлөвийг тохируулах
    products = data.map((product) {
      product.isFavorite = favoriteIds.contains(product.id);  // төлөвийг шууд оноох
      return product;
    }).toList();
    
    notifyListeners();
  }

  void addCartItems(ProductModel item){
    if (!isLoggedIn) {
      throw Exception('Please login first');
    }
    if(cartItems.contains(item)){
      cartItems.remove(item);
    }
    else{
      cartItems.add(item);
    }
    notifyListeners();
  }

  void toggleFavorite(ProductModel item) {
    if (!isLoggedIn) {
      throw Exception('Please login first');
    }
    
    // ID-аар хайж олох
    final existingIndex = favorites.indexWhere((product) => product.id == item.id);
    
    if (existingIndex >= 0) {
      // Байвал хасах
      favorites.removeAt(existingIndex);
      item.isFavorite = false;  // төлөвийг false болгох
    } else {
      // Байхгүй бол нэмэх
      favorites.add(item);
      item.isFavorite = true;  // төлөвийг true болгох
    }
    
    // Бүх бараан дээр favorite төлөвийг шинэчлэх
    for (var product in products) {
      if (product.id == item.id) {
        product.isFavorite = item.isFavorite;  // шинэ төлөвийг оноох
      }
    }
    
    notifyListeners();
  }

  void login(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logout() {
    currentUser = null;
    cartItems.clear();
    favorites.clear();
    notifyListeners();
  }

  void changeCurrentIdx(int idx){
    currentIdx=idx;
    notifyListeners();
  }

  // Тоо ширхэг авах
  int getQuantity(ProductModel product) {
    return _quantities[product.id] ?? 1;
  }

  // Тоо ширхэг нэмэх
  void increaseQuantity(ProductModel product) {
    if (product.id != null) {
      _quantities[product.id] = getQuantity(product) + 1;
      notifyListeners();
    }
  }

  // Тоо ширхэг хасах
  void decreaseQuantity(ProductModel product) {
    if (product.id != null) {
      final currentQty = getQuantity(product);
      if (currentQty > 1) {
        _quantities[product.id] = currentQty - 1;
        notifyListeners();
      }
    }
  }

  // Сагснаас устгах
  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    if (product.id != null) {
      _quantities.remove(product.id);
    }
    notifyListeners();
  }

  // Нийт үнийг тооцоолох
  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item.safePrice * getQuantity(item));
    });
  }

  // Сагсыг цэвэрлэх
  void clearCart() {
    cartItems.clear();
    _quantities.clear();
    notifyListeners();
  }
}
