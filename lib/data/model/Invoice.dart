import 'package:cashier/data/model/Product.dart';

class Invoice {
  int? price;
  int? id;
  List<Product> products;
  int? time;
  int? gain;

  Invoice(
      {this.id,
      required this.products,
      required this.price,
        required this.time,
        required this.gain,

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