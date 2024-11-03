class NewProduct {
  final String name;
  final double price;
  final String image;

  NewProduct({required this.name, required this.price, required this.image});
}

List<NewProduct> allnewproducts = [
  NewProduct(name: "Diamond Ring", price: 599.99, image: 'assets/ring.jpg'),
  NewProduct(name: "Gold Pendant", price: 199.99, image: 'assets/pendant.webp'),
  NewProduct(
      name: "Gold NosePin", price: 149.99, image: 'assets/nosepin_gold.png'),
  NewProduct(
      name: "Gold Earrings", price: 49.99, image: 'assets/earring_gold.png'),
];
