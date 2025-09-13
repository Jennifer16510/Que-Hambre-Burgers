import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón Menú
                    IconButton(
                      icon: Icon(Icons.menu, color: Colors.white, size: 28),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.info_outline, color: Colors.orange),
                                    title: Text('Quiénes somos'),
                                    subtitle: Text('Somos una empresa nacida en Armenia quindio - Que Hambre Burguers llega a Armenia quindio con el mejor sabor de la ciudad y reconocido por la calidad de nuestros productos.')
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone, color: Colors.green),
                                    title: Text('Contacto'),
                                    subtitle: Text('WhatsApp: +57 3165320362'),
                                  ),
                                  Divider(),
                                  // 🔹 Opción de salir
                                  ListTile(
                                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                                    title: Text('Salir'),
                                    onTap: () {
                                      Navigator.pop(context); // Cierra el menú
                                      Navigator.pushReplacementNamed(context, '/'); // Regresa al login
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // Título
                    Text(
                          'Qué Hambre Burgers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            shadows: [
                            Shadow(
                              offset: Offset(4, 4), 
                              blurRadius: 4,        // Difuminado
                              color: const Color.fromARGB(255, 219, 207, 207), 
                              ),
                            ],
                          ),
                        ),


                    // Carrito
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                          onPressed: () => Navigator.of(context).pushNamed('/cart'),
                        ),
                        if (cart.itemCount > 0)
                          Positioned(
                            right: 6,
                            top: 8,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(color: const Color.fromARGB(255, 136, 138, 46), shape: BoxShape.circle),
                              child: Text(
                                '${cart.itemCount}',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // marco y imagen principal
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 6),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/imag/marco.png',
                                width: 340, height: 340, fit: BoxFit.contain),
                            Positioned(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset('assets/imag/hambu.jpeg',
                                    width: 250, height: 250, fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed('/products'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                            shape: StadiumBorder(),
                            backgroundColor: const Color.fromARGB(255, 179, 147, 7),
                          ),
                          child: Text('Nuestros productos', style: TextStyle(
                              color: const Color.fromARGB(255, 245, 242, 237),   
                              fontSize: 16,          
                              fontWeight: FontWeight.bold, 
                              ),
                            ),
                            ),
                        
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Quiénes somos'),
                                content: Text(
                              'Somos una empresa nacida en Armenia Quindío \n\n' 
                                  '-Qué Hambre Burgers llega con el mejor sabor de la ciudad y reconocido por la calidad de nuestros productos. \n\n'
                                  'Visítanos en Centro comercial Unicentro Local 2.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cerrar'),
                                  )
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                            shape: StadiumBorder(),
                            backgroundColor: const Color.fromARGB(255, 179, 147, 7),
                          ),
                          child: Text(
                            'Quiénes somos',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 245, 242, 237),   
                              fontSize: 16,          
                              fontWeight: FontWeight.bold, 
                              ),
                            ),

                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
