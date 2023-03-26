import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:flutter/material.dart';
import '../../utils/components/product_list.dart';

class Shorfalls extends StatelessWidget {
  Shorfalls({Key? key}) : super(key: key);
  String? title = 'جرد النواقص';
  List<Product> products = [];


  @override
  Widget build(BuildContext context) {
    products = StorageCubit.get(context).products.where((product) => product.quantity <= 10).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(title!)),
        ),
        body: ProductList(
                products: products,
                title: null,
                subtitle: null,
                admin: false
            )
        ),
    );
  }

}