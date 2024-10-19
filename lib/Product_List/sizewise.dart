class SizeWisePrice {
  final String? price;
  SizeWisePrice({this.price});

  double? get parsedPrice {
    return price != null ? double.tryParse(price!) : null;
  }
  // double? getPrice(int index) {
  //   if (price != null && index < price!.length) {
  //     return price![index];
  //   } 
  //   return null;
  // }
}