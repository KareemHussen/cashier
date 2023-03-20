import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/data/model/product_item.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/utils/components/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/print/print_pdf.dart';

class ProductSelectionScreen extends StatefulWidget {
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  final List<ProductItem> _selectedProducts = [];
  List<Product> _products = [];
  List<ProductItem> productItemList = [];
  List<ProductItem> filteredItemList = [];
  double total = 0.0;
  double totalSell = 0.0;
  String searchQuery = '';

  void _onProductSelect(ProductItem product, bool selected) {
    setState(() {
      if (selected) {
        if (!_selectedProducts.contains(product)) {
          _selectedProducts.add(product);
          var sell = product.product.sellPrice * product.quantity;
          total += sell;
          totalSell += (sell - (product.product.sellPrice * product.quantity));
        }
      } else {
        var sell = product.product.sellPrice * product.quantity;
        total -= sell;
        _selectedProducts.remove(product);
      }
    });
  }

  void _onProductQuantityChanged(ProductItem product, int quantity) {
    setState(() {
      product.quantity = quantity;
      if (product.selected) {
        total = 0;
        for (ProductItem item in _selectedProducts) {
          if (item.quantity != 0) {
            total += item.product.sellPrice * item.quantity;
          }
        }
      }
    });
  }

  void alertInvalid(BuildContext context, String title, String subtitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
              child: const Text('حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // _controller.clear();
  }


  @override
  void initState() {
    super.initState();
    _products = StorageCubit.get(context).products;
    _products.sort((a, b) => a.name.compareTo(b.name));

    for (Product item in _products) {
      productItemList
          .add(ProductItem(product: item, quantity: 0, selected: false));
    }
    filteredItemList = productItemList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'إنشاء فاتورة',
            style: TextStyle(fontFamily: 'arab'),
          )),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      style: const TextStyle(fontFamily: 'arab'),
                      decoration: const InputDecoration(
                        hintText: 'البحث عن منتج',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          productItemList = filteredItemList
                              .where((product) =>
                                  product.product.name
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()) ||
                                  product.product.id
                                      .toString()
                                      .contains(searchQuery.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const Text('-     العناصر المتاحة',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'arab')),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productItemList.length,
                      itemBuilder: (context, index) {
                        return ProductListItem(
                          productItem: productItemList[index],
                          onSelect: (selected) {
                            _onProductSelect(productItemList[index], selected);
                          },
                          onQuantityChanged: (quantity) =>
                              _onProductQuantityChanged(
                                  productItemList[index], quantity),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 915.h,
                width: 1.w,
                color: Colors.black,
                margin: EdgeInsets.only(left: 30.w, right: 30.w)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text('-     عناصر الفاتورة',
                      style: TextStyle(fontSize: 20.0.sp, fontFamily: 'arab')),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _selectedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _selectedProducts[index];
                        return ListTile(
                          title: Text(product.product.name),
                          subtitle: Text(
                              'سعر البيع: ${(product.product.sellPrice * product.quantity).toStringAsFixed(2)}ج.م \n الكمية: ${product.quantity}'),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(50.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () async{
                              var filtered = productItemList
                                  .where((element) => element.quantity > 0)
                                  .toList();
                              if(filtered.isNotEmpty) {
                                await PrintPdf.checkOut(
                                  Invoice(
                                      products: filtered,
                                      price: total,
                                      gain: totalSell,
                                      timestamp: DateTime.now().millisecondsSinceEpoch,
                                      hour: DateTime.now().hour.toString(),
                                      date: DateTime.now().toString()),
                                  context);
                                Navigator.pop(context);
                              }
                              else{
                                alertInvalid(context , "الكمية فارغة", "أدخل كمية صحيحة لا تساوي 0");
                              }
                            },
                            child: const Text(
                              'حفظ وطباعة',
                              style: TextStyle(fontFamily: 'arab'),
                            )),
                        Text(
                          'إجمالي الفاتورة: $total ج.م.',
                          style: TextStyle(
                              fontFamily: 'arab',
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
