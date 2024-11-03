// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductDetailPageDemo extends StatefulWidget {
//   final int productId;

//   const ProductDetailPageDemo({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);

//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPageDemo> {
//   Map<String, dynamic>? productData;
//   bool _isLoading = true;
//   List<String> availableSizeNames = [];
//   String? selectedSize; // Variable to hold the selected size
//   List<String> availableCarats = [];
//   List<String> availableWeights = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }

//   Future<void> _fetchProductDetails() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://sntgold.microlanpos.com/api/product-detail/${widget.productId}'),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer 262|bCyvmYITujiPle3E3XKCPkf0Jy1Kc97Sdm2ry1kmcfdf88dc",
//         },
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body)['product_data'];
//         List sizesList = responseData['size'];

//         // Create a map of size IDs to names
//         Map<String, String> sizeIdToNameMap = {
//           for (var size in sizesList) size['id'].toString(): size['name']
//         };

//         // Parse available sizes from size_wise_price without filtering by quantity
//         if (responseData['product_details'][0]['size_wise_price'] != null) {
//           Map<String, dynamic> sizeWisePrice = jsonDecode(responseData['product_details'][0]['size_wise_price']);
//           List<String> sizeIds = List<String>.from(sizeWisePrice['size']);

//           // Get all size names corresponding to the size IDs
//           availableSizeNames = [
//             for (String sizeId in sizeIds)
//               if (sizeIdToNameMap.containsKey(sizeId)) sizeIdToNameMap[sizeId]!
//           ];
//         }

//         setState(() {
//           productData = responseData;
//           _isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load product details');
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching product details: $e")),
//       );
//     }
//   }

//   Future<void> _fetchCaratsAndWeights(String sizeId) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sntgold.microlanpos.com/api/size-wise-carat-weight'),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer 262|bCyvmYITujiPle3E3XKCPkf0Jy1Kc97Sdm2ry1kmcfdf88dc",
//         },
//         body: jsonEncode({
//           "size_id": int.parse(sizeId), // Pass the selected size ID
//           "productId": widget.productId,  // Pass the product ID from the widget
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         List caratsList = data['accroding_size_data']['carat'];
//         List weightsList = data['accroding_size_data']['weight'];

//         // Map carats and weights to their string values
//         availableCarats = List<String>.from(caratsList.map((item) => item['name']));
//         availableWeights = List<String>.from(weightsList.map((item) => item['name']));

//         setState(() {});
//       } else {
//         throw Exception('Failed to fetch carats and weights');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching carats and weights: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Product Details")),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : productData != null
//               ? Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         productData!['product_details'][0]['name'] ?? "Product Name",
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         productData!['product_details'][0]['product_description'] ?? "Description not available",
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         "Select Size:",
//                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 5),
//                       DropdownButton<String>(
//                         hint: const Text("Choose a size"),
//                         value: selectedSize,
//                         isExpanded: true,
//                         items: availableSizeNames.map((String sizeName) {
//                           return DropdownMenuItem<String>(
//                             value: sizeName,
//                             child: Text(sizeName),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedSize = newValue; // Update selected size
//                             // Fetch carats and weights for the selected size
//                             final sizeId = availableSizeNames.indexOf(newValue!) + 1; // Adjust based on your size ID mapping
//                             _fetchCaratsAndWeights(sizeId.toString());
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       if (availableCarats.isNotEmpty) ...[
//                         Text(
//                           "Available Carats:",
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         ...availableCarats.map((carat) => Text(carat)).toList(),
//                       ],
//                       if (availableWeights.isNotEmpty) ...[
//                         const SizedBox(height: 20),
//                         Text(
//                           "Available Weights:",
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         ...availableWeights.map((weight) => Text(weight)).toList(),
//                       ],
//                     ],
//                   ),
//                 )
//               : const Center(child: Text("Product details not available")),
//     );
//   }
// }
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/models_of_products.dart';

class ProductDetailPageDemo extends StatefulWidget {
  final int productId;

  const ProductDetailPageDemo({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPageDemo> {
  Map<String, dynamic>? productData;
  bool _isLoading = true;
  List<String> availableSizeNames = [];
  List<int> availableQuantities = [];

  Map<String, Map<String, dynamic>> uniqueSizes = {};
  String? selectedSize;
  List<Carat> availableCarats = [];
  List<Weight> availableWeights = [];
  String? displayedPrice;
  int availableQuantity = 0;
  int? selectedCaratId;
  int? selectedWeightId;
  bool? isProductAvailable;
  int? selectedQuantity;

  String? selectedOption;

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

        for (var size in sizesList) {
          String sizeId = size['id'].toString();
          String sizeName = size['name'];
          uniqueSizes[sizeId] = {'name': sizeName, 'price': '', 'quantity': 0};
        }

        if (responseData['product_details'][0]['size_wise_price'] != null) {
          Map<String, dynamic> sizeWisePrice =
              jsonDecode(responseData['product_details'][0]['size_wise_price']);
          List<String> sizeIds = List<String>.from(sizeWisePrice['size']);
          List<String> priceList = List<String>.from(sizeWisePrice['price']);
          List<int> quantityList = List<int>.from(sizeWisePrice['quantity']);

          for (int i = 0; i < sizeIds.length; i++) {
            if (uniqueSizes.containsKey(sizeIds[i])) {
              uniqueSizes[sizeIds[i]]!['price'] = priceList[i];
              uniqueSizes[sizeIds[i]]!['quantity'] = quantityList[i];
            }
          }
        }

        availableSizeNames = uniqueSizes.values
            .where((size) => size['quantity'] > 0)
            .map((size) => size['name'] as String)
            .toList();

        if (availableSizeNames.isNotEmpty) {
          displayedPrice = uniqueSizes[uniqueSizes.keys
              .firstWhere((id) => uniqueSizes[id]!['quantity'] > 0)]?['price'];
          availableQuantity = uniqueSizes[uniqueSizes.keys
                  .firstWhere((id) => uniqueSizes[id]!['quantity'] > 0)]
              ?['quantity'];
        }

        availableQuantities =
            List.generate(availableQuantity, (index) => index + 1);

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
        body: jsonEncode(
            {"size_id": int.parse(sizeId), "productId": widget.productId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List caratsList = data['accroding_size_data']['carat'];
        List weightsList = data['accroding_size_data']['weight'];

        availableCarats =
            List<Carat>.from(caratsList.map((item) => Carat.fromJson(item)));
        availableWeights =
            List<Weight>.from(weightsList.map((item) => Weight.fromJson(item)));

        setState(() {
          selectedCaratId = null;
          selectedWeightId = null;
          isProductAvailable = null;
        });
      } else {
        throw Exception('Failed to fetch carats and weights');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching carats and weights: $e")),
      );
    }
  }

  Future<void> _checkProductAvailability(
      String sizeId, String caratId, String weightId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://sntgold.microlanpos.com/api/check-product-availability'),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer 262|bCyvmYITujiPle3E3XKCPkf0Jy1Kc97Sdm2ry1kmcfdf88dc",
        },
        body: jsonEncode({
          "carat_id": int.parse(caratId),
          "weight_id": int.parse(weightId),
          "size_id": int.parse(sizeId),
          "productId": widget.productId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          isProductAvailable = data['data']['available'];
        });
      } else {
        throw Exception('Failed to check product availability');
      }
    } catch (e) {
      setState(() {
        isProductAvailable = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error checking product availability: $e")),
      );
    }
  }

  void _incrementQuantity() {
    setState(() {
      selectedQuantity = (selectedQuantity ?? 0) + 1;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (selectedQuantity! > 1) {
        selectedQuantity = (selectedQuantity ?? 0) - 1;
      }
    });
  }

  void _onSizeSelected(String newSize) {
    setState(() {
      selectedSize = newSize;
      selectedCaratId = null;
      selectedWeightId = null;
      isProductAvailable = null;
      selectedQuantity = null;
    });
    final sizeId = uniqueSizes.keys
        .firstWhere((id) => uniqueSizes[id]!['name'] == newSize);
    displayedPrice = uniqueSizes[sizeId]?['price'];
    availableQuantity = uniqueSizes[sizeId]?['quantity'];

    availableQuantities =
        List.generate(availableQuantity, (index) => index + 1);

    if (availableQuantities.isNotEmpty) {
      selectedQuantity = availableQuantities.first;
    }

    _fetchCaratsAndWeights(sizeId);
  }

  @override
  Widget build(BuildContext context) {
    var productDetails = productData!['product_details'][0];
    String description =
        productDetails['product_description'] ?? "No description available.";
    String specifications = productDetails['product_specification'] ??
        "No specifications available.";

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : productData != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 200,
                          child: PageView.builder(
                            itemCount: productData!['product_Media'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.network(
                                  'https://sntgold.microlanpos.com/${productData!['product_Media'][index]['image']}',
                                  fit: BoxFit.fitHeight,
                                  width: 150,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Icon(Icons.error));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          productData!['product_details'][0]['name'] ??
                              "Product Name",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Text(
                        //   productData!['product_details'][0]
                        //           ['product_specification'] ??
                        //       "Product Name",
                        //   style: const TextStyle(
                        //     fontSize: 22,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 10),
                        // Text(
                        //   productData!['product_details'][0]
                        //           ['product_specification'] ??
                        //       "Product Name",
                        //   style: const TextStyle(
                        //     fontSize: 22,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        buildStarRating((productData!['product_details'][0]
                                ['product_rating'] as num)
                            .toDouble()),
                        const Divider(),
                        Text("₹${displayedPrice ?? "0"}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Wrap(
                              spacing: 8,
                              children: [
                                ChoiceChip(
                                  label: const Text("Description"),
                                  selected: selectedOption == "description",
                                  onSelected: (isSelected) {
                                    setState(() {
                                      selectedOption =
                                          isSelected ? "description" : null;
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text("Specifications"),
                                  selected: selectedOption == "specifications",
                                  onSelected: (isSelected) {
                                    setState(() {
                                      selectedOption =
                                          isSelected ? "specifications" : null;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Displaying content based on selection
                        if (selectedOption == "description")
                          Html(data:
                            description,
                            // style: const TextStyle(fontSize: 16),
                          )
                        else if (selectedOption == "specifications")
                          Html(data:
                            specifications,
                            // style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                        Row(
                          children: [
                            // const Text(
                            //   "Product Details",
                            //   style: TextStyle(
                            //       fontSize: 24, fontWeight: FontWeight.bold),
                            // ),
                            // const SizedBox(height: 10),
                            // ChoiceChip for Description and Specifications

                            // Size selection
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Select Size",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // const SizedBox(height: 10),
                                  // This widget creates a custom dropdown with ChoiceChips inside
                                  DropdownButton<String>(
                                    value:
                                        selectedSize, // Currently selected size
                                    items: availableSizeNames.map((sizeName) {
                                      return DropdownMenuItem<String>(
                                        value: sizeName,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(sizeName),
                                            // Display a choice chip-like style if needed
                                            if (selectedSize == sizeName)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                // child: ChoiceChip(
                                                //   label: Text(sizeName),
                                                //   selected: true,
                                                //   onSelected: (_) {}, // No action needed here
                                                // ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newSize) {
                                      setState(() {
                                        selectedSize = newSize!;
                                        _onSizeSelected(
                                            newSize); // Handle size selection
                                      });
                                    },
                                    hint: const Text(
                                        'Select Size'), // Hint text when nothing is selected
                                  ),
                                ],
                              ),
                            ),

                            // Quantity selection
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Select Quantity",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButton<int>(
                                    value: selectedQuantity,
                                    items: availableQuantities
                                        .map((quantity) =>
                                            DropdownMenuItem<int>(
                                              value: quantity,
                                              child: Text(quantity.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (newQuantity) {
                                      setState(() {
                                        selectedQuantity = newQuantity;
                                      });
                                    },
                                    hint: const Text('Select Quantity'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (availableCarats.isNotEmpty) ...[
                          const Text(
                            "Select Carat",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Wrap(
                            spacing: 8,
                            children: availableCarats.map((carat) {
                              return ChoiceChip(
                                label: Text("${carat.name}"),
                                selected: selectedCaratId == carat.id,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCaratId =
                                        selected ? carat.id : null;
                                  });
                                  if (selectedCaratId != null &&
                                      selectedWeightId != null) {
                                    _checkProductAvailability(
                                      uniqueSizes.keys.firstWhere((id) =>
                                          uniqueSizes[id]!['name'] ==
                                          selectedSize),
                                      selectedCaratId.toString(),
                                      selectedWeightId.toString(),
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                        ],
                        if (availableWeights.isNotEmpty) ...[
                          const Text(
                            "Select Weight",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Wrap(
                            spacing: 8,
                            children: availableWeights.map((weight) {
                              return ChoiceChip(
                                label: Text("${weight.name} g"),
                                selected: selectedWeightId == weight.id,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedWeightId =
                                        selected ? weight.id : null;
                                  });
                                  if (selectedCaratId != null &&
                                      selectedWeightId != null) {
                                    _checkProductAvailability(
                                      uniqueSizes.keys.firstWhere((id) =>
                                          uniqueSizes[id]!['name'] ==
                                          selectedSize),
                                      selectedCaratId.toString(),
                                      selectedWeightId.toString(),
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                        ],
                        // const Text(
                        //   "Select Quantity",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w600),
                        // ),
                        // DropdownButton<int>(
                        //   value: selectedQuantity,
                        //   items: availableQuantities
                        //       .map((quantity) => DropdownMenuItem<int>(
                        //             value: quantity,
                        //             child: Text(quantity.toString()),
                        //           ))
                        //       .toList(),
                        //   onChanged: (newQuantity) {
                        //     setState(() {
                        //       selectedQuantity = newQuantity;
                        //     });
                        //   },
                        //   hint: const Text('Select Quantity'),
                        // ),
                        const SizedBox(height: 10),
                        if (isProductAvailable != null)
                          Text(
                            isProductAvailable == true
                                ? "Available in stock"
                                : "Out of stock",
                            style: TextStyle(
                              color: isProductAvailable == true
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Add to cart logic
                              },
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text("Add to Cart"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Buy now logic
                              },
                              icon: const Icon(Icons.shopping_bag),
                              label: const Text("Buy Now"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: Text("Product not found")),
    );
  }
}
