import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../models/user_model.dart';
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Future<List<User>> getUsers() async {
  //   final response = await http.get(Uri.parse('$baseUrl/users'));
  //   if (response.statusCode == 200) {
  //     return User.fromList(jsonDecode(response.body));
  //   }
  //   throw Exception('Failed to load users: ${response.statusCode}');
  // }

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return ProductModel.fromList(jsonDecode(response.body));
    }
    throw Exception('Failed to load products: ${response.statusCode}');
  }
}