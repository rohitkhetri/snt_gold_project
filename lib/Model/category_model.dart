import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryList extends StatelessWidget {
  List<CategoryModel> demoCategories = [
    CategoryModel(
      title: "Rings",
      img: 'assets/ring.jpg',
      subcategories: {
        "Diamond Rings": 'assets/diamong_ring.png',
        "Gold Rings": 'assets/gold_ring.webp',
        "Platinum Rings" : 'assets/platinum_ring.png'}),
    CategoryModel(
      title: "Pendants",
      img: 'assets/pendants.jpeg',
      subcategories:{
        "Gold Pendants":'assets/pendant.webp',
        "Silver Pendants":'assets/silver_pendant.png',
        "Diamond Pendants":'assets/diamong_pendant.png'}),
    CategoryModel(
      title:"NosePins",
      img: 'assets/nosepin_gold.png',
      subcategories:{
        "Diamond Nosepins":'assets/nosepin_diamond.png',
        "Gold Nosepins": 'assets/nosepin_gold.png'}),
    CategoryModel(
      title: "Earrings",
      img: 'assets/earring_gold.png',
      subcategories:{
        "Gold Earrings": 'assets/earring_gold1.png',
        "Diamond Earrings": 'assets/earring_diamond.png'}),
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


class CategoryModel {
  final String title;
  //final IconData icon;
  final String img;
  final Map<String, String> subcategories;

  CategoryModel({
    required this.img,
    required this.title,
    required this.subcategories});
}


class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

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
              category.img,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ), // Display the respective image for each category
          ),
          title: Text(
            category.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: category.subcategories.entries.map((entry){
            String subcategory = entry.key;
            String subcategoryImage = entry.value;
            return ListTile(
              leading: ClipRRect(borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                subcategoryImage,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),),
              title: Text(
                subcategory,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              onTap: () {
                List<Product> products = getStaticProductsForSubcategory(subcategory);
                //print("Tapped on $subcategory in ${category.title}");
                Navigator.push(context,
                MaterialPageRoute(builder:
                (context) => ProductListPage(
                  category: category.title,
                  subcategory: subcategory,
                  products: products,
                ),
                ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
  
  List<Product> getStaticProductsForSubcategory(String subcategory) {
    Map<String, List<Product>> productData = {
      "Diamond Rings": [
        Product(name: "Diamond Ring A", price: 499.99, imageUrl: 'assets/ring.jpg'),
        Product(name: "Diamond Ring B", price: 599.99, imageUrl: 'assets/ring.jpg'),
      ],
      "Gold Rings": [
        Product(name: "Gold Ring B", price: 399.99, imageUrl: 'assets/ring.jpg'),
      ],
      "Platinum Rings": [
        Product(name: "Platinum Ring A", price: 999.99, imageUrl: 'assets/ring.jpg'),
      ],
      "Gold Pendants": [
        Product(name: "Gold Pendant A", price: 199.99, imageUrl: 'assets/ring.jpg'),
      ],
      "Silver Pendants": [
        Product(name: "Silver Pendant A", price: 99.99, imageUrl: 'assets/ring.jpg'),
      ],
      "Diamond Pendants": [
        Product(name: "Diamond Pendant A", price: 299.99, imageUrl: 'assets/ring.jpg'),
      ],
      // Add more products as needed for each subcategory
    };

    return productData[subcategory] ?? [];
  }

}


class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

// A page to display the list of products for a selected subcategory
class ProductListPage extends StatelessWidget {
  final String category;
  final String subcategory;
  final List<Product> products;

  const ProductListPage({
    super.key,
    required this.category,
    required this.subcategory,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory - $category'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(products[index].imageUrl),
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toString()}'),
            onTap: () {
              // Optionally navigate to product detail page
            },
          );
        },
      ),
    );
  }
}