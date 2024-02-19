import 'package:SnapTrash/pages/locationPages/locationPrompt.dart';
import 'package:SnapTrash/properties/colourProp.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class getLocationCoordinates extends StatefulWidget {
  const getLocationCoordinates({super.key});
  static String? locationMessage;

  @override
  State<getLocationCoordinates> createState() => _getLocationCoordinatesState();
}

class _getLocationCoordinatesState extends State<getLocationCoordinates> {
  late String lat;
  late String long;
  late String? locationMessage;

  // for location to work
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location services are dissabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location Permission are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'locationpermission denied,  we cannot process request',
      );
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    String? locationMessagePass() {
      return locationMessage;
    }

    // size variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: () {
        getCurrentLocation().then(
          (value) {
            lat = '${value.latitude}';
            long = '${value.longitude}';
            locationMessage = 'latitude: $lat, Longitude: $long';
            print(locationMessage);
          },
        );
        Navigator.push(
          context,
          DialogRoute(
            context: context,
            builder: (context) => const locationPromptPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.black,
        elevation: 0,
      ),
      child: Icon(
        Icons.circle_outlined,
        size: screenheight * 0.1,
        color: rangBackground,
      ),
    );
  }
}