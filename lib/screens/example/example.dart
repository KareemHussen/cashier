import 'dart:math';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    List<Product> _items = [
      Product(
          name: 'كرتونه بيض احمر',
          quantity: 1,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'طماطم حمرا',
          quantity: 2,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'فلفل احمر',
          quantity: 3,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'كرتونه بيض احمر',
          quantity: 1,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'طماطم حمرا',
          quantity: 2,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'فلفل احمر',
          quantity: 3,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'كرتونه بيض احمر',
          quantity: 1,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'طماطم حمرا',
          quantity: 2,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'فلفل احمر',
          quantity: 3,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'كرتونه بيض احمر',
          quantity: 1,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'طماطم حمرا',
          quantity: 2,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
      Product(
          name: 'فلفل احمر',
          quantity: 3,
          buyPrice: 12,
          sellPrice: 14,
          id: 1),
    ];
    List<String> emptyList = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];

    // List<Product> _items1 = [
    //   Product(
    //       name: 'كرتونه بيض احمر',
    //       quantity: 1,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'طماطم حمرا',
    //       quantity: 2,
    //
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'فلفل احمر',
    //       quantity: 3,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'كرتونه بيض احمر',
    //       quantity: 1,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'طماطم حمرا',
    //       quantity: 2,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'فلفل احمر',
    //       quantity: 3,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'كرتونه بيض احمر',
    //       quantity: 1,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'طماطم حمرا',
    //       quantity: 2,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    //   Product(
    //       name: 'فلفل احمر',
    //       quantity: 3,
    //       buyPrice: 12,
    //       sellPrice: 14,
    //       id: 1),
    // ];

    return Scaffold(

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(50),
            decoration: const BoxDecoration(
              color: Color(0xFFffffff),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 5.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 5  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(child: Text('Name')),
                      SizedBox(width: 16),
                      Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Divider(thickness: 1),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 900.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(_items[index].name),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '\$${_items[index].sellPrice.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => {

                                },
                              ),
                              Text(_items[index].quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () async  =>
                                {

                                  await SQLHelper.initDb(),
                                  // print(await SQLHelper.addProduct()),

                                  // SQLHelper.getproducts().then((value) => {
                                  //
                                  // for (Map<String, dynamic> pro in value) {
                                  //     print(pro.toString())
                                  // }
                                  //
                                  // }),
                                }
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
