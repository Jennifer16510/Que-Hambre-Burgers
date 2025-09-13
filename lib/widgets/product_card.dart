import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(product.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(product.description, style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${product.price.toStringAsFixed(0)}', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('+', style: TextStyle(fontSize: 25)),
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
