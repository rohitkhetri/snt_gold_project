import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Categories/sub_category_productlist.dart';

// Main Category List Widget
class CategoryList extends StatelessWidget {
  final List<CategoryModel> demoCategories = [
    CategoryModel(
      title: "Rings",
      img: 'assets/ring.jpg',
      subcategories: [
        Subcategory(id: 1, name: "Diamond Rings", image: 'assets/diamong_ring.png'),
        Subcategory(id: 2, name: "Gold Rings", image: 'assets/gold_ring.webp'),
        Subcategory(id: 3, name: "Platinum Rings", image: 'assets/platinum_ring.png'),
      ],
    ),
    CategoryModel(
      title: "Pendants",
      img: 'assets/pendants.jpeg',
      subcategories: [
        Subcategory(id: 5, name: "Gold Pendants", image: 'assets/pendant.webp'),
        Subcategory(id: 7, name: "Silver Pendants", image: 'assets/silver_pendant.png'),
        Subcategory(id: 8, name: "Diamond Pendants", image: 'assets/diamong_pendant.png'),
      ],
    ),
  ];

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: demoCategories.length,
      itemBuilder: (context, index) {
        return CategoryTile(category: demoCategories[index]);
      },
    );
  }
}
class CategoryTile extends StatefulWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  // List<Product> _products = []; // To store fetched products
  bool _isLoading = false; // To manage loading state

  // Function to fetch products for a specific subcategory
  Future<List<Product>> _fetchProducts(int subcategoryId) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if(token != null){
      final response = await http.get(
        Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> productsJson = data['product'];

        // Filter products based on the subcategory ID
        List<dynamic> filteredProducts = productsJson.where((json) {
          return json['sub_category'] == subcategoryId.toString(); // Match category ID
        }).toList();

        return filteredProducts.map((json) => Product.fromJson(json)).toList();
      }
      } else {
        throw Exception("No token found");
      }
    } catch (e) {
      print("Error fetching products: $e");
      // setState(() {
      //   _isLoading = false;
      // });
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ExpansionTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              widget.category.img,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            widget.category.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: widget.category.subcategories.map((subcategory) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  subcategory.image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                subcategory.name,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              onTap: () async {
                setState(() {
                  _isLoading = true; // Start loading
                });
                try {
                  // Fetch products for the selected subcategory
                  List<Product> products = await _fetchProducts(subcategory.id);

                  // Navigate to the product list page with the fetched products
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductList(
                        category: widget.category.title,
                        subcategory: subcategory.name,
                        products: products, categoryId: '',
                      ),
                    ),
                  );
                } catch (e) {
                  print('Error fetching products: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load products')),
                  );
                } finally {
                  setState(() {
                    _isLoading = false; // End loading
                  });
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}