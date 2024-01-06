import 'package:bloc/bloc.dart';

class HomePageBottomAppBarNavigationCubit extends Cubit<String>{
  HomePageBottomAppBarNavigationCubit():super('GoogleMaps');
  void changeCurrentPage(String route){
    emit(route);
  }
}