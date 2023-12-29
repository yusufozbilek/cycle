import 'package:bloc/bloc.dart';

class HomePageBottomAppBarNavigationCubit extends Cubit<String>{
  HomePageBottomAppBarNavigationCubit():super('Home');
  void changeCurrentPage(String route){
    emit(route);
  }
}