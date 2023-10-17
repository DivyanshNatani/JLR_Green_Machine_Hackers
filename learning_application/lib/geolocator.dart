import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> getCurrentLocation() async {
  try {
    print('BBBBBBBBBBBBBBBBBBBBBBBB');
    LocationPermission permission; permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
      print('Latitude: ${position!.latitude}');
      print('Longitude: ${position!.longitude}');

  } catch (e) {
    print('Error fetching geolocation data: $e');
  }
}
