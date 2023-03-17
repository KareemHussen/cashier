import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/Invoice.dart';

class InvoiceForm extends StatefulWidget {
  final String buttonText;
  Invoice? invoice;
  List<Product>? cartItems;
  List<Product>? products;
  final Function(Invoice) onSave;
  final Function(Invoice) onDelete;

  InvoiceForm({
    required this.buttonText,
    required this.invoice,
    required this.onSave,
    required this.onDelete,
  });

  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Future<void> initState() async {
    super.initState();
    // Set the initial values for the fields based on the product
    widget.cartItems?? <Product>[];
    widget.invoice ?? Invoice(products: <Product>[], price: 0);
    widget.products ?? await SQLHelper.getproducts();
  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.invoice == null;
    if (flag) {
      widget.invoice =
          Invoice(products: <Product>[], price: 0);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحرير فاتورة'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(400.w, 300.h, 400.w, 200.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownSearch(

                )
               
                // TextFormField(
                //   initialValue: widget.product!.sellPrice?.toString(),
                //   decoration: InputDecoration(
                //     labelText: 'سعر البيع',
                //   ),
                //   keyboardType: TextInputType.number,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'برجاء إدخال سعر البيع';
                //     }
                //     if (double.tryParse(value) == null) {
                //       return 'برجاء إدخال سعر بيع صحيح';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     widget.product!.sellPrice = int.parse(value!);
                //   },
                // ),
                // SizedBox(height: 16.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     if (!flag)
                //       ElevatedButton(
                //         onPressed: () {
                //           showDialog(
                //             context: context,
                //             builder: (context) => AlertDialog(
                //               title: Text('حذف المنتج'),
                //               content: Text(
                //                   'هل أنت متأكد من رغبتك بحذف هذا المنتج ؟'),
                //               actions: [
                //                 TextButton(
                //                   child: Text('إلغاء'),
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                     Navigator.pop(context);
                //                   }
                //                 ),
                //                 TextButton(
                //                   child: Text('حذف'),
                //                   onPressed: () {
                //                     widget.onDelete(widget.product!);
                //                     Navigator.pop(context);
                //                   },
                //                 ),
                //               ],
                //             ),
                //           );
                //         },
                //         style: ElevatedButton.styleFrom(
                //           primary: Colors.red,
                //         ),
                //         child: Text('حذف'),
                //       ),
                //     SizedBox(width: 16.w),
                //     ElevatedButton(
                //       onPressed: () {
                //         if (_formKey.currentState!.validate()) {
                //           _formKey.currentState!.save();
                //           widget.onSave(widget.product!);
                //           Navigator.pop(context);
                //         }
                //       },
                //       child: Text('حفظ'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
