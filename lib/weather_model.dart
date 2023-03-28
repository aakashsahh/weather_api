class WeatherModel {
  String? cityName;
  double? humidity;
  double? pressure;
  double? feelsLike;
  double? currentTemp;
  double? wind;
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
    wind = json['wind'];
    cityName = json['name'];
  }
}
