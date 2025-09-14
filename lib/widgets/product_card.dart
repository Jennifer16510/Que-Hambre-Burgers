import 'package:flutter/material.dart';
import '../models/product.dart';
import '../design/themedata.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeColors.cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(product.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${product.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.freshGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Agregar', style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
