import 'dart:collection';

import 'package:cashier/data/model/Product.dart';

class Invoice {
  double? price;
  int? id;
  HashMap<Product, int> products;
  late List<Product>? productsList;
  int? timestamp;

  Invoice(
      {
        this.id,
        this.timestamp,
        required this.products,
        required this.price,
      }) : productsList = generateList(products);


  static List<Product> generateList(HashMap<Product, int> m){
    List<Product> products = [];
    m.forEach((key, value) {products.add(key);});
    return products;
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List<dynamic>;
    var products = productList.map((item) => Product.fromJson(item)).toList();

    return Invoice(
      id: json['id'] as int?,
      products: json['products'],
      price: json['price'] as double?,
      timestamp: json['time'] as int?,
     // productList: json['P'],
      //gain: json['gain'] as int?,
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