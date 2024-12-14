import 'package:flutter/material.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/repository/repository.dart';
import 'package:ecommerce/services/httpService.dart';
import '../models/cart_model.dart';

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
    // Од��огийн favorite ID-уудыг хадгалах
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
  void addCartItems(ProductModel item) async {
    if (!isLoggedIn) {
      throw Exception('Please login first');
    }

    // Хэрэв бараа сагсанд байвал зөвхөн тоо ширхэгийг нэмэгдүүлэх
    final existingIndex = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    
    if (existingIndex >= 0) {
      // Бараа сагсанд байвал тоо ширхэгийг нэмэгдүүлэх
      await increaseQuantity(cartItems[existingIndex]);
    } else {
      // Бараа сагсанд байхгүй бол шинээр нэмэх
      cartItems.add(item);
      _quantities[item.id] = 1; // Анхны тоо ширхэг 1 байх
    }
    
    notifyListeners();
    
    // Update server cart
    await updateServerCart();
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
    
    // Update server cart
    await updateServerCart();
  }

  // Сагсыг цэвэрлэх
  Future<void> clearCart() async {
    cartItems.clear();
    _quantities.clear();
    notifyListeners();
    
    // Update server cart
    await updateServerCart();
  }

  void login(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    currentUser = null;  // Clear user data
    favorites.clear();   // Clear favorites
    cartItems.clear();   // Clear cart
    _quantities.clear(); // Clear quantities
    notifyListeners();
  }

  void changeCurrentIdx(int idx){
    // Bottom navigation bar-ын идэвхтэй tab-ыг солих
    currentIdx=idx;
    notifyListeners();
  }

  Future<void> syncCartFromServer() async {
    if (!isLoggedIn || _token == null) return;

    try {
      final carts = await MyRepository(httpService: HttpService(baseUrl: 'https://fakestoreapi.com'))
          .getUserCart(_token!);
      
      if (carts.isNotEmpty) {
        // Хамгийн сүүлийн cart-г авах
        final latestCart = carts.first;
        
        // Cart-г цэвэрлэх
        cartItems.clear();
        _quantities.clear();
        
        // Cart дахь бүтээгдэхүүн бүрийг нэмэх
        for (var product in latestCart.products) {
          final productDetails = await MyRepository(
            httpService: HttpService(baseUrl: 'https://fakestoreapi.com')
          ).getProduct(product.productId);
          
          cartItems.add(productDetails);
          _quantities[product.productId] = product.quantity;
        }
        
        notifyListeners();
      }
    } catch (e) {
      print('Error syncing cart: $e');
    }
  }

  Future<void> updateServerCart() async {
    if (!isLoggedIn || _token == null) return;

    try {
      // Convert cart items to CartProduct format
      final products = cartItems.map((item) => CartProduct(
        productId: item.id!,
        quantity: getQuantity(item),
      )).toList();

      await MyRepository(
        httpService: HttpService(baseUrl: 'https://fakestoreapi.com')
      ).updateCart(_token!, products);
      
      print('Cart updated on server successfully');
    } catch (e) {
      print('Error updating server cart: $e');
    }
  }

}
