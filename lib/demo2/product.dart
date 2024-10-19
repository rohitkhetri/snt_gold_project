// import 'dart:convert';

// class Product {
//   final int id;
//   final String name;
//   final String? productId;
//   final String? category;
//   final String? subCategory;
//   final String? brand;
//   // final List<String>? relatedProduct;
//   final SizeWisePrice? sizeWisePrice;
//   final String? productCode;
//   final String? returnDays;
//   final String? rewardPoints;
//   final String? productDescription;
//   final int? productRating;
//   final String? productSpecification;
//   final int? newArrival;
//   final String? productImage;

//   Product({
//     required this.id,
//     required this.name,
//     this.productId,
//     this.category,
//     this.subCategory,
//     this.brand,
//     // this.relatedProduct,
//     this.sizeWisePrice,
//     this.productCode,
//     this.returnDays,
//     this.rewardPoints,
//     this.productDescription,
//     this.productRating,
//     this.productSpecification,
//     this.newArrival,
//     this.productImage,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       productId: json['product_id'],
//       category: json['category'],
//       subCategory: json['sub_category'],
//       brand: json['brand'],
//       // relatedProduct: json['related_product'] != null
//       //     ? List<String>.from(jsonDecode(json['related_product']))
//       //     : [],
//       sizeWisePrice: json['size_wise_price'] != null
//           ? SizeWisePrice.fromJson(jsonDecode(json['size_wise_price']))
//           : null,
//       productCode: json['product_code'],
//       returnDays: json['return_days'],
//       rewardPoints: json['Reward_points'],
//       productDescription: json['product_description'],
//       productRating: json['product_rating'],
//       productSpecification: json['product_specification'],
//       newArrival: json['new_arival'],
//       productImage: json['product_image'],
//     );
//   }
// }

// class SizeWisePrice {
//   final List<String>? price;
//   final List<String>? weight;
//   final List<String>? carat;
//   final List<String>? size;
//   final List<int>? quantity;

//   SizeWisePrice({
//     this.price,
//     this.weight,
//     this.carat,
//     this.size,
//     this.quantity,
//   });

//   factory SizeWisePrice.fromJson(Map<String, dynamic> json) {
//     return SizeWisePrice(
//       price: List<String>.from(json['price']),
//       weight: List<String>.from(json['weight']),
//       carat: List<String>.from(json['carat']),
//       size: List<String>.from(json['size']),
//       quantity: List<int>.from(json['quantity']),
//     );
//   }
// }
