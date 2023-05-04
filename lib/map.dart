import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _origen = CameraPosition(
    target: LatLng(-16.511193,-68.124061),
    zoom: 14.4746,
  );

  final Marker _inicio = const Marker(
      markerId:MarkerId("Inicio"),
      infoWindow: InfoWindow(title: "Inicio"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-16.511193,-68.124061),
  );
  final Marker _final = const Marker(
      markerId:MarkerId("Fin"),
      infoWindow: InfoWindow(title: "Fin"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(-16.523084,-68.111863),
  );

  static const CameraPosition _destino = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-16.523084,-68.111863),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static const Polygon linea=Polygon(
    polygonId: PolygonId("Destino1"),
    points: [LatLng(-16.511193,-68.124061),LatLng(-16.516318,-68.118647),LatLng(-16.511912,-68.119525),LatLng(-16.520649,-68.115985),LatLng(-16.523728,-68.112670),LatLng(-16.523084,-68.111863),],
    strokeWidth: 5,
    );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Trasa"),),
      body: GoogleMap(
        mapType: MapType.normal,
        markers:{_inicio,_final},
        polygons: {linea},
        initialCameraPosition: _origen,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_destino));
  }
}