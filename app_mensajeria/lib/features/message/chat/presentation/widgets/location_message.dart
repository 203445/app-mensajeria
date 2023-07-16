import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMessage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const LocationMessage(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<LocationMessage> createState() => _LocationMessageState();
}

class _LocationMessageState extends State<LocationMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      height: 135,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 15,
        ),
        zoomGesturesEnabled: true,
        
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            position: LatLng(widget.latitude, widget.longitude),
          ),
        },
      ),
    );
  }
}
