class ProductModel {
  final String image;
  final String brandName;
  final String title;
  final double price;
  final double priceAfterDiscount;
  final int discountPercent;

  ProductModel({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    required this.priceAfterDiscount,
    required this.discountPercent,
  });
}
