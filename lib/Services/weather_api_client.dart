import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_project/weather_model.dart';

class WeatherApiClient {
  Future<WeatherModel>? getCurrentWeather(String? location) async {
    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=375f4d70bfb5a581278a072b75a010ab&units=metric";

    Uri endpoint = Uri.parse(baseUrl);

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    var data = WeatherModel.fromJson(body);

    return data;
  }

  Future<WeatherModel>? getWeatherByLatLon(double? lat, double? lon) async {
    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=375f4d70bfb5a581278a072b75a010ab&units=metric";
    Uri endpoint = Uri.parse(baseUrl);

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    var data = WeatherModel.fromJson(body);

    return data;
  }
}
