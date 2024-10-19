import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String productId;
  final String category;
  final String subCategory;
  final String brand;
  final String? tag;
  final List<int>? relatedProducts;
  final Map<String, dynamic> sizeWisePrice;
  final String? productCode;
  final int returnDays;
  final int? rewardPoints;
  final String? productDescription;
  final double productRating;  
  final String? productSpecification;
  final int newArrival;
  final int isDeleted;
  final String createdAt;
  final String updatedAt;
  final String productImage;

  Product({
    required this.id,
    required this.name,
    required this.productId,
    required this.category,
    required this.subCategory,
    required this.brand,
    this.tag,
    this.relatedProducts,
    required this.sizeWisePrice,
    this.productCode,
    required this.returnDays,
    this.rewardPoints,
    this.productDescription,
    required this.productRating,
    this.productSpecification,
    required this.newArrival,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      productId: json['product_id'],
      category: json['category'],
      subCategory: json['sub_category'],
      brand: json['brand'],
      tag: json['tag'] == 'null' ? null : json['tag'],
      relatedProducts: json['related_product'] != null && json['related_product'] is String
          ? List<int>.from(jsonDecode(json['related_product']))
          : null,
      sizeWisePrice: jsonDecode(json['size_wise_price']),
      productCode: json['product_code'],
      returnDays: int.parse(json['return_days']?.toString() ?? '0'),
      rewardPoints: json['Reward_points'] == null
          ? null
          : int.tryParse(json['Reward_points'].toString()),
                productDescription: json['product_description'],
      productRating: json['product_rating'] != null
          ? double.tryParse(json['product_rating'].toString()) ?? 0.0
          : 0.0,
      productSpecification: json['product_specification'],
      newArrival: json['new_arival'] != null ? int.parse(json['new_arival'].toString()) : 0,
      isDeleted: json['is_delete'] != null ? int.parse(json['is_delete'].toString()) : 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productImage: json['product_image'],
    );
  }

  double getFirstSizePrice() {
    if (sizeWisePrice.isNotEmpty && sizeWisePrice['price'] != null) {
      if (sizeWisePrice['price'] is List && sizeWisePrice['price'].isNotEmpty) {
        return double.tryParse(sizeWisePrice['price'][0].toString()) ?? 0.0;
      }
    }
    return 0.0;
  }
}