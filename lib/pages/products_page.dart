import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../design/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> demoProducts = [
    Product(id: 'p1', name: 'Clásica', description: 'Hamburguesa de carne 120g con queso, tomate, cebolla y lechuga.', image: 'assets/imag/hamb1.jpg',price: 12000),
    Product(id: 'p2', name: 'Doble Queso', description: 'Carne doble, queso extra , cebolla, tomate, lechuga y Salsa de la casa.', image: 'assets/imag/hamb2.jpg', price: 18000),
    Product(id: 'p3', name: 'Surtida', description: 'Combo de mini hamburguesas, carne 70 gr, queso, pepinillos, cebolla, tomate y salsa de la casa.', image: 'assets/imag/hamb3.jpg', price: 22000),
    Product(id: 'p4', name: 'Veggie', description: 'Hamburguesa vegetariana, , carne de lentejas, tomate , lechuga y salsa de casa.', image: 'assets/imag/hamb4.png', price: 14000),
    Product(id: 'p5', name: 'Especial', description: 'Carne preparada con la receta de la casa, queso, tomate, cebolla, lechuga y salsa de la casa.', image: 'assets/imag/hamb5.jpg', price: 30000),
    Product(id: 'p6', name: 'Combo Papas + Bebida', description: 'Hamburguesa  clásica con papas y bebida .', image: 'assets/imag/hamb6.png', price: 18000),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: Text('Nuestros Productos'),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => Navigator.of(context).pushNamed('/cart'))
        ],
      ),
      backgroundColor: AppColors.darkBg,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: demoProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.66,
          ),
          itemBuilder: (ctx, i) {
            final p = demoProducts[i];
            return ProductCard(
              product: p,
              onAdd: () {
                cart.addToCart(p);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${p.name} agregado al carrito')));
              },
            );
          },
        ),
      ),
    );
  }
}
