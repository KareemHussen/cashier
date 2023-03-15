import 'package:bloc/bloc.dart';
import 'package:cashier/data/model/Product.dart';
import 'package:cashier/data/local/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../example/example_states.dart';


class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit() : super(ExampleInitial());
  List<Product> products = [];

  static ExampleCubit get(context) => BlocProvider.of(context);

  Future getNotes() async {
    emit(ExampleLoading());
    SQLHelper.initDb();
    SQLHelper.getNotes().then((value) {
      // notes = [];
      for (Map<String, dynamic> pro in value) {
        products.add(Product(
            id: pro['id'],
            name: pro['title'],
            quantity: pro['quantity'],
            boxQuantity: pro['boxQuantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']
        )
        );
      }
      emit(ExampleLoaded());
    });
  }

  Future refreshData()async{
    emit(ExampleLoading());
    SQLHelper.getNotes().then((value) {
      products = [];
      for (Map<String, dynamic> pro in value) {
        products.add(Product(
            id: pro['id'],
            name: pro['title'],
            quantity: pro['quantity'],
            boxQuantity: pro['boxQuantity'],
            buyPrice: pro['buyPrice'],
            sellPrice: pro['sellPrice']
        )
        );
      }
      emit(ExampleChanged());
    }).catchError((error){
      emit(ExampleError());
    });
  }
}
