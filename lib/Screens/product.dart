// class ProductDetail {
//   final int id;
//   final String name;
//   final String description;
//   final String imageUrl;
//   final double price;
//   final List<SizeWeight> sizes;
//   final bool availability;

//   ProductDetail({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//     required this.price,
//     required this.sizes,
//     required this.availability,
//   });

//   factory ProductDetail.fromJson(Map<String, dynamic> json) {
//     return ProductDetail(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       description: json['description'] as String,
//       imageUrl: json['imageUrl'] as String,
//       price: json['price'] as double,
//       sizes: (json['sizes'] as List).map((sizeJson) => SizeWeight.fromJson(sizeJson)).toList(),
//       availability: json['availability'] as bool,
//     );
//   }
// }

// class SizeWeight {
//   final int sizeId;
//   final double carat;
//   final double weight;

//   SizeWeight({
//     required this.sizeId,
//     required this.carat,
//     required this.weight,
//   });

//   factory SizeWeight.fromJson(Map<String, dynamic> json) {
//     return SizeWeight(
//       sizeId: json['size_id'] as int,
//       carat: json['carat'] as double,
//       weight: json['weight'] as double,
//     );
//   }
// }
