import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/services/httpService.dart';


class MyRepository {
  final HttpService httpService=HttpService();

  MyRepository();
  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products',null);
      print(jsonData);
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
        } catch (e) {
      return Future.error(e.toString());
    }
  }

   Future<String> login(String username, String password) async {
    try {
      dynamic data = {"username": username, "password": password};
      var jsonData = await httpService.postData('auth/login',null, data);
      return jsonData["token"];
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }
}