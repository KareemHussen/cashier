import 'dart:convert';
import 'dart:math';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/buy/Buy.dart';
import 'package:cashier/screens/storage/storage.dart';
import 'package:cashier/utils/components/invoice_form.dart';
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

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "أولاد مبروك",
              style: TextStyle(
                color: Colors.black,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const Divider(thickness: 2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // if (kDebugMode) {
                      //   print("done");
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Buy()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 25),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: const Text('الشراء'),
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                      List<Invoice> invoices = [];


                      SQLHelper.addInvoice(90, _items , calculateGain(_items)).then((value) => {
                          print(value)
                      });


                      // SQLHelper.getInvoicesByTime(1, 1679063225721).then((value) {
                      //   for (Map<String, dynamic> invoice in value) {
                      //
                      //     List<dynamic> productList = jsonDecode(invoice['products']);
                      //     List<Product> products = productList.map((item) => Product.fromJson(item)).toList();
                      //
                      //
                      //     invoices.add(Invoice(
                      //         id: invoice['id'],
                      //         price: invoice['price'],
                      //         products: products,
                      //         time: invoice['time'],
                      //         gain: invoice['gain']
                      //     )
                      //     );
                      //   }
                      //
                      //   print(invoices.length);
                      // });

                      SQLHelper.getInvoices().then((value) {
                        for (Map<String, dynamic> invoice in value) {

                          List<dynamic> productList = jsonDecode(invoice['products']);
                          List<Product> products = productList.map((item) => Product.fromJson(item)).toList();


                          // invoices.add(Invoice(
                          //     id: invoice['id'],
                          //     price: invoice['price'],
                          //     products: products,
                          //     time: invoice['time'],
                          //     gain: invoice['gain']
                          // )
                          // );
                        }

                        //print(invoices[2].time);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 25),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: const Text('الجرد'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Storage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 25),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: const Text('المخزن'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceForm()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 25),
                        textStyle: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: const Text('الفواتير'),
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }

  int calculateGain(List<Product> products) {
    int gain = 0;

    for (var element in products) {
      gain = gain + element.buyPrice - element.sellPrice;
    }

    return gain;
  }
}
