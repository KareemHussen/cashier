import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/components/product_list.dart';

class Storage extends StatelessWidget {
  Storage({Key? key}) : super(key: key);
  String? title = 'إدارة المخزن';
  List<Product> products = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title!)),
      ),

      body: BlocConsumer<StorageCubit, StorageState>(
        listener: (context, state) {
        },
        builder: (context, state) {
        products = StorageCubit.get(context).products;
          return ProductList(
              products: products,
              title: null,
              subtitle: null,
              admin: true
          );
        },
      ),
    );
  }

}