import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class WeatherData {
  final List<dynamic>? weatherList;
  final dynamic? error;

  WeatherData({this.weatherList, this.error});
}

class WeatherService {
  static final String apiKey = 'dc2161992faeb4de058015de3b83db3f';
  static final String baseUrl =
      'https://api.openweathermap.org/data/2.5/forecast';
  static Future<dynamic> getCurrentCityWeatherData(dynamic cityName) async {
    final uri = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');
    final dynamic response = await http.post(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      final result = json['list'] as List<dynamic>;
      return result;
    } else {
      final error = jsonDecode(response.body) as dynamic;
      return error;
    }
  }
}
