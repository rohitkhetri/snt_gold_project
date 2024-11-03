import 'package:flutter/material.dart';

Widget buildStarRating(double rating) {
  int fullStars = rating.floor();
  bool halfStar = rating - fullStars >= 0.5;

  return Row(
    children: List.generate(5, (index) {
      if (index < fullStars) {
        return const Icon(Icons.star, color: Colors.amber);
      } else if (index == fullStars && halfStar) {
        return const Icon(Icons.star_half, color: Colors.amber);
      } else {
        return const Icon(Icons.star_border, color: Colors.amber);
      }
    }),
  );
}
