import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle/Bloc/GoogleMapsPage_cubits/current_position_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({super.key});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  late GoogleMapController _controller;
  late LatLng selectedLatLng;
  String routeDistance = "~";
  String routeDuration = "~";
  String lastClickedPoint = "";
  BitmapDescriptor markerBitmap = BitmapDescriptor.defaultMarker;
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CurrentPositionCubit()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
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
                    return const Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Google Maps Loading"),CircularProgressIndicator()],));
                  }
                  if (snapshot.hasData) {
                    var locationList = snapshot.data!.docs;
                    //markers.clear();
                    for (var document in locationList) {
                      GeoPoint geoLocation = document.get("Location");
                      final latLng =
                          LatLng(geoLocation.latitude, geoLocation.longitude);
                      markers.add(Marker(
                        markerId: MarkerId(document.id),
                        position: latLng,
                        icon: markerBitmap,
                        consumeTapEvents: false,
                        infoWindow: InfoWindow(
                            title: document.get("LocationName"), onTap: () {}),
                        onTap: () {
                          showModalBottomSheet(
                              useRootNavigator: true,
                              barrierColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setModalState) {
                                  String _routeDistance = routeDistance;
                                  String _routeDuration = routeDuration;
                                  if (document.id != lastClickedPoint) {
                                    _routeDistance = "~";
                                    _routeDuration = "~";
                                  }
                                  return Container(
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height /6.5,
                                    constraints: const BoxConstraints(minHeight: 143),
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        boxShadow: null,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Text(
                                                "${document.get("LocationName")}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24)),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.directions_walk,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    _routeDuration,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.route,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    _routeDistance,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: FilledButton(
                                                onPressed: () {
                                                  requestPermissionL();
                                                  lastClickedPoint =
                                                      document.id;
                                                  _getPolyline(
                                                          document.id,
                                                          LatLng(
                                                              geoLocation
                                                                  .latitude,
                                                              geoLocation
                                                                  .longitude))
                                                      .then((value) => {
                                                            setModalState(() {
                                                              _routeDistance =
                                                                  routeDistance;
                                                              _routeDuration =
                                                                  routeDuration;
                                                              debugPrint(
                                                                  "this works properly");
                                                            })
                                                          });
                                                },
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.directions),
                                                    Text("Directions")
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }).whenComplete(() => null);
                        },
                      ));
                    }

                    return BlocBuilder<CurrentPositionCubit, Position>(
                      builder: (context, position) {
                        return GoogleMap(
                          onMapCreated: (GoogleMapController controller) async {
                            markerBitmap =
                                await BitmapDescriptor.fromAssetImage(
                              const ImageConfiguration(size: Size(32, 32)),
                              "assets/recycle_location.png",
                            );
                            setState(() {
                              debugPrint("Image Probably Loaded");
                            });

                            _controller = controller;
                          },
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(41, 28), zoom: 8),
                          markers: markers,
                          polylines: polyLines,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                        );
                      },
                    );
                  }
                  return Placeholder();
                })),
      ),
    );
  }

  Future<void> _getPolyline(String id, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    List<LatLng> alternativePolylineCoordinates = [];
    Position currentLocation = await Geolocator.getCurrentPosition();
    PolylinePoints polylinePoints = PolylinePoints();
    polyLines.clear();
    /*PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBAgUaH_Q9Hg1ZL4qsRE_oXsrk5tHDb-Is",
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.walking,
    );*/
    List<PolylineResult> result = await polylinePoints.getRouteWithAlternatives(
        request: PolylineRequest(
            apiKey: "AIzaSyBAgUaH_Q9Hg1ZL4qsRE_oXsrk5tHDb-Is",
            origin: PointLatLng(
                currentLocation.latitude, currentLocation.longitude),
            destination:
                PointLatLng(destination.latitude, destination.longitude),
            mode: TravelMode.walking,
            wayPoints: List.empty(),
            avoidHighways: true,
            avoidTolls: false,
            avoidFerries: false,
            optimizeWaypoints: false,
            alternatives: true));
    if (result.first.points.isNotEmpty) {
      result.first.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    if (result.first.alternatives.isNotEmpty) {
      result.first.alternatives.forEach((PointLatLng alternativePoint) {
        alternativePolylineCoordinates
            .add(LatLng(alternativePoint.latitude, alternativePoint.longitude));
        debugPrint(
            "coordinates:${alternativePoint.latitude},${alternativePoint.longitude}");
      });
    } else {
      debugPrint("Empty");
    }

    Polyline polyline = Polyline(
      polylineId: PolylineId("Path"),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );

    /*TODO add alternative ways*/
    Polyline alternativePolyline = Polyline(
      polylineId: PolylineId("Alternative"),
      color: Colors.grey,
      points: alternativePolylineCoordinates,
      width: 3,
    );
    setState(() {
      polyLines.add(polyline);
      polyLines.add(alternativePolyline);
      routeDistance = result.first.distance!;
      routeDuration = result.first.duration!;
    });
  }
  Future<void> requestPermissionL() async {
    final permission = Permission.location;

    if (await permission.isDenied) {
      var result = await permission.request();
      if (result.isGranted) {
        Text("izin verildi");
      } else if (result.isDenied) {
        Text("reddedildi");
      } else if (result.isPermanentlyDenied) {
        Text("BAMBAM");
      }
    }
  }
}
