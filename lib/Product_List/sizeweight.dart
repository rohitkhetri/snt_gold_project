
class ProductDetail {
  List<dynamic> productDetails;
  List<dynamic> productMedia;
  List<SizeOption> size;
  List<WeightOption> weight;
  List<CaratOption> carat;

  ProductDetail({
    required this.productDetails,
    required this.productMedia,
    required this.size,
    required this.weight,
    required this.carat,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      productDetails: json['product_data']['product_details'],
      productMedia: json['product_data']['product_Media'],
      size: (json['product_data']['size'] as List)
          .map((item) => SizeOption.fromJson(item))
          .toList(),
      weight: (json['product_data']['weight'] as List)
          .map((item) => WeightOption.fromJson(item))
          .toList(),
      carat: (json['product_data']['carat'] as List)
          .map((item) => CaratOption.fromJson(item))
          .toList(),
    );
  }
}


class SizeOption {
  final int id;
  final String name;

  SizeOption({required this.id, required this.name});

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      id: json['id'],
      name: json['name'],
    );
  }
}

class WeightOption {
  final int id;
  final String name;

  WeightOption({required this.id, required this.name});

  factory WeightOption.fromJson(Map<String, dynamic> json) {
    return WeightOption(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CaratOption {
  final int id;
  final String name;

  CaratOption({required this.id, required this.name});

  factory CaratOption.fromJson(Map<String, dynamic> json) {
    return CaratOption(
      id: json['id'],
      name: json['name'],
    );
  }
}
