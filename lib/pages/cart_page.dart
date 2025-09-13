import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items.values.toList();

    return Scaffold( //título "Carrito" y tambien uso color verde oscuro
      appBar: AppBar(title: Text('Carrito'), backgroundColor: Colors.green[800]),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: items.isEmpty  //Si no hay productos, se muestra un mensaje centrado
            ? Center(child: Text('Tu carrito está vacío'))
            : Column( // cuando hay productos 
                children: [
                  Expanded(
                    child: ListView.builder( //genera  la lista de productos en el carrito.
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final ci = items[i];
                        return Card( // muestra los producto en una tarjeta
                          child: ListTile(
                            leading: Image.asset(ci.product.image, width: 56, fit: BoxFit.cover), // imagen de los productos
                            title: Text(ci.product.name), // nombre del producto
                            subtitle: Text('Cantidad: ${ci.quantity}'), //cantidad del carrito
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('\$${(ci.product.price * ci.quantity).toStringAsFixed(0)}'),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(icon: Icon(Icons.remove_circle_outline), onPressed: () => cart.removeSingle(ci.product.id)),// quita una unidad
                                    IconButton(icon: Icon(Icons.delete_outline), onPressed: () => cart.removeProduct(ci.product.id)), //elimina por completo
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Padding( // diseño y total de los productos 
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${cart.totalPrice.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(  // "Finalizar compra"
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Simulación de compra
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Finalizar compra'),
                            content: Text('¿Deseas confirmar la compra por \$${cart.totalPrice.toStringAsFixed(0)}?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
                              ElevatedButton(
                                onPressed: () {
                                  cart.clear();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compra realizada. Gracias!')));
                                  Navigator.of(context).pop(); // vuelve a la pantalla anterior
                                },
                                child: Text('Confirmar'),
                              )
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14)),
                      child: Text('Finalizar compra'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
