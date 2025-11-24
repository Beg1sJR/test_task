import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/features/products/data/model/products.dart';
import 'package:test_task/features/products/presentation/logic/bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(LoadProducts());
    _searchController.addListener(_onSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Товары'),
            IconButton(onPressed: _showAddProductDialog, icon: Icon(Icons.add)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Поиск товара',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    final products = _searchController.text.isEmpty
                        ? state.products
                        : _filteredProducts;
                    if (products.isEmpty) {
                      return const Center(child: Text('Нет товаров'));
                    }
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        final product = products[index];
                        return Card(
                          child: ListTile(
                            title: Text(product.name ?? 'Нет названия'),
                            subtitle: Text(
                              product.description ?? 'Нет описания',
                            ),
                            trailing: Text(
                              '${product.price?.toStringAsFixed(2)} \$',
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearch() {
    final state = context.read<ProductsBloc>().state;
    if (state is ProductsLoaded) {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredProducts = state.products
            .where((p) => p.name!.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  void _showAddProductDialog() {
    final theme = Theme.of(context);
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Add Product',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Создать товар',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Название',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Цена',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final desc = descriptionController.text.trim();
                      final price =
                          double.tryParse(priceController.text.trim()) ?? 0;
                      if (name.isEmpty || desc.isEmpty || price <= 0) return;

                      context.read<ProductsBloc>().add(
                        AddProduct(
                          product: ProductModel(
                            name: name,
                            description: desc,
                            price: price,
                          ),
                        ),
                      );
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.tertiary,
                    ),

                    child: Text(
                      'Создать',
                      style: TextStyle(color: theme.colorScheme.inversePrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }
}
