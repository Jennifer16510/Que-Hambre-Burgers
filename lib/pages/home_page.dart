import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../design/themedata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ThemeColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.info_outline, color: Colors.orange),
                                    title: const Text('Quiénes somos'),
                                    subtitle: const Text(
                                        'Somos una empresa nacida en Armenia Quindío - Qué Hambre Burgers...'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.phone, color: Colors.green),
                                    title: const Text('Contacto'),
                                    subtitle: const Text('WhatsApp: +57 3165320362'),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    leading: const Icon(Icons.exit_to_app, color: Colors.red),
                                    title: const Text('Salir'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(context, '/');
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      'Qué Hambre Burgers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            offset: const Offset(4, 4),
                            blurRadius: 4,
                            color: const Color.fromARGB(255, 219, 207, 207),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                          onPressed: () => Navigator.of(context).pushNamed('/cart'),
                        ),
                        if (cart.itemCount > 0)
                          Positioned(
                            right: 6,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF889A2E),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${cart.itemCount}',
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/imag/marco.png', width: 340, height: 340, fit: BoxFit.contain),
                            Positioned(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset('assets/imag/hambu.jpeg', width: 250, height: 250, fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pushNamed('/products'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xFFB39307),
                          ),
                          child: const Text(
                            'Nuestros productos',
                            style: TextStyle(color: Color(0xFFF5F2ED), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Quiénes somos'),
                                content: const Text(
                                  'Somos una empresa nacida en Armenia Quindío \n\n'
                                  '-Qué Hambre Burgers llega con el mejor sabor de la ciudad y reconocido por la calidad de nuestros productos. \n\n'
                                  'Visítanos en Centro comercial Unicentro Local 2.',
                                ),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar'))
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xFFB39307),
                          ),
                          child: const Text(
                            'Quiénes somos',
                            style: TextStyle(color: Color(0xFFF5F2ED), fontSize: 16, fontWeight: FontWeight.bold),
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
