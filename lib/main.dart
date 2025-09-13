import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importa tu provider y las páginas
import 'providers/cart_provider.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/products_page.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      // Ruta inicial: el login
      initialRoute: '/',
     routes: {
  '/': (_) => LoginPage(),
  '/home': (_) => HomePage(),
  '/products': (_) => ProductsPage(),
  '/cart': (_) => CartPage(),
},
    );
  }
}
