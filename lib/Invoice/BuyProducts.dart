import 'package:cashier/Invoice/invoice_cubit.dart';
import 'package:cashier/Invoice/invoice_form.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/utils/prtint/print_pdf.dart';
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 900.w,
                height: 100.h,
                child: Column(
                  children: [
                    ElevatedButton(onPressed: (){
                      PrintPdf.checkOut(v);
                    }, child: const Text('حفظ و طباعة الفاتورة')),
                    /*SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: p.length,
                          itemBuilder: (context , index){

                          }),
                    ),*/
                  ],
                ),
              ),
              SizedBox(
                width: 900.w,
                height: 100.h,
                child: InvoiceForm(
                  invoice: v,
                ),
              ),
            ],
          ),
      );
  }
}
