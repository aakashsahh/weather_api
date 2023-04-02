import 'package:flutter/material.dart';
import 'package:weather_project/Services/weather_api_client.dart';
import 'package:weather_project/splash_screen.dart';
import 'package:weather_project/weather_model.dart';
import 'utils/text_style/text_style.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherApiClient weatherApiClient = WeatherApiClient();

  WeatherModel? weatherData;

  TextEditingController inputController = TextEditingController();

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? position;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<Object> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return {};
    }

    Position _localPosition = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      position = _localPosition;
    });

    var data = await weatherApiClient.getWeatherByLatLon(
        _localPosition.latitude, _localPosition.longitude);

    setState(() {
      if (data != null) {
        weatherData = data;
      }
    });

    return _localPosition;
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(_kLocationServicesDisabledMessage)),
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location Permission is denied")),
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Location Permission is denied, Please enable it from settings")),
      );

      return false;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(_kPermissionGrantedMessage)),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather Forecast"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const SplashScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.help)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: inputController,
                  decoration: InputDecoration(
                    label: const Text("Location"),
                    hintText: "Enter location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(width: 2, color: Colors.red),
                  ),
                  onPressed: () async {
                    var data = await weatherApiClient
                        .getCurrentWeather(inputController.text);
                    setState(() {
                      if (data != null) {
                        weatherData = data;
                      }
                    });
                  },
                  child: const Text('Update'),
                ),
                const SizedBox(height: 8),
                currentweather(),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 15),
            additonalInfo(),
          ],
        ),
      ),
    );
  }

  Column additonalInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Additional Information",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Humidity", style: textStyle),
            Text(
              getHumidity(),
              style: textStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Pressure",
                style: textStyle,
              ),
              Text(
                weatherData?.pressure.toString() ?? 'unaware',
                style: textStyle,
              ),
            ]),
        const SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Wind", style: textStyle),
              Text(
                weatherData?.wind.toString() ?? 'unaware',
                style: textStyle,
              ),
            ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Feels Like", style: textStyle),
            Text(
              weatherData?.feelsLike.toString() ?? 'unaware',
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }

  currentweather() {
    return Center(
      child: Column(children: [
        (weatherData != null && weatherData!.icon != null)
            ? Image.network(
                "https://openweathermap.org/img/wn/${weatherData!.icon}@2x.png",
                height: 100,
                width: 100,
              )
            : const Text("No image found"),
        Text(
          (weatherData != null && weatherData!.currentTemp != null)
              ? '${weatherData!.currentTemp} \u2103'
              : "No data",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weatherData?.cityName ?? "null",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weatherData?.condition ?? "null",
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        )
      ]),
    );
  }

  // updateUI(var decodedData) {
  //   if (decodedData == null) {
  //   } else {}
  // }

  String getHumidity() {
    if (weatherData != null && weatherData!.humidity != null) {
      return weatherData!.humidity.toString();
    } else {
      return 'unaware';
    }
  }
}
