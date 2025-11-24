import 'package:flutter/material.dart';
import 'package:test_task/core/responsive/responsive.dart';
import 'package:test_task/features/home/data/model/products.dart';
import 'package:test_task/features/home/presentation/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Responsive.isMobile(context)
            ? GridView.builder(
                itemCount: mockProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = mockProducts[index];
                  return ProductCard(product: product);
                },
              )
            : GridView.builder(
                itemCount: mockProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isTablet(context) ? 3 : 4,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final product = mockProducts[index];
                  return ProductCard(product: product);
                },
              ),
      ),
    );
  }
}
