class ProductAvailability {
  final bool isAvailable;

  ProductAvailability({required this.isAvailable});

  factory ProductAvailability.fromJson(Map<String, dynamic> json) {
    return ProductAvailability(
      isAvailable: json['isAvailable'] as bool,
    );
  }
}
