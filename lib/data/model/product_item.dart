import 'package:cashier/data/model/Product.dart';

class ProductItem {
   int quantity;
  bool selected;
  Product product;
  ProductItem({required this.product, required this.quantity, this.selected = false});
}