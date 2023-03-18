import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gain_state.dart';

class GainCubit extends Cubit<GainState> {
  GainCubit() : super(GainInitial());
  List<Invoice> invoices = [];
  List<Invoice> filteredInvoices = [];
  int totalGain = 0;
  int totalFilterGain = 0;
  static GainCubit get(context) => BlocProvider.of(context);

Future getInvoices() async {
  invoices.clear();
  emit(GainLoading());
  SQLHelper.getInvoices().then((value) {

    for (Map<String, dynamic> invoice in value) {

      List<dynamic> invoiceList = jsonDecode(invoice['products']);
      List<Product> products = invoiceList.map((item) => Product.fromJson(item)).toList();

      Invoice i = Invoice(
          id: invoice['id'],
          price: invoice['price'],
          products: products,
          time: invoice['time'],
          gain: invoice['gain'],
          date: invoice['date'],
          hour: invoice['hour']
      );

      invoices.add(Invoice(
          id: invoice['id'],
          price: invoice['price'],
          products: products,
          time: invoice['time'],
          gain: invoice['gain'],
          date: invoice['date'],
          hour: invoice['hour']
      )
      );
    }
    totalFilterGain = totalGain;
    filteredInvoices = List.from(invoices);

    emit(GainSuccessful());
  });

}

Future getInvoicesByTime(int startTimestamp , int endTimestamp) async{
  filteredInvoices.clear();
  emit(GainLoading());

  SQLHelper.getInvoicesByTime(startTimestamp, endTimestamp).then((value) {

      for (Map<String, dynamic> invoice in value) {

        List<dynamic> invoiceList = jsonDecode(invoice['products']);
        List<Product> products = invoiceList.map((item) => Product.fromJson(item)).toList();

        filteredInvoices.add(Invoice(
            id: invoice['id'],
            price: invoice['price'],
            products: products,
            time: invoice['time'],
            gain: invoice['gain'],
            date: invoice['date'],
            hour: invoice['hour']
        )

        );
      }

      emit(GainSuccessful());
    });

  }

Future resetInvoices() async{
    emit(GainLoading());
    filteredInvoices = List.from(invoices);;
    print("${invoices.length}  oooooooo");
    totalFilterGain = totalGain;
    emit(GainReset());

  }

}
