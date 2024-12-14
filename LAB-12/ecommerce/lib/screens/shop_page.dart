import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import '../widgets/ProductView.dart';
import 'package:ecommerce/repository/repository.dart';
import '../services/httpService.dart';
import '../provider/language_provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  static const Color primaryPurple = Color(0xFF6200EE);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<List<ProductModel>>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _getData();
  }

  Future<List<ProductModel>> _getData() async {
    final provider = Provider.of<Global_provider>(context, listen: false);

    // Хэрэв бүтээгдэхүүнүүд аль хэдийн ачаалагдсан бол шууд буцаах
    if (provider.products.isNotEmpty) {
      return provider.products;
    }

    try {
      final products = await MyRepository(httpService: HttpService(baseUrl: 'https://fakestoreapi.com')).getProducts();
      provider.setProducts(products);
      return products;
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Global_provider, LanguageProvider>(
      builder: (context, provider, languageProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ShopPage.primaryPurple,
            title: Text(
              languageProvider.translate('shop'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: FutureBuilder<List<ProductModel>>(
            future: _dataFuture,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: provider.products
                              .map((product) => ProductViewShop(product))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
          ),
        );
      },
    );
  }
}


