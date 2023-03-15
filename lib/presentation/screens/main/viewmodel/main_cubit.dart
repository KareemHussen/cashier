import 'package:bloc/bloc.dart';
import 'package:cashier/utils/local/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_states.dart';


class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  // List<Note> notes = [];

  static MainCubit get(context) => BlocProvider.of(context);

  Future getNotes() async {
    emit(MainLoading());
    SQLHelper.initDb();
    SQLHelper.getNotes().then((value) {
      // notes = [];
      for (Map<String, dynamic> cat in value) {
        // notes.add(Note(
        //     id: cat['id'],
        //     title: cat['title'],
        //     description: cat['description'],
        //     date: cat['date']));
      }
      emit(MainLoaded());
    });
  }

  Future refreshData()async{
    emit(MainLoading());
    SQLHelper.getNotes().then((value) {
      // notes = [];
      for (Map<String, dynamic> cat in value) {
        // notes.add(Note(
        //     id: cat['id'],
        //     title: cat['title'],
        //     description: cat['description'],
        //     date: cat['date']));
      }
      emit(MainChanged());
    }).catchError((error){
      emit(MainError());
    });
  }
}
