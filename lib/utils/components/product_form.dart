import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductForm extends StatefulWidget {
  final String buttonText;
  Product? product;
  final Function(Product) onSave;
  final Function(Product) onDelete;
  final Function(Product) onEdit;

  ProductForm({
    required this.buttonText,
    required this.product,
    required this.onSave,
    required this.onDelete,
    required this.onEdit
  });

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    bool flag = widget.product == null;
    if (flag)
      widget.product =
          Product(id: 0,
              name: '',
              quantity: 0,
              buyPrice: 0,
              sellPrice: 0);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(flag ? 'إضافة منتج جديد' : 'تعديل المنتج'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(400.w, 300.h, 400.w, 180.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: widget.product!.name,
                  decoration: const InputDecoration(
                    labelText: 'اسم المنتج',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال اسم';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.product!.name = value!;
                  },                  onChanged: (value) {
                  widget.product!.name = value;
                },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.product!.quantity.toString(),
                  decoration: const InputDecoration(
                    labelText: 'الكمية',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال كمية';
                    }
                    if (int.tryParse(value) == null) {
                      return 'برجاء إدخال كمية صحيحة';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.product!.quantity = int.parse(value!);
                  },                  onChanged: (value) {
                  widget.product!.quantity = int.parse(value);
                },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.product!.buyPrice.toString(),
                  decoration: const InputDecoration(
                    labelText: 'سعر الشراء',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال سعر شراء ';
                    }
                    if (double.tryParse(value) == null) {
                      return 'برجاء إدخال سعر شراء صحيح';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.product!.buyPrice = int.parse(value!);
                  },                  onChanged: (value) {
                  widget.product!.buyPrice = int.parse(value);
                },
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  initialValue: widget.product!.sellPrice.toString(),
                  decoration: const InputDecoration(
                    labelText: 'سعر البيع',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجاء إدخال سعر البيع';
                    }
                    if (double.tryParse(value) == null) {
                      return 'برجاء إدخال سعر بيع صحيح';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.product!.sellPrice = int.parse(value!);
                  },
                  onChanged: (v){
                    widget.product!.sellPrice = int.parse(v);
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 16.w),
                    (flag)?ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                         widget.product!.id = await SQLHelper.addProduct(
                              widget.product!.name, widget.product!.quantity,
                              widget.product!.buyPrice,
                              widget.product!.sellPrice);
                          _formKey.currentState!.save();
                          widget.onSave(widget.product!);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('حفظ'),
                    ):ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          SQLHelper.updateProduct(widget.product!.id!,
                              widget.product!.name, widget.product!.quantity,
                              widget.product!.buyPrice,
                              widget.product!.sellPrice);
                          _formKey.currentState!.save();
                          widget.onEdit(widget.product!);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('حفظ'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
