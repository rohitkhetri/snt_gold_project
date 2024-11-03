import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Cart/cart_screen.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSection = "Product Details";
  final bool _isloading = false;

  Map<String, dynamic>? productData;
  bool _isLoading = true;
  List<String> availableSizeNames = [];
  String? selectedSize;
  List<String> availableCarats = [];
  List<String> availableWeights = [];
  String? displayedPrice;

  Map<String, int> sizeToAvailableQuantityMap =
      {}; // Maps each size to its available quantity
  int availableQuantity = 0; // Available quantity for the selected size
  int selectedQuantity = 0; // Quantity selected by the user

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sntgold.microlanpos.com/api/product-detail/${widget.productId}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer 262|bCyvmYITujiPle3E3XKCPkf0Jy1Kc97Sdm2ry1kmcfdf88dc",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['product_data'];
        List sizesList = responseData['size'];

        Map<String, String> sizeIdToNameMap = {
          for (var size in sizesList) size['id'].toString(): size['name']
        };

        if (responseData['product_details'][0]['size_wise_price'] != null) {
          Map<String, dynamic> sizeWisePrice =
              jsonDecode(responseData['product_details'][0]['size_wise_price']);
          List<String> sizeIds = List<String>.from(sizeWisePrice['size']);
          List<String> priceList = List<String>.from(sizeWisePrice['price']);
          List<int> quantityList = List<int>.from(sizeWisePrice['quantity']);

          availableSizeNames = [
            for (String sizeId in sizeIds)
              if (sizeIdToNameMap.containsKey(sizeId)) sizeIdToNameMap[sizeId]!
          ];

          // Map each size to its available quantity
          for (int i = 0; i < sizeIds.length; i++) {
            String sizeId = sizeIds[i];
            sizeToAvailableQuantityMap[sizeId] = quantityList[i];
          }

          if (availableSizeNames.isNotEmpty) {
            displayedPrice = priceList[0];
            availableQuantity = sizeToAvailableQuantityMap[sizeIds[0]] ?? 0;
          }
        }

        setState(() {
          productData = responseData;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching product details: $e")),
      );
    }
  }

  Future<void> _fetchCaratsAndWeights(String sizeId) async {
    try {
      final response = await http.post(
        Uri.parse('https://sntgold.microlanpos.com/api/size-wise-carat-weight'),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer 262|bCyvmYITujiPle3E3XKCPkf0Jy1Kc97Sdm2ry1kmcfdf88dc",
        },
        body: jsonEncode({
          "size_id": int.parse(sizeId),
          "productId": widget.productId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List caratsList = data['accroding_size_data']['carat'];
        List weightsList = data['accroding_size_data']['weight'];

        availableCarats =
            List<String>.from(caratsList.map((item) => item['name']));
        availableWeights =
            List<String>.from(weightsList.map((item) => item['name']));

        Map<String, dynamic> sizeWisePrice =
            jsonDecode(productData!['product_details'][0]['size_wise_price']);
        List<String> priceList = List<String>.from(sizeWisePrice['price']);
        List<String> sizeIds = List<String>.from(sizeWisePrice['size']);

        int index = sizeIds.indexOf(sizeId);
        if (index != -1) {
          displayedPrice = priceList[index];
          availableQuantity = sizeToAvailableQuantityMap[sizeId] ?? 0;
          // selectedQuantity = null; // Reset selected quantity
        } else {
          displayedPrice = null;
          availableQuantity = 0;
        }

        setState(() {});
      } else {
        throw Exception('Failed to fetch carats and weights');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching carats and weights: $e")),
      );
    }
  }

  void incrementQuantity() {
    if (selectedQuantity < availableQuantity) {
      setState(() {
        selectedQuantity++;
      });
    }
  }

  // Function to decrement selected quantity safely
  void decrementQuantity() {
    if (selectedQuantity > 1) {
      setState(() {
        selectedQuantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_isloading){
      return const Center(child: CircularProgressIndicator());
    }
    
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
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: productData!['product_Media'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          'https://sntgold.microlanpos.com/${productData!['product_Media'][index]['image']}',
                          fit: BoxFit.fitHeight,
                          width: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Positioned(
                // right: 10,
                // top: 10,
                // child: IconButton(
                //   icon: Icon(
                //     Icons.favorite,
                //     size: 30,
                //     color: isFavorite ? Colors.red : Colors.black45,
                //   ),
                //   // onPressed: toggleFavorite,
                // ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              productData!['product_details'][0]['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: $displayedPrice',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                // buildStarRating(productData.productRating?.toDouble() ?? 0.0),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Reward points: ${productData!['product_details'][0]['Reward_points']}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Brand: ${productData!['product_details'][0]['brand']}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Product Code: ${productData!['product_details'][0]['product_code']}',
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

            selectedSection == "Description"
                ? Html(
                    data: productData!['product_details'][0]
                            ['product_description'] ??
                        "<p>No description available</p>",
                    style: {
                      "p": Style(fontSize: const FontSize(16), color: Colors.grey),
                    },
                  )
                : Html(
                    data: productData!['product_details'][0]
                            ['product_specification'] ??
                        "<p>No specification available</p>",
                    style: {
                      "p": Style(fontSize: const FontSize(16), color: Colors.grey),
                    },
                  ),

            // Row for Size and Carat
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    "Select Size",
                    availableSizeNames,
                    selectedSize,
                    (String? newValue) {
                      setState(() {
                        selectedSize = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Expanded(
                //   child: _buildDropdown(
                //     "Select Carat",
                //     availableCarats,
                //     selectedCarat,
                //     (String? newValue) {
                //       setState(() {
                //         selectedCarat = newValue;
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 10),

            // Row for Weight and Quantity
            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildDropdown(
            //         "Select Weight",
            //         availableWeights,
            //         selectedWeight,
            //         (String? newValue) {
            //           setState(() {
            //             selectedWeight = newValue;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(width: 16),
            //     Expanded(
            //       child: _buildQuantitySelector(),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),

            // Add to Cart Button
            // ElevatedButton.icon(
            // onPressed: () => _addToCart(product),
            // icon: const Icon(Icons.add_shopping_cart),
            // label: const Text("Add to Cart"),
            // style: ElevatedButton.styleFrom(
            // minimumSize: const Size(double.infinity, 50),
            // ),
            // ),
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
          hint: const Text("Choose a size"),
          value: selectedSize,
          isExpanded: true,
          items: availableSizeNames.map((String sizeName) {
            return DropdownMenuItem<String>(
              value: sizeName,
              child: Text(sizeName),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedSize = newValue;
              final sizeId = availableSizeNames.indexOf(newValue!) + 1;
              _fetchCaratsAndWeights(sizeId.toString());
            });
          },
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
