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

  String? _token;
  
  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  bool get isLoggedIn => currentUser != null;

  // Нийт үнийг тооцоолох
  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      return sum + (item.safePrice * getQuantity(item));
    });
  }
  // API-аас авах бүтээгдэхүүнийг products-д оноох
 
  void setProducts( List<ProductModel> data){
    // Одоогийн favorite ID-уудыг хадгалах
    final favoriteIds = favorites.map((product) => product.id).toList();
    
    // Шинэ products дээр favorite төлөвийг тохируулах
    products = data.map((product) {
      product.isFavorite = favoriteIds.contains(product.id);//төлөвийг шууд оноох
      return product;
    }).toList();
    
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
      item.isFavorite = false;
    } else {
      // Байхгүй бол нэмэх
      favorites.add(item);
      item.isFavorite = true;
    }
    // Бүх бараан дээр favorite төлөвийг шинэчлэх
    for (var product in products) {
      if (product.id == item.id) {
        product.isFavorite = item.isFavorite;
      }
    }
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
    // Тоо ширхэг авах
  int getQuantity(ProductModel product) {
    return _quantities[product.id] ?? 1;
  }

  // Тоо ширхэг нэмэх
  Future<void> increaseQuantity(ProductModel product) async {
    if (product.id != null) {
      _quantities[product.id] = getQuantity(product) + 1;
      notifyListeners();
    }
  }

  // Тоо ширхэг хасах
  Future<void> decreaseQuantity(ProductModel product) async {
    if (product.id != null) {
      final currentQty = getQuantity(product);
      if (currentQty > 1) {
        _quantities[product.id] = currentQty - 1;
        notifyListeners();
      }
    }
  }

  // Сагснаас устгах
  Future<void> removeFromCart(ProductModel product) async {
    cartItems.remove(product);
    if (product.id != null) {
      _quantities.remove(product.id);
    }
    notifyListeners();
  }

  // Сагсыг цэвэрлэх
  Future<void> clearCart() async {
    cartItems.clear();
    _quantities.clear();
    notifyListeners();
  }

  void login(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    notifyListeners();
  }

  void changeCurrentIdx(int idx){
    // Bottom navigation bar-ын идэвхтэй tab-ыг солих
    currentIdx=idx;
    notifyListeners();
  }


}
