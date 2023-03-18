import 'package:cashier/data/model/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListItem extends StatefulWidget {
  final ProductItem productItem;
  final Function(bool) onSelect;
  final Function(int) onQuantityChanged;

  ProductListItem(
      {required this.productItem,
      required this.onSelect,
      required this.onQuantityChanged});

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  int _quantity = 1;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productItem.product.name,
                        style: TextStyle(fontSize: 28.0.sp)),
                    Text(
                        ' \$${widget.productItem.product.sellPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'arab')),
                  ],
                ),
                SizedBox(height: 4.0.h),
                Row(
                  children: [
                    Text('الكمية: ',
                        style:
                            TextStyle(fontSize: 24.0.sp, fontFamily: 'arab')),
                    SizedBox(width: 8.0.w),
                    SizedBox(
                      width: 270.0.w,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: "الحد الأقصي: " + widget.productItem.product.quantity.toString()),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: 'arab', fontSize: 28.sp),
                        onChanged: (value) {
                          if (RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                            if (int.parse(value) <=
                                widget.productItem.product.quantity) {
                              setState(() {
                                _quantity =
                                    int.tryParse(_controller.value.text) ?? 0;
                                widget.onQuantityChanged(_quantity);
                              });
                            } else {
                              alertInvalid(context, 'كمية كبيرة',
                                  'برجاء إدخال كمية مناسبة');
                            }
                          } else {
                            alertInvalid(context, 'كمية غير صحيحة',
                                'برجاء إدخال كمية صحيحة');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Checkbox(
            value: widget.productItem.selected,
            onChanged: (value) {
              setState(() {
                widget.productItem.selected = value!;
                widget.onSelect(value);
              });
            },
          ),
        ],
      ),
    );
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
    _controller.clear();
  }
}
