import 'dart:collection';

import 'package:cashier/data/model/Invoice.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/screens/storage/storage_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceCubit extends Cubit<StorageState> {
  InvoiceCubit() : super(StorageInitial());
  Invoice invoice = Invoice(products: HashMap<Product, int>(), price: 0);
  static InvoiceCubit get(context) => BlocProvider.of(context);

Future getInvoice() async {
  emit(StorageLoading());
  invoice;
  emit(StorageSuccessful());
  }
}

