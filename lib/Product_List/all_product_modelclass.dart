import 'dart:convert';

class SizeWisePricess {
  final List<String> sizes;

  SizeWisePricess({required this.sizes});

  factory SizeWisePricess.fromJson(Map<String, dynamic> json) {
    return SizeWisePricess(
      sizes: List<String>.from(json['size']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String productId;
  final String? category;
  final String? subCategory;
  final String? brand;
  // final List<String>? relatedProduct;
  SizeWisePrice? sizeWisePrice;
  final String? productCode;
  final String? returnDays;
  final String? rewardPoints;
  final String? productDescription;
  final int? productRating;
  final String? productSpecification;
  final int? newArrival;
  final String? productImage;
  String? selectedSize;
  String? selectedCarat;
  String? selectedWeight;
  int? quantity;

  Product({
    required this.id,
    required this.name,
    required this.productId,
    this.category,
    this.subCategory,
    this.brand,
    // this.relatedProduct,
    this.sizeWisePrice,
    this.productCode,
    this.returnDays,
    this.rewardPoints,
    this.productDescription,
    this.productRating,
    this.productSpecification,
    this.newArrival,
    this.productImage,
    this.selectedSize,
    this.selectedCarat,
    this.selectedWeight,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is String
          ? int.parse(json['id'])
          : json['id'], // Safely handle String to int conversion

      // id: json['id'],
      name: json['name'],
      productId: json['product_id'],
      category: json['category'],
      subCategory: json['sub_category'],
      brand: json['brand'],
      // relatedProduct: json['related_product'] != null
      //     ? List<String>.from(jsonDecode(json['related_product']))
      //     : [],
      sizeWisePrice: json['size_wise_price'] != null
          ? SizeWisePrice.fromJson(jsonDecode(json['size_wise_price']))
          : null,
      productCode: json['product_code'],
      returnDays: json['return_days'],
      rewardPoints: json['Reward_points'],
      productDescription: json['product_description'],
      productRating: json['product_rating'],
      productSpecification: json['product_specification'],
      newArrival: json['new_arival'],
      productImage: json['product_image'],
    );
  }

  List<String> getAvailableSizes(SizeWisePricess? sizeWisePrice) {
    if (sizeWisePrice == null) {
      return []; // Return an empty list if sizeWisePrice is null
    }
    return sizeWisePrice
        .sizes; // Return available sizes from the SizeWisePrice object
  }

  toJson() {}
}

class Subcategory {
  final int id;
  final String name;
  final String image;

  Subcategory({
    required this.id,
    required this.name,
    required this.image,
  });
}

class CategoryModel {
  final String title;
  final String img;
  final List<Subcategory> subcategories;

  CategoryModel({
    required this.img,
    required this.title,
    required this.subcategories,
  });
}

class SizeWisePrice {
  final List<String>? price;
  final List<String>? weight;
  final List<String>? carat;
  final List<String>? size;
  List<int>? quantity;

  SizeWisePrice({
    this.price,
    this.weight,
    this.carat,
    this.size,
    this.quantity,
  });

  factory SizeWisePrice.fromJson(Map<String, dynamic> json) {
    return SizeWisePrice(
      price: List<String>.from(json['price']),
      weight: List<String>.from(json['weight']),
      carat: List<String>.from(json['carat']),
      size: List<String>.from(json['size']),
      quantity: List<int>.from(json['quantity']),
    );
  }
}

class ProductFilterRequest {
  final String below10000;
  final String tenKToTwentyK;
  final String twentyKToThirtyK;
  final String thirtyKToFortyK;
  final String fortyKToFiftyK;
  final String above50000;
  final List<String> brand;
  final List<String> size;
  final List<String> weight;
  final List<String> category;
  final List<String> subcategory;
  final String sortBy;

  ProductFilterRequest({
    required this.below10000,
    required this.tenKToTwentyK,
    required this.twentyKToThirtyK,
    required this.thirtyKToFortyK,
    required this.fortyKToFiftyK,
    required this.above50000,
    required this.brand,
    required this.size,
    required this.weight,
    required this.category,
    required this.subcategory,
    required this.sortBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "below10000": below10000,
      "10k_20K": tenKToTwentyK,
      "20k_30K": twentyKToThirtyK,
      "30k_40K": thirtyKToFortyK,
      "40k_50K": fortyKToFiftyK,
      "above50000": above50000,
      "brand": brand,
      "size": size,
      "weight": weight,
      "category": category,
      "subcategory": subcategory,
      "sortBy": sortBy,
    };
  }
}

// class CartProduct {
  

//   CartProduct({
//     required this.productName,
//     required this.productImage,
//     this.size,
//     this.carat,
//     this.weight,
//     required this.price,
//     required this.quantity,
//   });
// }
