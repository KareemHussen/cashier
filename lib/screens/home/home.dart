import 'dart:math';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/buy/Buy.dart';
import 'package:cashier/screens/storage/storage.dart';
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
            SizedBox(height: 30),
            Text(
              "أولاد مبروك",
              style: TextStyle(
                color: Colors.black,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            Divider(thickness: 2),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround ,

                children: [

                ElevatedButton(
                  child: Text('الشراء'),
                  onPressed: () {

                    print("done");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Buy()),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                      textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),


                ElevatedButton(
                  child: Text('الجرد'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                      textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),

                ElevatedButton(
                  child: Text('المخزن'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                      textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),

              ],),
            )


          ],
        ),
      ),
    );
  }
}
