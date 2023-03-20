import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/data/model/product_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'gain_state.dart';

class GainCubit extends Cubit<GainState> {
  GainCubit() : super(GainInitial());
  List<Invoice> invoices = [];
  List<Invoice> filteredInvoices = [];
  int totalFilterGain = 0;
  int totalGain = 0;

  static GainCubit get(context) => BlocProvider.of(context);

  Future getInvoices() async {
    emit(GainLoading());
    invoices.clear();
    filteredInvoices.clear();
    SQLHelper.getInvoices().then((value) {
      totalFilterGain = 0;
      for (Map<String, dynamic> invoice in value) {
        int counter = 0;
        List<dynamic> invoiceList = jsonDecode(invoice['products']);
        List<Product> products =
            invoiceList.map((item) => Product.fromJson(item)).toList();
        List<ProductItem> productsItem = [];

        for (Product product in products) {
          productsItem
              .add(ProductItem(product: product, quantity: product.quantity));

          totalFilterGain +=
              (products[counter].sellPrice - products[counter].buyPrice) *
                  products[counter].quantity;
          counter++;
        }

        invoices.add(Invoice(
            id: invoice['id'],
            price: double.parse(invoice['price'].toString()),
            products: productsItem,
            timestamp: invoice['timestamp'],
            gain: double.parse(invoice['gain'].toString()),
            date: invoice['date'],
            hour: invoice['hour']));


        totalGain = totalFilterGain;
      }
      filteredInvoices = List.from(invoices);

      emit(GainSuccessful());
    });
  }

  Future getInvoicesByTime(int startTimestamp, int endTimestamp) async {
    filteredInvoices.clear();
    emit(Gain2Loading());

    SQLHelper.getInvoicesByTime(startTimestamp, endTimestamp).then((value) {
      totalFilterGain = 0;

      for (Map<String, dynamic> invoice in value) {
        int indicator = 0;
        List<dynamic> invoiceList = jsonDecode(invoice['products']);
        List<Product> products =
            invoiceList.map((item) => Product.fromJson(item)).toList();

        List<ProductItem> productsItem = [];

        for (Product product in products) {
          productsItem
              .add(ProductItem(product: product, quantity: product.quantity));
          totalFilterGain +=
              (products[indicator].sellPrice - products[indicator].buyPrice) *
                  products[indicator].quantity;
          indicator++;
        }

        filteredInvoices.add(Invoice(
            id: invoice['id'],
            price: double.parse(invoice['price'].toString()),
            products: productsItem,
            timestamp: invoice['timestamp'],
            gain: double.parse(invoice['gain'].toString()),
            date: invoice['date'],
            hour: invoice['hour']));

      }

      emit(Gain2Successful());
    });
  }

  Future resetInvoices() async {
    emit(GainLoading());
    filteredInvoices.clear();
    filteredInvoices = List.from(invoices);
    totalFilterGain = totalGain;
    emit(GainReset());
  }
}
