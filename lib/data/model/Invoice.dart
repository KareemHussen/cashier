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
}