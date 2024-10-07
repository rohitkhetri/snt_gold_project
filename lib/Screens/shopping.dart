import 'package:flutter/material.dart';
import 'package:snt_gold_project/Dashboard/shopping.dart';
import 'package:snt_gold_project/Model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';
import 'package:snt_gold_project/Screens/product_detail.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
_ShoppingPageState createState() => _ShoppingPageState();

}

class _ShoppingPageState extends State<ShoppingPage> {
  int _selectedSortOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Gold Jewellery || 0% off on M..."),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FilterScreen()),);
          },
          icon: const Icon(Icons.filter_list)),
          IconButton(onPressed: () => showSortBottomSheet(context),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
            // Additional content can go here
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7, // Adjust to fit your design
              ),
              itemCount: allProducts.length, // The number of jewelry items
              shrinkWrap: true, // Use shrinkWrap to prevent size issues
              physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
              itemBuilder: (context, index) {
                final product = allProducts[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                        (context)=> ProductDetailPage(productdetail: product,)),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              product.imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Positioned(
                            //   top: 8,
                            //   left: 8,
                            //   child: Container(
                            //     color: Colors.amber,
                            //     child: const Text("PURE GOLD"),
                            //   ),
                            // ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "₹${product.price}",
                          style: const TextStyle(
                            color: Colors.redAccent,
                          ),
                          )
                          
                        ),
                        const Spacer(), // Pushes the button to the bottom
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity, // Full width button
                            child: TextButton(
                              onPressed: () {
                                // Add to Cart
                                Provider.of<CartModel>(context, listen: false).addItem({
                                  "name": product.name,
                                  "price": product.price,
                                  "image": product.imageUrl,
                                  "quantity": 1,
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 182, 148, 45),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(10),
                                
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text("Add To Cart"),
                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Price (lowest first)'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Relevance'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Discount'),
                leading: Radio<int>(
                  value: 3,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Price (highest first)'),
                leading: Radio<int>(
                  value: 4,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('What\'s New'),
                leading: Radio<int>(
                  value: 5,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

