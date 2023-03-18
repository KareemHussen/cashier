import 'dart:collection';

import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/storage/storage.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/utils/components/invoice_item.dart';
import 'package:cashier/utils/prtint/print_pdf.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


import '../../data/model/Invoice.dart';

class InvoiceForm extends StatefulWidget {
  //final String buttonText;
  Invoice? invoice;
  HashMap<Product , int> cartItems = HashMap<Product , int>();
  List<Product> products = <Product>[];
  List<Product> items =<Product>[Product(id: 0, name: ",kdd", quantity: 4, buyPrice: 3, sellPrice: 5)];
  // final Function(Invoice) onSave;
  // final Function(Invoice) onDelete;

  InvoiceForm({this.invoice
      // required this.products,
      // required this.buttonText,
      // required this.invoice,
      // required this.onSave,
      // required this.onDelete,
      });

  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set the initial values for the fields based on the product
    widget.cartItems;
    // widget.invoice ?? Invoice(products: widget.cartItems, price: 0, time: null, gain: null, date: '', hour: '');
  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.invoice == null;
    if (flag) {
      // widget.invoice = Invoice(products: widget.cartItems, price: 0);
    }
    widget.products = StorageCubit.get(context).products;
    var items = widget.items;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحرير فاتورة'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(400.w, 50.h, 400.w, 200.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      double total = 0;
                      widget.cartItems.forEach((key, value) {
                        items.add(key);
                        total+=key.sellPrice * value;
                      });
                      // Invoice invoice = Invoice(products: widget.cartItems,
                      //     price: total , timestamp: DateTime.now().millisecondsSinceEpoch);
                      // // Page
                      // PrintPdf.checkOut(invoice);
                    },
                    child: const Text('حفظ و طباعة الفاتورة')),
                DropdownSearch<Product>.multiSelection(
                  items: widget.products,
                  // popupProps: const PopupProps.menu(
                  //   showSelectedItems: true,
                  // ),
                  itemAsString: (item) => item.name,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "المنتجات",
                      hintText: "اختر المنتجات",
                    ),
                  ),
                  onChanged: (p) { for (var element in p)
                  {widget.cartItems[element] = widget.cartItems[element] ?? 1;}
                  setState(() {
                    items = p;
                  });}                    ,
                  compareFn: (p1, p2) => p1.id == p2.id,
                  filterFn: (p, q) =>
                      p.name.toLowerCase().contains(q.toLowerCase()),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 16.h),
                Column(
                  children:
                      List.generate(items.length, (index) {
                    return Row(
                      children: [
                        InvoiceItem(p: items[index]),
                        TextButton(
                            onPressed: () => _removeItem(items[index]),
                            child: const Text('حذف'))
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeItem(Product i) {
    setState(() {
      widget.cartItems.remove(i);
      widget.items.remove(i);
    });
  }

}
