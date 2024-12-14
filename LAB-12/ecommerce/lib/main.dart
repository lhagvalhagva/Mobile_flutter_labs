import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import '../../../screens/home_page.dart';
import '../../../screens/login_page.dart';
import 'package:ecommerce/services/httpService.dart';
import 'package:ecommerce/repository/repository.dart';
import 'package:ecommerce/provider/language_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Global_provider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        Provider(create: (context) => HttpService(baseUrl: 'https://fakestoreapi.com')),
        ProxyProvider<HttpService, MyRepository>(
          update: (context, httpService, previous) => MyRepository(httpService: httpService)
        ),
      ], 
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

