import 'package:cashier/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceItem extends StatefulWidget {
  final Product p;
  const InvoiceItem({Key? key, required this.p}) : super(key: key);
  @override
  State<InvoiceItem> createState() => _InvoiceItemState();
}

class _InvoiceItemState extends State<InvoiceItem> {
  late Product p;
  @override
  void initState() {
    super.initState();
    // Set the initial values for the fields based on the product
    p = widget.p;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          p.name,
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
        ),
        TextField(
          autocorrect: false,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
              hintText: 'الكمية'
          ),
        )
      ],
    );
  }
}
