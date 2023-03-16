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
            if (widget.title != null)
              Center(
                child: Text(
                  widget.title!,
                  style: TextStyle(fontSize: 48.sp),
                ),
              ),
            if (widget.subtitle != null)
              Center(
                child: Text(
                  widget.subtitle!,
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
            SizedBox(height: 32.h),
            // Display the common factors
// Display the search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
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
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      Product product = filteredProducts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (String factor in commonFactors)
                                Expanded(
                                  child: Text(
                                    product.toMap()[factor].toString(),
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              widget.admin!
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          child: Text('تعديل'),
                                          onPressed: () {
                                            _editProduct(product.id!);
                                          },
                                        ),
                                        SizedBox(width: 8.w),
                                        ElevatedButton(
                                          child: Text('حذف'),
                                          onPressed: () {
                                            _deleteProduct(product.id!);
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
                                  : SizedBox(
                                      width: 0,
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
                      child: Text('إضافة منتج جديد'),
                    ),
                  )
                : SizedBox(),
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
          title: Text('حذف المنتج'),
          content: Text('هل تريد حذف هذا المنتج؟'),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                SQLHelper.deleteProduct(productId);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('حذف'),
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
          onSave: (product) {
            setState(() {
              SQLHelper.updateProduct(productId, product.name, product.quantity,
                  product.buyPrice, product.sellPrice);
              products[products.indexWhere((p) => p.id == product.id)] =
                  product;
            });
            // Navigator.of(context).pop();
          },
          onDelete: (product) {
            setState(() {
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
            setState(() {
              SQLHelper.addProduct(product.name, product.quantity,
                  product.buyPrice, product.sellPrice);
              products.add(product);
            });
            // Navigator.of(context).pop();
          },
          product: null,
          onDelete: (Product) {},
        ),
      ),
    );
  }
}
