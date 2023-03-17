import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/components/product_list.dart';

class Storage extends StatelessWidget {
  Storage({Key? key}) : super(key: key);
  String? title = 'إدارة المخزن';
  String subtitle = 'أولاد مبروك';
  List<Product> products = [
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 1565),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 177),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 88881),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 91),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 18),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 891),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 71),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 671),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 61),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 15),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 14),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 13),
    // Product(
    //     name: 'هوهوز طماطم', quantity: 10, buyPrice: 100, sellPrice: 150, id: 12),
  ];



  @override
  Widget build(BuildContext context) {
    SQLHelper.getproducts().then((value) {
      for (Map<String, dynamic> pro in value) {
        products.add(Product(
            id: pro['id'],
            name: pro['name'],
            quantity: pro['quantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']
            )
        );
      }
      print(products.length);
    });

    return Scaffold(
      body: ProductList(
        products: products,
        title: title,
        subtitle: subtitle.isNotEmpty ? subtitle : null,
        admin:true
      ),
    );
  }
}