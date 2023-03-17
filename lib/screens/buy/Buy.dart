import 'package:cashier/data/model/Product.dart';
import 'package:cashier/utils/components/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {


  List<Product> _items = [
    Product(
        name: 'كرتونه بيض احمر',
        quantity: 1,
        buyPrice: 12,
        sellPrice: 14,
        id: 1),
    Product(
        name: 'طماطم حمرا', quantity: 2, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'فلفل احمر', quantity: 3, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'كرتونه بيض احمر',
        quantity: 1,
        buyPrice: 12,
        sellPrice: 14,
        id: 1),
    Product(
        name: 'طماطم حمرا', quantity: 2, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'فلفل احمر', quantity: 3, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'كرتونه بيض احمر',
        quantity: 1,
        buyPrice: 12,
        sellPrice: 14,
        id: 1),
    Product(
        name: 'طماطم حمرا', quantity: 2, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'فلفل احمر', quantity: 3, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'كرتونه بيض احمر',
        quantity: 1,
        buyPrice: 12,
        sellPrice: 14,
        id: 1),
    Product(
        name: 'طماطم حمرا', quantity: 2, buyPrice: 12, sellPrice: 14, id: 1),
    Product(
        name: 'فلفل احمر', quantity: 3, buyPrice: 12, sellPrice: 14, id: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 900.w,
                height: 900.h,
                child: ProductList(
                    products: _items,
                    admin:false
                ),
              ),

              Container(
                width: 900.w,
                height: 900.h,
                child: ProductList(
                    products: _items,
                    admin:false
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
