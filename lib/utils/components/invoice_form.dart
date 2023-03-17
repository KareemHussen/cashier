import 'dart:collection';

import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/utils/components/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/Invoice.dart';

class InvoiceForm extends StatefulWidget {
  //final String buttonText;
  Invoice? invoice;
  HashMap<Product, int> cartItems = HashMap<Product, int>();
  List<Product> products = <Product>[];
  List<Product> items = <Product>[];
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
  final List<String> commonFactors = [
    'name',
    'id',
    'quantity',
    'buyPrice',
    'sellPrice',
  ];
  late List<Product> products;
  late List<Product> filteredProducts;
  String searchQuery = '';
  final List<String> arabic = [
    'اسم المنتج',
    'رقم المنتج',
    'الكمية',
    'سعر الشراء',
    'سعر البيع',
  ];

  @override
  void initState() {
    super.initState();
    products = widget.products = StorageCubit.get(context).products;
    filteredProducts = products;
    widget.cartItems;
    widget.invoice ?? Invoice(products: widget.cartItems, price: 0);
  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.invoice == null;
    if (flag) {
      widget.invoice = Invoice(products: widget.cartItems, price: 0);
    }
    widget.products = StorageCubit.get(context).products;
    var products = widget.products = StorageCubit.get(context).products;
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
              children: <Widget>[
                if (products.isNotEmpty) //Search
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 820.w, 0),
                        hintText: 'البحث عن منتج',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          filteredProducts = products
                              .where((product) =>
                                  product.name
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()) ||
                                  product.id
                                      .toString()
                                      .contains(searchQuery.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                if (products.isNotEmpty) //Titles
                  Row(
                    children: [
                      for (String factor in commonFactors)
                        (factor == 'name')
                            ? Expanded(
                                flex: 2,
                                child: Text(
                                  arabic[commonFactors.indexOf(factor)],
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: Text(
                                  arabic[commonFactors.indexOf(factor)],
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      const SizedBox(width: 130)
                    ],
                  ),
                SizedBox(height: 16.h),
                // Display the individual items
                (products.isEmpty)
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 400.h),
                            Text(
                              "لا يوجد شئ للعرض",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 12,
                                  blurRadius: 50,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                Product product = filteredProducts[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        for (String factor in commonFactors)
                                          (factor == 'name')
                                              ? Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    maxLines: 1,
                                                    product
                                                        .toJson()[factor]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    maxLines: 1,
                                                    product
                                                        .toJson()[factor]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 28.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              child: const Text('اضافة'),
                                              onPressed: () {
                                                _addProduct(product);
                                              },
                                            ),
                                            SizedBox(width: 8.w),
                                            ElevatedButton(
                                              onPressed: () {
                                                _deleteProduct(product.id!);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                              ),
                                              child: const Text('حذف'),
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
                SizedBox(height: 25.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteProduct(int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حذف المنتج'),
          content: const Text('هل تريد حذف هذا المنتج؟'),
          actions: <Widget>[
            TextButton(
              child: const Text('إلغاء'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('حذف'),
              onPressed: () {
                setState(() {
                  products.removeWhere((product) => product.id == productId);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _addProduct(Product p){
    InvoiceCubit.get(context).invoice.products[p]=1;
  }
}

/*
Column(
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
Invoice invoice = Invoice(products: widget.cartItems,
price: total , timestamp: DateTime.now().millisecondsSinceEpoch);
// Page
PrintPdf.checkOut(invoice);
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
)*/
