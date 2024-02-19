import 'package:SnapTrash/main.dart';
import 'package:SnapTrash/pages/locationPages/locationPrompt.dart';
import 'package:SnapTrash/properties/colourProp.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationModule {
  static String? locationMessage;
  late String lat;
  late String long;

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

  void getLocation() async {
    try {
      // Get current location
      final value = await getCurrentLocation();
      lat = '${value.latitude}';
      long = '${value.longitude}';
      locationMessage = 'latitude: $lat, Longitude: $long';
      print(locationMessage);
    } catch (e) {
      print('Error: $e');
      // Handle errors if needed
    }
  }
}