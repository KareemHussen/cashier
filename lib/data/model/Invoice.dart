
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/data/model/product_item.dart';

class Invoice {
  double? price;
  int? id;
  List<ProductItem> products;
  late List<Product>? productsList;
  int? timestamp;

  Invoice(
      {
        this.id,
        this.timestamp,
        required this.products,
        required this.price,
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