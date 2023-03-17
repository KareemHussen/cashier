import 'package:bloc/bloc.dart';
import 'package:cashier/data/local/database.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageInitial());
  List<Product> products = [];
  static StorageCubit get(context) => BlocProvider.of(context);

Future getProducts() async {
  emit(StorageLoading());
  SQLHelper.getproducts().then((value) {
    for (Map<String, dynamic> pro in value) {
      products.add(Product(
          id: pro['id'],
          name: pro['name'],
          quantity: pro['quantity'],
          buyPrice: pro['buyPrice'],
          sellPrice: pro['sellPrice']
      )
      );
    }
    emit(StorageSuccessful());
  });
}
}
