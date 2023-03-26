import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/utils/components/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductList extends StatefulWidget {
  List<Product> products;
  final String? title;
  final String? subtitle;
  final bool? admin;
  late String searchQuery;
  late List<Product> filteredProducts;

  ProductList({required this.products, this.title, this.subtitle, this.admin});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
    products = widget.products;
    filteredProducts = products;
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
            if (products.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  style: const TextStyle(fontFamily: 'arab'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 900.w, 0),
                    hintText: 'البحث عن منتج',
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      filteredProducts = products
                          .where((product) =>
                              product.name
                                  .toLowerCase()
                                  .startsWith(searchQuery.toLowerCase()) ||
                              product.id
                                  .toString()
                                  .startsWith(searchQuery.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
            if (products.isNotEmpty)
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
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'arab'),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Text(
                              arabic[commonFactors.indexOf(factor)],
                              style: TextStyle(
                                  fontSize: 28.sp, fontWeight: FontWeight.bold, fontFamily: 'arab'),
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
                              fontFamily: 'arab'),
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
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'arab'),
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
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'arab'),
                                              ),
                                            ),
                                    widget.admin!
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                child: const Text(
                                                  'تعديل',
                                                  style: TextStyle(
                                                      fontFamily: 'arab'),
                                                ),
                                                onPressed: () {

                                                  setState(() {_editProduct(product.id!);});
                                                },
                                              ),
                                              SizedBox(width: 8.w),
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _deleteProduct(product.id!);
                                                  });
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
                                        : SizedBox(
                                            width: 160.w,
                                            height: 0,
                                          ),
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
            (widget.admin!)
                ? Center(
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      child: const Text(
                        'إضافة منتج جديد',
                        style: TextStyle(fontFamily: 'arab'),
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: 25.h)
          ],
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
                SQLHelper.deleteProduct(productId);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('حذف'),
              onPressed: () {
                setState(() {
                  SQLHelper.deleteProduct(productId);
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

  void _editProduct(int productId) {
    Product selectedProduct =
        products.firstWhere((product) => product.id == productId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(
          buttonText: "edit",
          product: selectedProduct,
          onEdit: (product) {
            setState(() {
              products[products.indexWhere((p) => p.id == product.id)] =
                  product;
            });
          },
          onSave: (product) {},
          onDelete: (product) {
            setState(() {
              SQLHelper.deleteProduct(productId);
              products.removeWhere((p) => p.id == product.id);
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(
          buttonText: "add",
          onSave: (product) {
            products.add(product);
            setState(() {});
          },
          onEdit: (Product) {},
          product: null,
          onDelete: (Product) {},
        ),
      ),
    );
  }
}
