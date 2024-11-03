// // import 'dart:convert';

// // // Main model class for product data
// // class ProductData {
// //   final List<ProductDetails> productDetails;
// //   final List<ProductMedia> productMedia;
// //   final List<Size> sizes;
// //   final List<Weight> weights;
// //   final List<Carat> carats;

// //   ProductData({
// //     required this.productDetails,
// //     required this.productMedia,
// //     required this.sizes,
// //     required this.weights,
// //     required this.carats,
// //   });

// //   factory ProductData.fromJson(Map<String, dynamic> json) {
// //     return ProductData(
// //       productDetails: (json['product_details'] as List)
// //           .map((item) => ProductDetails.fromJson(item))
// //           .toList(),
// //       productMedia: (json['product_Media'] as List)
// //           .map((item) => ProductMedia.fromJson(item))
// //           .toList(),
// //       sizes: (json['size'] as List)
// //           .map((item) => Size.fromJson(item))
// //           .toList(),
// //       weights: (json['weight'] as List)
// //           .map((item) => Weight.fromJson(item))
// //           .toList(),
// //       carats: (json['carat'] as List)
// //           .map((item) => Carat.fromJson(item))
// //           .toList(),
// //     );
// //   }
// // }

// // // Class for product details
// // class ProductDetails {
// //   final int id;
// //   final String name;
// //   final String productId;
// //   final String? category;
// //   final String? subCategory;
// //   final String? brand;
// //   final String? tag;
// //   final List<String>? relatedProduct;
// //   final Map<String, dynamic>? sizeWisePrice;
// //   final String? productCode;
// //   final String? returnDays;
// //   final String? rewardPoints;
// //   final String? productDescription;
// //   final int? productRating;
// //   final String? productSpecification;
// //   final int? newArrival;
// //   final int? isDelete;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   ProductDetails({
// //     required this.id,
// //     required this.name,
// //     required this.productId,
// //     this.category,
// //     this.subCategory,
// //     this.brand,
// //     this.tag,
// //     this.relatedProduct,
// //     this.sizeWisePrice,
// //     this.productCode,
// //     this.returnDays,
// //     this.rewardPoints,
// //     this.productDescription,
// //     this.productRating,
// //     this.productSpecification,
// //     this.newArrival,
// //     this.isDelete,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory ProductDetails.fromJson(Map<String, dynamic> json) {
// //     return ProductDetails(
// //       id: json['id'],
// //       name: json['name'],
// //       productId: json['product_id'],
// //       category: json['category'],
// //       subCategory: json['sub_category'],
// //       brand: json['brand'],
// //       tag: json['tag'],
// //       relatedProduct: jsonDecode(json['related_product']).cast<String>(),
// //       sizeWisePrice: jsonDecode(json['size_wise_price']),
// //       productCode: json['product_code'],
// //       returnDays: json['return_days'],
// //       rewardPoints: json['Reward_points'],
// //       productDescription: json['product_description'],
// //       productRating: json['product_rating'],
// //       productSpecification: json['product_specification'],
// //       newArrival: json['new_arival'],
// //       isDelete: json['is_delete'],
// //       createdAt: DateTime.parse(json['created_at']),
// //       updatedAt: DateTime.parse(json['updated_at']),
// //     );
// //   }
// // }

// // // Class for product media
// // class ProductMedia {
// //   final int id;
// //   final String image;
// //   final String productId;
// //   final int featured;
// //   final int isDelete;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   ProductMedia({
// //     required this.id,
// //     required this.image,
// //     required this.productId,
// //     required this.featured,
// //     required this.isDelete,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory ProductMedia.fromJson(Map<String, dynamic> json) {
// //     return ProductMedia(
// //       id: json['id'],
// //       image: json['image'],
// //       productId: json['product_id'],
// //       featured: int.parse(json['featured']),
// //       isDelete: json['is_delete'],
// //       createdAt: DateTime.parse(json['created_at']),
// //       updatedAt: DateTime.parse(json['updated_at']),
// //     );
// //   }
// // }

// // // Class for size
// // class Size {
// //   final int id;
// //   final String name;
// //   final int isDelete;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   Size({
// //     required this.id,
// //     required this.name,
// //     required this.isDelete,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Size.fromJson(Map<String, dynamic> json) {
// //     return Size(
// //       id: json['id'],
// //       name: json['name'],
// //       isDelete: json['is_delete'],
// //       createdAt: DateTime.parse(json['created_at']),
// //       updatedAt: DateTime.parse(json['updated_at']),
// //     );
// //   }
// // }

// // // Class for weight
// // class Weight {
// //   final int id;
// //   final String name;
// //   final int isDelete;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   Weight({
// //     required this.id,
// //     required this.name,
// //     required this.isDelete,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Weight.fromJson(Map<String, dynamic> json) {
// //     return Weight(
// //       id: json['id'],
// //       name: json['name'],
// //       isDelete: json['is_delete'],
// //       createdAt: DateTime.parse(json['created_at']),
// //       updatedAt: DateTime.parse(json['updated_at']),
// //     );
// //   }
// // }

// // // Class for carat
// // class Carat {
// //   final int id;
// //   final String name;
// //   final int isDelete;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   Carat({
// //     required this.id,
// //     required this.name,
// //     required this.isDelete,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Carat.fromJson(Map<String, dynamic> json) {
// //     return Carat(
// //       id: json['id'],
// //       name: json['name'],
// //       isDelete: json['is_delete'],
// //       createdAt: DateTime.parse(json['created_at']),
// //       updatedAt: DateTime.parse(json['updated_at']),
// //     );
// //   }
// // }


// class Product {
//   final int id;
//   final String name;
//   final String productId;
//   final String? category;
//   final String? subCategory;
//   final String? brand;
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
//     required this.productId,
//     this.category,
//     this.subCategory,
//     this.brand,
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

// class ProductData {
//   final List<Product> productDetails;

//   ProductData({required this.productDetails});

//   factory ProductData.fromJson(Map<String, dynamic> json) {
//     var productDetailsJson = json['product_details'] as List;
//     List<Product> productDetailsList = productDetailsJson.map((i) => Product.fromJson(i)).toList();

//     return ProductData(productDetails: productDetailsList);
//   }
// }

// class SizeWisePrice {
//   final List<String> price;
//   final List<String> weight;
//   final List<String> carat;
//   final List<String> size;
//   final List<int> quantity;

//   SizeWisePrice({
//     required this.price,
//     required this.weight,
//     required this.carat,
//     required this.size,
//     required this.quantity,
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
