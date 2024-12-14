import 'package:ecommerce/services/httpService.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../models/cart_model.dart';

class MyRepository {
  final HttpService httpService;
  
  MyRepository({required this.httpService});
  Future<List<ProductModel>> getProducts() async {
    try {
      print('Fetching products from repository');
      final jsonData = await httpService.getData('products', null);
      print('Products fetched successfully');
      return ProductModel.fromList(jsonData);
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  Future<String> login(String username, String password) async {
    try {
      print('Attempting login for user: $username');
      dynamic data = {"username": username, "password": password};
      print('Login request data: $data');
      
      var jsonData = await httpService.postData('auth/login', null, data);
      print('Login response: $jsonData');
      
      if (jsonData["token"] == null) {
        throw Exception('Token not found in response');
      }
      
      return jsonData["token"];
    } catch (e) {
      print('Login error: $e');
      return Future.error('Login failed: $e');
    }
  }

  Future<User> getUserInfo(String token) async {
    try {
      print('Decoding token to get user ID');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int userId = decodedToken['sub'];
      print('User ID from token: $userId');

      print('Fetching user info for ID: $userId');
      final jsonData = await httpService.getData('users/$userId', token);
      print('User info fetched successfully');
      return User.fromJson(jsonData);
    } catch (e) {
      print('Error fetching user info: $e');
      throw Exception('Failed to load user info: $e');
    }
  }

  Future<List<CartModel>> getUserCart(String token) async {
    try {
      print('Decoding token to get user ID');
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int userId = decodedToken['sub'];
      print('User ID from token: $userId');

      print('Fetching cart for user: $userId');
      final jsonData = await httpService.getData('carts/user/$userId', token);
      print('Cart data fetched successfully');
      
      final carts = CartModel.fromList(jsonData);
      
      // Хамгийн сүүлийн cart-г эхэнд байрлуулах
      carts.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
      
      return carts;
    } catch (e) {
      print('Error fetching user cart: $e');
      throw Exception('Failed to load user cart: $e');
    }
  }

  // Тодорхой бүтээгдэхүүний мэдээлэл авах
  Future<ProductModel> getProduct(int productId) async {
    try {
      print('Fetching product details for ID: $productId');
      final jsonData = await httpService.getData('products/$productId', null);
      print('Product details fetched successfully');
      return ProductModel.fromJson(jsonData);
    } catch (e) {
      print('Error fetching product details: $e');
      throw Exception('Failed to load product details: $e');
    }
  }

  Future<void> updateCart(String token, List<CartProduct> products) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      int userId = decodedToken['sub'];
      
      print('Updating cart for user: $userId');
      final data = {
        "userId": userId,
        "date": DateTime.now().toIso8601String(),
        "products": products.map((p) => {
          "productId": p.productId,
          "quantity": p.quantity,
        }).toList(),
      };
      
      final response = await httpService.postData('carts', token, data);
      print('Cart update response: $response');
    } catch (e) {
      print('Error updating cart: $e');
      throw Exception('Failed to update cart: $e');
    }
  }
}