import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';
import 'package:snt_gold_project/Provider/cart_provider.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/cart.dart';

// Assuming SizeWisePrice is defined somewhere in your code
class SizesWisePrice {
  final List<String>? price;

  SizesWisePrice({this.price});
}

class ProductDetailPage extends StatefulWidget {
  final Product productdetail;
  final int productId;

  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productdetail,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSection = "Product Details"; // Default section
  List<String> availableSizes = [];
  List<String> availableCarats = [];
  List<String> availableWeights = [];
  // List<CartProduct> _cartItems = []; // List to store cart items

  String? selectedSize;
  String? selectedCarat;
  String? selectedWeight;
  bool isLoading = true;
  bool isAvailable = false;

  late String productDetailApiURL;
  final String availabilityApiURL =
      "https://sntgold.microlanpos.com/api/check-product-availability";

  @override
  void initState() {
    super.initState();
    productDetailApiURL =
        "https://sntgold.microlanpos.com/api/product-detail/${widget.productId}";
    fetchProductDetails();
  }

  // Fetch size, carat, and weight details dynamically from API
  Future<void> fetchProductDetails() async {
    try {
      final response = await http.get(Uri.parse(productDetailApiURL));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['product_data'];

        setState(() {
          availableSizes = List<String>.from(data['size'].map((item) => item['name']));
          availableCarats = List<String>.from(data['carat'].map((item) => item['name']));
          availableWeights = List<String>.from(data['weight'].map((item) => item['name']));

          List<String> prices = List<String>.from(data['size'].map((item) => item['price']));
          widget.productdetail.sizeWisePrice = SizeWisePrice(price: prices); // Update the product with prices
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Check product availability
  Future<void> checkAvailability() async {
    if (selectedSize == null || selectedCarat == null || selectedWeight == null) {
      return; // Skip availability check if any option is not selected
    }

    try {
      final response = await http.post(
        Uri.parse(availabilityApiURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'carat_id': availableCarats.indexOf(selectedCarat!) + 1,
          'weight_id': availableWeights.indexOf(selectedWeight!) + 1,
          'size_id': availableSizes.indexOf(selectedSize!) + 1,
          'productId': widget.productId
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          isAvailable = data['isAvailable'];
        });
      } else {
        throw Exception('Failed to check product availability');
      }
    } catch (error) {
      print('Error checking product availability: $error');
    }
  }

  void _addToCart(Product product) {
  if (selectedSize == null || selectedCarat == null || selectedWeight == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select size, carat, and weight before adding to the cart')),
    );
    return;
  }

  // CartProduct cartProduct = CartProduct(
  //   product: product,
  //   selectedSize: selectedSize,
  //   selectedCarat: selectedCarat,
  //   selectedWeight: selectedWeight,
  //   price: getCurrentPrice(),
  // );

  // Add to the cart using Provider
  // Provider.of<CartProvider>(context, listen: false).addToCart(cartProduct);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${product.name} added to cart!')),
  );
}

  String getCurrentPrice() {
    if (selectedSize != null) {
      int index = availableSizes.indexOf(selectedSize!);
      return index != -1 ? '₹${widget.productdetail.sizeWisePrice?.price![index]}' : 'N/A';
    }
    return 'N/A';
  }

  void _buyNow(Product product) {
    // Implement your buy now logic here
    print("Buying ${product.name}");
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productdetail;

    // Show loading spinner while fetching product details
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://sntgold.microlanpos.com/${product.productImage}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  right: 10,
                  top: 10,
                  child: Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.black45,
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
            Text(
              'Price: ${getCurrentPrice()}',

              // 'Price: ₹${product.sizeWisePrice?.price?.first ?? 'N/A'}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),

            // Chips for section selection
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("Product Details"),
                    selected: selectedSection == "Product Details",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        setState(() {
                          selectedSection = "Product Details";
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
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
            const SizedBox(height: 16),

            // Content based on selected section
            selectedSection == "Product Details"
                ? Html(data: product.productDescription ?? "No product details available")
                : selectedSection == "Description"
                    ? const Text("Description here", style: TextStyle(fontSize: 16, color: Colors.grey))
                    : Html(data: product.productSpecification ?? "No specifications available"),

            const SizedBox(height: 16),

            // Size, Carat, Weight selection
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Select Size:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  hint: const Text("Choose Size"),
                  value: selectedSize,
                  items: availableSizes.map((String size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSize = value;
                    });
                    checkAvailability();
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Carat and Weight Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "Select Carat:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        hint: const Text("Carat"),
                        value: selectedCarat,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCarat = newValue;
                          });
                          checkAvailability();
                        },
                        items: availableCarats.map((String carat) {
                          return DropdownMenuItem<String>(
                            value: carat,
                            child: Text(carat),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "Select Weight:",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        hint: const Text("Choose Weight"),
                        value: selectedWeight,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWeight = newValue;
                          });
                          checkAvailability();
                        },
                        items: availableWeights.map((String weight) {
                          return DropdownMenuItem<String>(
                            value: weight,
                            child: Text(weight),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Availability status message
            const SizedBox(height: 16),
            if (isAvailable)
              const Text(
                "Product is available",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            if (!isAvailable && selectedSize != null && selectedCarat != null && selectedWeight != null)
              const Text(
                "Product is not available",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            // const SizedBox(height: 20),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                      _addToCart(product);
                  },
                  child: const Text("Add to Cart"),
                ),
                ElevatedButton(
                  onPressed: () {
                      _buyNow(product);
                  } ,
                  child: const Text("Buy Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
