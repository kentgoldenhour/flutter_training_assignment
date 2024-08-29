import 'dart:convert';

import 'package:http/http.dart';

class Product {
  int id = 0;
  String title = '';
  double price = 0.0;
  String category = '';
  String description = '';
  String image = '';

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }
}

// class Categories {
//   String category = '';
//   Categories({required this.category});
// }

class UserProduct {
  int productId = 0;
  int quantity = 0;

  UserProduct({
    required this.productId,
    required this.quantity,
  });

  factory UserProduct.fromJson(Map<String, dynamic> json) {
    return UserProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

// class Carts {
//   int id = 0;
//   int userid = 0;
//   DateTime date = DateTime.now();
//   List<UserProduct> products = [];

//   Carts({
//     required this.id,
//     required this.userid,
//     required this.date,
//     required this.products,
//   });

//   factory Carts.fromJson(Map<String, dynamic> json) {
//     return Carts(
//       id: json['id'],
//       userid: json['userid'],
//       date: json['date'],
//       products: json['products'].map((e) => UserProduct.fromJson(e)).toList(),
//     );
//   }
// }
