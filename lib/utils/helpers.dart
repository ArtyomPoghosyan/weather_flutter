import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheather/service/index.dart';

import '../store/common.dart';

class Helper {
  static getCurrentDay(dynamic data) {
    final DateFormat dateFormat = DateFormat.yMd();
    final String foramttedDate = dateFormat.format(data);
    return foramttedDate as dynamic;
  }

  static Future<void> getLocation(bool? search) async {
    CommonStore commonStore = CommonStore();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    print('4655555555555aloooooooo${placemark[0]}');
    String currentCity = placemark[0].locality!;
    // print("79879879879879879879898798798${currentCity}");
    if (currentCity.isNotEmpty) {
      commonStore.setCurrentLocationPlace(currentCity);
    }
    // print(search);
    // getWeatherData();
  }

  static Future<void> getWeatherData(BuildContext context) async {
    CommonStore commonStore = CommonStore();
    try {
      final response = await WeatherService.getCurrentCityWeatherData(
          commonStore.cityName.isNotEmpty
              ? commonStore.cityName
              : commonStore.currentLocationPlace);
      if (response != null && response is List) {
        commonStore.setWeatherData(response as dynamic);
      } else {
        final snackBar = SnackBar(
          content: Text(
            response.toString(),
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      void ShowErrorMessage(BuildContext context, {required String e}) {
        final snackBar = SnackBar(
          content: Text(
            e,
            style: TextStyle(color: Colors.green),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
