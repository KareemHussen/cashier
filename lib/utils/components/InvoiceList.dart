import 'dart:async';
import 'dart:math';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/gain/gain.dart';
import 'package:cashier/screens/gain/gain_cubit.dart';
import 'package:cashier/utils/components/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class InvoiceList extends StatefulWidget {
  List<Invoice> invoices;

  InvoiceList({required this.invoices});

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  final List<String> commonFactors = ['id', 'date', 'hour', 'gain'];

  late DateTime start;
  late DateTime end;

  final List<String> arabic = [
    'رقم الفاتوره',
    'التاريخ',
    'الساعه',
    'صافي الربح'
  ];
  late TextEditingController dateController;
  late TextEditingController dateController1;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    dateController1 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          GainCubit.get(context).resetInvoices().then((value) => {});
          return true;
        },
        child: BlocConsumer<GainCubit, GainState>(
          listener: (context, state) {
            if (state is GainSuccessful) {
              GainCubit.get(context).totalFilterGain = 0;
              GainCubit.get(context).filteredInvoices.forEach((element) {
                GainCubit.get(context).totalFilterGain =
                    GainCubit.get(context).totalFilterGain + element.gain!;
                print(element.gain);
              });
            } else if (state is GainReset) {
              GainCubit.get(context).filteredInvoices.forEach((element) {
                GainCubit.get(context).totalFilterGain =
                    GainCubit.get(context).totalFilterGain + element.gain!;
              });
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, 12.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display the common factors

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 500,
                            child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "من"),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );
                                if (pickedDate != null &&
                                    dateController1.text.isNotEmpty) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(pickedDate);

                                  DateTime sdate =
                                      DateTime.parse(formattedDate);
                                  int stimestamp = sdate.millisecondsSinceEpoch;

                                  DateTime sdate1 =
                                      DateTime.parse(dateController1.text);
                                  DateTime endOfDay = DateTime(
                                      sdate1.year,
                                      sdate1.month,
                                      sdate1.day,
                                      23,
                                      59,
                                      59,
                                      999);
                                  int stimestamp1 =
                                      endOfDay.millisecondsSinceEpoch;

                                  setState(() {
                                    dateController.text =
                                        formattedDate.toString();

                                    if (dateController1.text.isNotEmpty) {
                                      GainCubit.get(context)
                                          .getInvoicesByTime(
                                              stimestamp, stimestamp1)
                                          .then((value) => {});
                                    }
                                  });
                                } else if (pickedDate != null) {
                                  setState(() {
                                    String formattedDate =
                                        DateFormat("yyyy-MM-dd")
                                            .format(pickedDate);
                                    dateController.text =
                                        formattedDate.toString();
                                  });
                                } else {
                                  print("Not selected");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: 500,
                            child: TextField(
                              controller: dateController1,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "الي"),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );

                                if (pickedDate != null &&
                                    dateController.text.isNotEmpty) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(pickedDate);

                                  DateTime sdate =
                                      DateTime.parse(dateController.text);
                                  int stimestamp = sdate.millisecondsSinceEpoch;

                                  DateTime sdate1 =
                                      DateTime.parse(formattedDate);
                                  DateTime endOfDay = DateTime(
                                      sdate1.year,
                                      sdate1.month,
                                      sdate1.day,
                                      23,
                                      59,
                                      59,
                                      999);
                                  int stimestamp1 =
                                      endOfDay.millisecondsSinceEpoch;

                                  setState(() {
                                    dateController1.text =
                                        formattedDate.toString();

                                    if (dateController1.text.isNotEmpty) {
                                      GainCubit.get(context).getInvoicesByTime(
                                          stimestamp, stimestamp1);
                                    }
                                  });
                                } else if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(pickedDate);
                                  start = DateTime.parse(formattedDate);

                                  setState(() {
                                    dateController1.text =
                                        formattedDate.toString();
                                  });
                                } else {
                                  print("Not selected");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                dateController.text = "";
                                dateController1.text = "";
                                GainCubit.get(context).resetInvoices();
                              },
                              child: Text(
                                'الكل',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'arab'
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Text(
                        "الارباح الكليه",
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontFamily: 'arab'
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        GainCubit.get(context).totalFilterGain.toString(),
                        style: TextStyle(
                            fontFamily: 'arab',
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  Row(
                    children: [
                      for (String factor in commonFactors)
                        Expanded(
                          child: Text(
                            arabic[commonFactors.indexOf(factor)],
                            style: TextStyle(
                                fontFamily: 'arab',
                                fontSize: 28.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      SizedBox(width: 130.w)
                    ],
                  ),
                  SizedBox(height: 30.h),
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
                          itemCount:
                              GainCubit.get(context).filteredInvoices.length,
                          itemBuilder: (context, index) {
                            Invoice invoice =
                                GainCubit.get(context).filteredInvoices[index];
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
                                            fontFamily: 'arab',
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          child: Text('اطلاع' , style: TextStyle(fontFamily: 'arab')),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Container(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Text(
                                                          'منتجات الفاتوره',
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontFamily: 'arab',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    content: Container(
                                                        width: double.maxFinite,
                                                        child: ProductList(
                                                          products:
                                                              invoice.productsList!,
                                                          admin: false,
                                                        )),
                                                  );
                                                });
                                          },
                                        ),
                                        SizedBox(width: 8.w),
                                        ElevatedButton(
                                          child: Text('حذف', style: TextStyle(fontFamily: 'arab')),
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
            );
          },
        ),
      ),
    );
  }

  void _deleteProduct(int invoicetId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حذف المنتج' , style: TextStyle(fontFamily: 'arab')),
          content: Text('هل تريد حذف هذا المنتج؟' , style: TextStyle(fontFamily: 'arab')),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء', style: TextStyle(fontFamily: 'arab')),
              onPressed: () {
                SQLHelper.deleteInvoice(invoicetId);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('حذف' , style: TextStyle(fontFamily: 'arab'),),
              onPressed: () {
                setState(() {
                  SQLHelper.deleteInvoice(invoicetId);
                  GainCubit.get(context)
                      .filteredInvoices
                      .removeWhere((product) => product.id == invoicetId);
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
