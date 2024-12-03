import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/provider/globalProvider.dart';
import '../../../screens/home_page.dart';
import '../../../screens/login_page.dart';

void main() {
  runApp(
     // Бүх app-д Provider хүрэх боломжтой болгох
     ChangeNotifierProvider(
      create: (context) => Global_provider(),
      child: const MyApp()));
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

