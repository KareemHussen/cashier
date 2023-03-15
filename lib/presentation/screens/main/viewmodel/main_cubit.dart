import 'package:bloc/bloc.dart';
import 'package:cashier/model/Product.dart';
import 'package:cashier/utils/local/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_states.dart';


class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  List<Product> products = [];

  static MainCubit get(context) => BlocProvider.of(context);

  Future getNotes() async {
    emit(MainLoading());
    SQLHelper.initDb();
    SQLHelper.getNotes().then((value) {
      // notes = [];
      for (Map<String, dynamic> pro in value) {
        products.add(Product(
            id: pro['id'],
            name: pro['title'],
            price: pro['price'],
            quantity: pro['quantity'],
            boxQuantity: pro['boxQuantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']
        )
        );
      }
      emit(MainLoaded());
    });
  }

  Future refreshData()async{
    emit(MainLoading());
    SQLHelper.getNotes().then((value) {
      products = [];
      for (Map<String, dynamic> pro in value) {
        products.add(Product(
            id: pro['id'],
            name: pro['title'],
            price: pro['price'],
            quantity: pro['quantity'],
            boxQuantity: pro['boxQuantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']
        )
        );
      }
      emit(MainChanged());
    }).catchError((error){
      emit(MainError());
    });
  }
}
