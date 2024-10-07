class Product {
  final String name;
  final double price;
  final String imageUrl;
  bool isFavourite;
  bool isIncart;

  Product({required this.name, required this.price, required this.imageUrl, this.isFavourite = false, this.isIncart = false});
}


List<Product> allProducts = [
  // Rings
  // Product(name: "Diamond Ring", price: 499.99, imageUrl: 'assets/diamong_ring.png'),
  Product(name: "Diamond Ring", price: 599.99, imageUrl: 'assets/ring.jpg'),
  Product(name: "Gold Ring", price: 399.99, imageUrl: 'assets/gold_ring.webp'),
  Product(name: "Platinum Ring", price: 999.99, imageUrl: 'assets/platinum_ring.png'),

  // Pendants
  Product(name: "Gold Pendant", price: 199.99, imageUrl: 'assets/pendant.webp'),
  Product(name: "Silver Pendant", price: 99.99, imageUrl: 'assets/pendants.jpeg'),
  Product(name: "Diamond Pendant", price: 299.99, imageUrl: 'assets/pendant.webp'),

  // NeckPins
  Product(name: "Gold NosePin", price: 149.99, imageUrl: 'assets/nosepin_gold.png'),
  Product(name: "Diamond NosePin", price: 249.99, imageUrl: 'assets/nosepin_diamond.png'),
  // Product(name: "Pearl Necklace A", price: 349.99, imageUrl: 'assets/necklace.jpeg'),

  // Earrings
  Product(name: "Gold Earrins", price: 49.99, imageUrl: 'assets/earring_gold.png'),
  Product(name: "Silver Earring", price: 59.99, imageUrl: 'assets/earring_gold1.png'),
  Product(name: "Diamond Earring", price: 69.99, imageUrl: 'assets/earrings.jpeg'),
];
