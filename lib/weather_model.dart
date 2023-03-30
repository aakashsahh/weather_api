class WeatherModel {
  String? cityName;
  int? humidity;
  int? pressure;
  double? feelsLike;
  double? currentTemp;
  int? wind;
  WeatherModel(
    this.cityName,
    this.currentTemp,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.wind,
  );
  WeatherModel.fromJson(Map<String, dynamic> json) {
    currentTemp = json['main']['temp'];
    feelsLike = json['main']['feels_like'];
    humidity = json['main']['humidity'];
    pressure = json['main']['pressure'];
    wind = json['wind']['deg'];
    cityName = json['name'];
  }
}
