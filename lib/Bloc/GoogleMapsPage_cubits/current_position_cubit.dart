import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class CurrentPositionCubit extends Cubit<Position>{
  CurrentPositionCubit():super(Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0,headingAccuracy: 0));
  Future<void> getCurrentPosition() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
      var currentPosition = await Geolocator.getCurrentPosition();
      emit(currentPosition);
  }
}