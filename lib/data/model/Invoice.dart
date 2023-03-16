import 'package:cashier/data/model/Product.dart';

class Invoice {
  String? price;
  int? id;
  List<Product> products;

  Invoice(
      {required this.id,
      required this.products,
      required this.price,
      });
}
