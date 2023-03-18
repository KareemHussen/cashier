// import 'package:cashier/data/model/Product.dart';
// import 'package:cashier/data/model/product_item.dart';
//
// class Invoice {
//   int? price;
//   int? id;
//   List<ProductItem> products;
//   List<Product>? productsList;
//   int? time;
//   int? gain;
//   String? date;
//   String? hour;
//
//   Invoice({this.id,
//     required this.products,
//     required this.price,
//     required this.time,
//     required this.gain,
//     required this.date,
//     required this.hour,
//   }) : productsList = generateList(products);
//
//
//   static List<Product> generateList(List<ProductItem> m) {
//     List<Product> products = [];
//     m.forEach((key) {
//       products.add(key.product);
//     });
//     return products;
//   }
//
//   static List<ProductItem> generateItemList(List<Product> m) {
//     List<ProductItem> products = [];
//     m.forEach((key) {
//       products.add(ProductItem(product: key, quantity: 0));
//     });
//     return products;
//   }
//
//
//   factory Invoice.fromJson(Map<String, dynamic> json) {
//     var productList = json['products'] as List<dynamic>;
//     var products = productList.map((item) => Product.fromJson(item)).toList();
//
//
//     // var productList = json['products'] as List<dynamic>;
//     // var products = productList.map((item) => Product.fromJson(item)).toList();
//
//     return Invoice(
//       id: json['id'] as int?,
//       products: generateItemList(products),
//       price: json['price'] as int?,
//       time: json['time'] as int?,
//       gain: json['gain'] as int?,
//       date: json['date'] as String,
//       hour: json['hour'] as String,
//
//     );
//   }
//
//   Map<String, dynamic> toJson() =>
//       {
//         'id': id,
//         'price': price,
//         'products': products.map((item) => item.toJson()).toList(),
//         'time': time,
//         'gain': gain,
//         'date': date,
//         'hour': hour,
//
//       };
//
// }

import 'package:cashier/data/model/Product.dart';
import 'package:cashier/data/model/product_item.dart';

class Invoice {
  double? price;
  int? id;
  List<ProductItem> products;
  late List<Product>? productsList;
  int? timestamp;
  double? gain;
  String? date;
  String? hour;

  Invoice(
      {
        this.id,
        this.timestamp,
        required this.products,
        required this.price,
        required this.gain,
        required this.date,
        required this.hour,
      }) : productsList = generateList(products);


  static List<Product> generateList(List<ProductItem> m){
    List<Product> products = [];
    m.forEach((key) {products.add(key.product);});
    return products;
  }

  factory Invoice.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List<dynamic>;

    return Invoice(
      id: json['id'] as int?,
      products: json['products'],
      price: json['price'] as double?,
      timestamp: json['time'] as int?,
      gain: json['gain'] as double?,
      date: json['date'] as String,
      hour: json['hour'] as String,
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
     'date': date,
     'hour': hour,
  };

}