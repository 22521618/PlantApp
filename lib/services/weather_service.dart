import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plant_app/models/weather_model.dart';

class WeatherService {
  static const URL =
      "https://api.openweathermap.org/data/2.5/weather?id=1566083&units=metric&appid=20a16bf830bcf5f44df272ed0a54a481";

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse('$URL'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

//api key :  20a16bf830bcf5f44df272ed0a54a481
// city id: 1566083