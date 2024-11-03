import 'dart:convert';

class ProductData {
  List<ProductDetail> productDetails;
  List<ProductMedia> productMedia;
  List<Size> sizes;
  List<Weight> weights;
  List<Carat> carats;

  ProductData({
    required this.productDetails,
    required this.productMedia,
    required this.sizes,
    required this.weights,
    required this.carats,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      productDetails: (json['product_details'] as List)
          .map((item) => ProductDetail.fromJson(item))
          .toList(),
      productMedia: (json['product_Media'] as List)
          .map((item) => ProductMedia.fromJson(item))
          .toList(),
      sizes: (json['size'] as List).map((item) => Size.fromJson(item)).toList(),
      weights: (json['weight'] as List).map((item) => Weight.fromJson(item)).toList(),
      carats: (json['carat'] as List).map((item) => Carat.fromJson(item)).toList(),
    );
  }
}

class ProductDetail {
  int id;
  String name;
  String productId;
  String category;
  String subCategory;
  String brand;
  String tag;
  List<int> relatedProduct;
  SizeWisePrice sizeWisePrice;
  String productCode;
  String returnDays;
  String rewardPoints;
  String productDescription;
  int productRating;
  String productSpecification;
  int newArrival;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  ProductDetail({
    required this.id,
    required this.name,
    required this.productId,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.tag,
    required this.relatedProduct,
    required this.sizeWisePrice,
    required this.productCode,
    required this.returnDays,
    required this.rewardPoints,
    required this.productDescription,
    required this.productRating,
    required this.productSpecification,
    required this.newArrival,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      name: json['name'],
      productId: json['product_id'],
      category: json['category'],
      subCategory: json['sub_category'],
      brand: json['brand'],
      tag: json['tag'] ?? "",
      relatedProduct: List<int>.from(jsonDecode(json['related_product']).map((x) => int.parse(x))),
      sizeWisePrice: SizeWisePrice.fromJson(jsonDecode(json['size_wise_price'])),
      productCode: json['product_code'],
      returnDays: json['return_days'],
      rewardPoints: json['Reward_points'],
      productDescription: json['product_description'],
      productRating: json['product_rating'],
      productSpecification: json['product_specification'],
      newArrival: json['new_arival'],
      isDelete: json['is_delete'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class SizeWisePrice {
  List<String> price;
  List<String> weight;
  List<String> carat;
  List<String> size;
  List<String> quantity;

  SizeWisePrice({
    required this.price,
    required this.weight,
    required this.carat,
    required this.size,
    required this.quantity,
  });

  factory SizeWisePrice.fromJson(Map<String, dynamic> json) {
    return SizeWisePrice(
      price: List<String>.from(json['price']),
      weight: List<String>.from(json['weight']),
      carat: List<String>.from(json['carat']),
      size: List<String>.from(json['size']),
      quantity: List<String>.from(json['quantity']),
    );
  }
}

class ProductMedia {
  int id;
  String image;
  String productId;
  String featured;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  ProductMedia({
    required this.id,
    required this.image,
    required this.productId,
    required this.featured,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductMedia.fromJson(Map<String, dynamic> json) {
    return ProductMedia(
      id: json['id'],
      image: json['image'],
      productId: json['product_id'],
      featured: json['featured'],
      isDelete: json['is_delete'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Size {
  int id;
  String name;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  Size({
    required this.id,
    required this.name,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['id'],
      name: json['name'],
      isDelete: json['is_delete'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Weight {
  int id;
  String name;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  Weight({
    required this.id,
    required this.name,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['id'],
      name: json['name'],
      isDelete: json['is_delete'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Carat {
  int id;
  String name;
  int isDelete;
  DateTime createdAt;
  DateTime updatedAt;

  Carat({
    required this.id,
    required this.name,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Carat.fromJson(Map<String, dynamic> json) {
    return Carat(
      id: json['id'],
      name: json['name'],
      isDelete: json['is_delete'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
