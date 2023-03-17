import 'package:cashier/Invoice/invoice_cubit.dart';
import 'package:cashier/Invoice/invoice_form.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/model/Invoice.dart';

class BuyProducts extends StatefulWidget {
  const BuyProducts({Key? key}) : super(key: key);

  @override
  State<BuyProducts> createState() => _BuyProductsState();
}

class _BuyProductsState extends State<BuyProducts> {
  late Invoice v;
  List<Product> p = [];
  @override
  Widget build(BuildContext context) {
    v = InvoiceCubit.get(context).invoice;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 900.w,
                height: 900.h,
                child: InvoiceForm(
                    invoice: v,
                ),
              ),

              SizedBox(
                width: 900.w,
                height: 900.h,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: p.length,
                      itemBuilder: (context , index){

                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
