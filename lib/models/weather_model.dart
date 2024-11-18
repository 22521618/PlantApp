// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class Weather {
  final double temperature;
  final String mainCondition;

  Weather({
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'] as double,
      mainCondition: json['weather'][0]['main'],
    );
  }
}
