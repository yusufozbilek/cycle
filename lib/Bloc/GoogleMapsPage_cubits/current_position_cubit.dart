import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
class CurrentPositionCubit extends Cubit<Position> {
  var CallTime = 0;
  CurrentPositionCubit()
      : super(Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0));

  Future<void> getCurrentLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    CallTime++;
    print("###############################Calltime: $CallTime ${state.longitude}######################################");

    emit(currentPosition);
  }
}
