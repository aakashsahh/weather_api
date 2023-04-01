import 'package:flutter/cupertino.dart';

class WeatherModel {
  String? cityName;
  int? humidity;
  int? pressure;
  double? feelsLike;
  double? currentTemp;
  int? wind;
  String? condition;
  String? icon;
  WeatherModel(
    this.icon,
    this.cityName,
    this.currentTemp,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.wind,
    this.condition,
  );
  WeatherModel.fromJson(Map<String, dynamic> json) {
    currentTemp = json['main']['temp'];
    feelsLike = json['main']['feels_like'];
    humidity = json['main']['humidity'];
    pressure = json['main']['pressure'];
    wind = json['wind']['deg'];
    cityName = json['name'];
    condition = json['weather'][0]['main'];
    icon = json['weather'][0]['icon'];
  }
}
