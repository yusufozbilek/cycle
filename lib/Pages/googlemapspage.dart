import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle/Bloc/GoogleMapsPage_cubits/current_position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrentPositionCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future:
                    FirebaseFirestore.instance.collection("Locations").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong!"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No Data Available!"));
                  }
                  if (snapshot.hasData) {
                    var locationList = snapshot.data!.docs;
                    markers.clear();
                    for (var document in locationList) {
                      GeoPoint geoLocation = document.get("Location");
                      final latLng =
                          LatLng(geoLocation.latitude, geoLocation.longitude);
                      markers.add(Marker(
                          markerId: MarkerId("Location"),
                          position: latLng,
                          infoWindow:
                              InfoWindow(title: document.get("LocationName")),
                      onTap: () {Show},
                      ));
                    }

                    return GoogleMap(
                      initialCameraPosition:
                          const CameraPosition(target: LatLng(0, 0), zoom: 12),
                      markers: markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    );
                  }
                  return Placeholder();
                })),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              markers.add(Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(
                      context.read<CurrentPositionCubit>().state.latitude,
                      context.read<CurrentPositionCubit>().state.longitude)));
            },
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            )),
      ),
    );
  }
}
