import 'package:flutter/material.dart';
import 'pages/visit_page.dart';
import 'pages/login_page.dart';
import 'pages/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Times New Roman',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 16,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const VisitPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
