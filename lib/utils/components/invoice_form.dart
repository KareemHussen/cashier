import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/utils/components/invoice_item.dart';
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
  List<Product>? cartItems;
  List<Product> products = <Product>[];
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
    widget.cartItems ?? <Product>[];
    widget.invoice ?? Invoice(products: <Product>[], price: 0);
  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.invoice == null;
    if (flag) {
      widget.invoice = Invoice(products: <Product>[], price: 0);
    }
    SQLHelper.getproducts().then((value) {
      for (Map<String, dynamic> pro in value) {
        widget.products.add(Product(
            id: pro['id'],
            name: pro['name'],
            quantity: pro['quantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']));
      }
    });

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
                      final ttf = await fontFromAssetBundle('assets/font.ttf');
                      final doc = pw.Document();
                      doc.addPage(pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return pw.Column(children: [
                              pw.Center(child: pw.Text( ' التاريخ و الوقت '
                                  , style: pw.TextStyle(font: ttf, fontSize: 30))),
                              pw.Column(
                                  children: List.generate(
                                      widget.cartItems?.length ?? 0,
                                      (index) => printerItem(
                                          widget.cartItems?[index] ??
                                              Product(
                                                  id: -1,
                                                  name: 'error',
                                                  quantity: -1,
                                                  buyPrice: -1,
                                                  sellPrice: -1),
                                          4,
                                          index , ttf))),
                            ]); // Center
                          })); // Page
                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => doc.save());
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
                  onChanged: (p) {
                    widget.cartItems = p;
                    List.generate(
                        widget.cartItems?.length ?? 0, (index) => null);
                  },
                  compareFn: (p1, p2) => p1.id == p2.id,
                  filterFn: (p, q) =>
                      p.name.toLowerCase().contains(q.toLowerCase()),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 16.h),
                Column(
                  children:
                      List.generate(widget.cartItems?.length ?? 0, (index) {
                    return Row(
                      children: [
                        InvoiceItem(p: widget.cartItems![index]),
                        TextButton(
                            onPressed: () => _removeItem(index),
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

  void _removeItem(int i) {
    setState(() => widget.cartItems?.removeAt(i));
  }

  pw.Row printerItem(Product p, int quantity, int index , pw.Font ttf) {
    return pw.Row(
      children: [
        pw.Text((index + 1).toString()),
        pw.Text('${p.name} أسم المنتج ' , style: pw.TextStyle(font: ttf, fontSize: 20)) ,
        pw.Text('${p.sellPrice} سعر المنتج ', style: pw.TextStyle(font: ttf, fontSize: 20)),
      ],
    );
  }
}
