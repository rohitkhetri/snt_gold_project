import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/new_product.dart'; // Ensure this path is correct

class newProduct_DetailPage extends StatefulWidget {
  final NewProduct newproductdetail; // Only using NewProduct

  const newProduct_DetailPage({
    super.key,
    required this.newproductdetail,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<newProduct_DetailPage> {
  String selectedSection = "Product Details"; // Default section

  // Function to handle section change
  void updateSection(String section) {
    setState(() {
      selectedSection = section; // Update the state to re-render the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic content based on the selected section
    Widget getContent() {
      switch (selectedSection) {
        case "Product Details":
          return Text(
            "Product Details Display Here.", // Replace with actual product details
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          );
        case "Description":
          // return Text(
          //   widget.newproductdetail.description, // Use actual description from NewProduct
          //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          // );
        case "Specifications":
          return Text(
            "Specifications here", // Add your specifications logic
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          );
        default:
          return const Text("");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.newproductdetail.image, // Ensure this is a valid path
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
              widget.newproductdetail.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "₹ ${widget.newproductdetail.price}", // Assuming price is a double
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text("Product Details"),
                    selected: selectedSection == "Product Details",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        updateSection("Product Details");
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("Description"),
                    selected: selectedSection == "Description",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        updateSection("Description");
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text("Specifications"),
                    selected: selectedSection == "Specifications",
                    onSelected: (isSelected) {
                      if (isSelected) {
                        updateSection("Specifications");
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Display the dynamic content based on the selected section
            getContent(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add to cart logic here
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Add to Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 110, 39),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
            const SizedBox(width: 16), // Space between buttons
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Buy now logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 110, 39),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
