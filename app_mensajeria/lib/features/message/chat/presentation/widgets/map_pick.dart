import 'package:app_mensajeria/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPagePicker extends StatefulWidget {
  const MapPagePicker({super.key});

  @override
  State<MapPagePicker> createState() => _MapPagePickerState();
}

class _MapPagePickerState extends State<MapPagePicker> {
  LocationData? currentLocation;
  LatLng? markerPosition;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  }

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null
        ? WillPopScope(
            onWillPop: onWillPop,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: markerPosition ?? LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                    ),
                  },
                  onTap: (LatLng position) {
                    setState(() {
                      markerPosition = position;
                    });
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: FloatingActionButton(
                    backgroundColor: DarkModeColors.accentColor,
                    onPressed: () {
                      if (markerPosition != null) {
                        Navigator.pop(context, [markerPosition!.latitude, markerPosition!.longitude]);
                      }
                    },
                    child: const Icon(Icons.location_on),
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
