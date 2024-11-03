import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Provider/cart_provider.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Cart/checkout_screen.dart';

class CartPageDemo1 extends StatelessWidget {
  const CartPageDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartProduct = cartItems[index];
                      return Dismissible(
                        key: Key(cartProduct.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          cartProvider.removeFromCart(cartProduct);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${cartProduct.name} removed from cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://sntgold.microlanpos.com/${cartProduct.productImage}',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 55,
                                  ),
                                ),
                              ],
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  cartProduct.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  cartProduct.sizeWisePrice?.price?.first ??
                                      'N/A',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size: ${cartProduct.selectedSize}\n'
                                  'Carat: ${cartProduct.selectedCarat}\n'
                                  'Weight: ${cartProduct.selectedWeight}\n'
                                  'Quantity: ${cartProduct.quantity ?? 1}', // Use a default value if quantity is null
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        if ((cartProduct.quantity ?? 1) > 1) {
                                          // Ensure quantity is not null and greater than 1
                                          cartProvider.updateQuantity(
                                              cartProduct,
                                              (cartProduct.quantity ?? 1) - 1);
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cartProvider.updateQuantity(cartProduct,
                                            (cartProduct.quantity ?? 0) + 1);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, cartProduct, cartProvider);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CheckoutPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 110, 39),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Proceed to Checkout',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text('Your cart is empty',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Product product, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: Text(
              'Are you sure you want to remove ${product.name} from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cartProvider.removeFromCart(product);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} removed from cart'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
