import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../design/themedata.dart'; // 🎨 Importar tu paleta

class CartPage extends StatelessWidget {
  const CartPage ({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.values.toList();

    return Scaffold(
      backgroundColor: ThemeColors.lightBg, // Fondo claro
      appBar: AppBar(
        title: const Text('Carrito'),
        backgroundColor: ThemeColors.darkBg,
        foregroundColor: Colors.white, // Texto blanco
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: items.isEmpty
            ? const Center(
                child: Text(
                  'Tu carrito está vacío',
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeColors.textSecondary,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final ci = items[i];
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                ci.product.image,
                                width: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              ci.product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ThemeColors.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              'Cantidad: ${ci.quantity}',
                              style: const TextStyle(
                                color: ThemeColors.textSecondary,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$${(ci.product.price * ci.quantity).toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.search,
                                          color: ThemeColors.info),
                                      onPressed: () {
                                        // Acción: ver detalle del producto
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: ThemeColors.warning),
                                      onPressed: () => cart.removeSingle(ci.product.id),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          color: ThemeColors.error),
                                      onPressed: () =>
                                          cart.removeProduct(ci.product.id),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textPrimary,
                          ),
                        ),
                        Text(
                          '\$${cart.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Finalizar compra'),
                            content: Text(
                              '¿Deseas confirmar la compra por \$${cart.totalPrice.toStringAsFixed(0)}?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cart.clear();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Compra realizada. ¡Gracias!'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Confirmar'),
                              )
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.coralRed, // Botón naranja
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Realizar pedido',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
