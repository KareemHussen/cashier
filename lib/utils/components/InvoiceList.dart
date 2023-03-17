import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/gain/gain_cubit.dart';
import 'package:cashier/utils/components/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceList extends StatefulWidget {
  List<Invoice> invoices;

  InvoiceList({required this.invoices});

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  final List<String> commonFactors = [
    'id',
    'date',
    'hour',
    'gain'


  ];
  late List<Invoice> invoices;

  late DateTime start;
  late DateTime end;

  final List<String> arabic = [
    'رقم الفاتوره',
    'التاريخ',
    'الساعه',
    'صافي الربح'


  ];

  @override
  void initState() {
    super.initState();
    invoices = widget.invoices;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 12.h, 12.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the common factors

            MaterialButton(
            child: Text('تاريخ النهايه')
            ,onPressed: () {

              showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now()).then((value) => (){
                    setState(() {
                      start = value!;
                    });
              });
            }),


            MaterialButton(
              child: Text("تاريخ البدايه")
                ,onPressed: () {
              showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now()).then((value) => (){
                setState(() {
                  end = value!;
                });
              });
            },

            ),


            Row(
              children: [
                for (String factor in commonFactors)
                  Expanded(
                    child: Text(
                      arabic[commonFactors.indexOf(factor)],
                      style: TextStyle(
                          fontSize: 28.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(width: 130)
              ],
            ),
            SizedBox(height: 16.h),
            // Display the individual items
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 12,
                        blurRadius: 50,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      Invoice invoice = invoices[index];
                      print(invoice.hour);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (String factor in commonFactors)
                                Expanded(
                                  child: Text(
                                    invoice.toJson()[factor].toString(),
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    child: Text('اطلاع'),
                                    onPressed: () {

                                    },
                                  ),
                                  SizedBox(width: 8.w),
                                  ElevatedButton(
                                    child: Text('حذف'),
                                    onPressed: () {
                                      _deleteProduct(invoice.id!);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.red),
                                    ),
                                  ),
                                  SizedBox(width: 20.w)
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _deleteProduct(int invoicetId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف المنتج'),
          content: Text('هل تريد حذف هذا المنتج؟'),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                SQLHelper.deleteInvoice(invoicetId);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                setState(() {
                  SQLHelper.deleteInvoice(invoicetId);
                  invoices.removeWhere((product) => product.id == invoicetId);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
