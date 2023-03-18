import 'dart:convert';
import 'dart:math';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/buy/Buy.dart';
import 'package:cashier/screens/gain/gain.dart';
import 'package:cashier/screens/shortfalls/shortfalls.dart';
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
             SizedBox(height: 30.h),
             Text(
              "أولاد مبروك",
              style: TextStyle(
                color: Colors.black,
                fontSize: 80.sp,
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

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Buy()),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Shorfalls()),
                      // );

                      List<Product> list = [
                        Product(id: 3, name: "name", quantity: 20, buyPrice: 30, sellPrice: 50),
                        Product(id: 3, name: "name", quantity: 20, buyPrice: 30, sellPrice: 50),
                        Product(id: 3, name: "name", quantity: 20, buyPrice: 30, sellPrice: 50),
                        Product(id: 3, name: "name", quantity: 20, buyPrice: 30, sellPrice: 50),
                        Product(id: 3, name: "name", quantity: 20, buyPrice: 30, sellPrice: 50),
                      ];

                      SQLHelper.addInvoice(1500, list, 100);


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
                        MaterialPageRoute(builder: (context) => Gain()),
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
