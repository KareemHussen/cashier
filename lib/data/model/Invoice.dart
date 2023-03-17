import 'dart:collection';

import 'package:cashier/data/model/Product.dart';

class Invoice {
  int? price;
  int? id;
  HashMap<Product, int> products;
  int? timestamp;


  Invoice(
      {
        this.id,
        this.timestamp,
        required this.products,
        required this.price,
      });


  factory Invoice.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List<dynamic>;
    var products = productList.map((item) => Product.fromJson(item)).toList();

    return Invoice(
      id: json['id'] as int?,
      products: products,
      price: json['price'] as int?,
      time: json['time'] as int?,
      gain: json['gain'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'products': products.map((item) => item.toJson()).toList(),
    'time': time,
    'gain': gain,
  };

}