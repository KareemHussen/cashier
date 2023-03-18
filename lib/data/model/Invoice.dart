import 'dart:collection';

import 'package:cashier/data/model/Product.dart';

class Invoice {
  double? price;
  int? id;
  List<Porduct> products;
  late List<Product>? productsList;
  int? timestamp;

  Invoice(
      {
        this.id,
        this.timestamp,
        required this.products,
        required this.price,
      }) : productsList = generateList(products);


  factory Invoice.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List<dynamic>;
    var products = productList.map((item) => Product.fromJson(item)).toList();

    return Invoice(
      id: json['id'] as int?,
      products: products,
      price: json['price'] as int?,
      time: json['time'] as int?,
      gain: json['gain'] as int?,
      date: json['date'] as String,
      hour: json['hour'] as String,

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'products': products,//products.map((item) => item.toJson()).toList(),
    'time': timestamp,
    'gain': price,
  };

}