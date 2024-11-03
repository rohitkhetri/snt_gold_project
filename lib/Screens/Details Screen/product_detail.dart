import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Cart/cart_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final Product productdetail;
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.productdetail,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSection = "Product Details";
  List<String> availableSizes = [];
  List<String> availableCarats = [];
  List<String> availableWeights = [];

  bool isFavorite = false;
  String? selectedSize;
  String? selectedCarat;
  String? selectedWeight;
  int selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    // Initialize available sizes, carats, and weights
    availableSizes =
        List<String>.from(widget.productdetail.sizeWisePrice?.size ?? []);
    availableCarats =
        List<String>.from(widget.productdetail.sizeWisePrice?.carat ?? []);
    availableWeights =
        List<String>.from(widget.productdetail.sizeWisePrice?.weight ?? []);
  }

  Future<void> fetchCaratWeightOptions(String sizeId) async {
    const url = 'https://sntgold.microlanpos.com/api/size-wise-carat-weight';
    final headers = {'Content-Type' : 'application/json'};
    // final body = jsonEncode({"size_id" : sizeId,"productId"})
  }


  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('wishlist') ?? [];

    if (isFavorite) {
      favoriteIds.remove(widget.productId.toString());
    } else {
      favoriteIds.add(widget.productId.toString());
    }

    await prefs.setStringList('wishlist', favoriteIds);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _addToCart(Product product) async {
    if (selectedSize == null ||
        selectedCarat == null ||
        selectedWeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please select size, carat, and weight before adding to the cart')),
      );
      return;
    }

    // Determine the product index based on the selected size
    int productIndex = availableSizes.indexOf(selectedSize!);

    final cartData = {
      "product": {
        product.productId.toString(): {
          "quantity": selectedQuantity,
          "product_index":
              productIndex, // Use dynamically determined product index
          "size": int.parse(selectedSize!), // Parse size to int
          "productId": product.productId,
        }
      }
    };

    final response = await http.post(
      Uri.parse('http://sntgold.microlanpos.com/api/add-product-in-cart'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cartData),
    );

    if (response.statusCode == 200) {
      // Store the cart data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', jsonEncode(cartData));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added to cart successfully')),
      );
    } else {
      print('Failed to add to cart: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add product to cart')),
      );
    }
  }

  // Method to get the current price or display the first price initially
  String getCurrentPrice() {
    if (selectedSize != null) {
      int index = availableSizes.indexOf(selectedSize!);
      if (index != -1 &&
          widget.productdetail.sizeWisePrice != null &&
          widget.productdetail.sizeWisePrice!.price != null &&
          index < widget.productdetail.sizeWisePrice!.price!.length) {
        double price =
            double.parse(widget.productdetail.sizeWisePrice!.price![index]);
        return '₹${(price * selectedQuantity).toStringAsFixed(2)}'; // Calculate price based on quantity
      }
    }

    // Display the first available price if no size is selected
    if (widget.productdetail.sizeWisePrice != null &&
        widget.productdetail.sizeWisePrice!.price != null &&
        widget.productdetail.sizeWisePrice!.price!.isNotEmpty) {
      return '₹${widget.productdetail.sizeWisePrice!.price!.first}';
    }

    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productdetail;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPageDemo1()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Card(
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.productImage != null &&
                              product.productImage!.isNotEmpty
                          ? 'https://sntgold.microlanpos.com/${product.productImage}'
                          : 'https://sntgold.microlanpos.com/product_images/1722993170.jpg',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: isFavorite ? Colors.red : Colors.black45,
                    ),
                    onPressed: toggleFavorite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: ${getCurrentPrice()}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                buildStarRating(product.productRating?.toDouble() ?? 0.0),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Reward points: ${product.rewardPoints}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Brand: ${product.brand}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Product Code: ${product.productCode}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Divider(),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("Description"),
                    selected: selectedSection == "Description",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        setState(() {
                          selectedSection = "Description";
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("Specifications"),
                    selected: selectedSection == "Specifications",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        setState(() {
                          selectedSection = "Specifications";
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            // selectedSection == "Description"
            //     ? Html(
            //         data: product.productDescription ??
            //             "<p>No description available</p>",
            //         style: {
            //           "p": Style(fontSize: const FontSize(16), color: Colors.grey),
            //         },
            //       )
            //     : Html(
            //         data: product.productSpecification ??
            //             "<p>No specification available</p>",
            //         style: {
            //           "p": Style(fontSize: const FontSize(16), color: Colors.grey),
            //         },
            //       ),
            // Row for Size and Carat
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    "Select Size",
                    availableSizes,
                    selectedSize,
                    (String? newValue) {
                      setState(() {
                        selectedSize = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDropdown(
                    "Select Carat",
                    availableCarats,
                    selectedCarat,
                    (String? newValue) {
                      setState(() {
                        selectedCarat = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row for Weight and Quantity
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    "Select Weight",
                    availableWeights,
                    selectedWeight,
                    (String? newValue) {
                      setState(() {
                        selectedWeight = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuantitySelector(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Add to Cart Button
            ElevatedButton.icon(
              onPressed: () => _addToCart(product),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        DropdownButton<String>(
          isExpanded: true,
          hint: Text(label),
          value: selectedValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quantity:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        DropdownButton<int>(
          value: selectedQuantity,
          items: List.generate(10, (index) => index + 1).map((int quantity) {
            return DropdownMenuItem<int>(
              value: quantity,
              child: Text(quantity.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              selectedQuantity = newValue ?? 1;
            });
          },
        ),
      ],
    );
  }
}
