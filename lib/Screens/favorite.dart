import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Model/favorite_model.dart';
import 'package:snt_gold_project/Provider/FavoriteProvider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<Favoriteprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Colors.amber[600],
      ),
      body: favoritesProvider.favorites.isEmpty
      ? const Center(
        child: Text('No favorites yet.'),
      )
      : Padding(padding: const EdgeInsets.all(16.0),
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.66),
        
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index){
          final product = favoritesProvider.favorites[index];
          return ProductCard(
            product: product,
            onRemove: (){
          favoritesProvider.removeFavorite(product);
        },
        );
        },
      ),
    ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final FavoriteProduct product;
  final VoidCallback onRemove;

  const ProductCard({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, height: 120, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,  // Using 'name' from FavoriteModel
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${product.price}',  // Using 'price' from FavoriteModel
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4.0),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: onRemove,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}