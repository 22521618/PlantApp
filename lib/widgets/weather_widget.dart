import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_app/models/weather_model.dart';
import 'package:plant_app/services/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late WeatherService _weatherService = WeatherService();
  late String temp;
  late String condition;
  Weather? _weather;
  fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather();
      setState(() {
        _weather = weather;
      });
      print(temp);
    } catch (e) {
      print(e.toString());
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/weather/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/weather/cloud.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather/rainy.json';

      case 'thunderstorm':
        return 'assets/weather/thunder.json';

      case 'clear':
      default:
        return 'assets/weather/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchWeather();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _weather == null
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _weather!.temperature.toString(),
                      style: const TextStyle(
                          height: 0,
                          fontSize: 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: const [
                          Text(
                            "o",
                            style: TextStyle(
                                height: 0,
                                letterSpacing: 2,
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "C",
                            style: TextStyle(
                                height: 0,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        _weather == null
            ? Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  CircularProgressIndicator(),
                ],
              )
            : Lottie.asset(
                getWeatherAnimation(
                  _weather!.mainCondition,
                ),
              ),
      ],
    );
  }
}
