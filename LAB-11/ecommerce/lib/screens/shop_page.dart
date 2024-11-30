import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import '../widgets/ProductView.dart';
import 'dart:convert';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  static const Color primaryPurple = Color(0xFF6200EE);  // Purple өнгө нэмэх

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
    String res = await DefaultAssetBundle.of(context).loadString("assets/products.json");
    List<ProductModel> data = ProductModel.fromList(jsonDecode(res));
    Provider.of<Global_provider>(context, listen: false).setProducts(data);
    return Provider.of<Global_provider>(context, listen: false).products;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global_provider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ShopPage.primaryPurple,  // AppBar өнгө
            title: const Text(
              'Shop',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: FutureBuilder(
            future: _dataFuture,
            builder: ((context, snapshot) {
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
                          children: provider.products  // snapshot.data! оронд provider.products ашиглах
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