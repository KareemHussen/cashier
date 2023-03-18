import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/gain/gain_cubit.dart';
import 'package:cashier/utils/components/InvoiceList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/components/product_list.dart';

class Gain extends StatelessWidget {
  Gain({Key? key}) : super(key: key);
  List<Invoice> invoices = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('سجل الفواتير')),
        ),
        body: BlocConsumer<GainCubit, GainState>(
          listener: (context, state) {},
          builder: (context, state) {
            invoices = GainCubit.get(context).invoices;

            return InvoiceList(
              invoices: invoices,
            );
          },
        ),
      ),
    );
  }
}
