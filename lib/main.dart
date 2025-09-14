import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'providers/cart_provider.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/products_page.dart';
import 'pages/cart_page.dart';
import 'pages/reset_password_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qué Hambre Burgers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/home': (_) => const HomePage(),
        '/products': (_) => const ProductsPage(),
        '/cart': (_) => const CartPage(),
        '/reset': (_) => const ResetPasswordPage(),
      },
    );
  }
}
