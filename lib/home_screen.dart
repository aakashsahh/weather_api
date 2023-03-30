import 'package:flutter/material.dart';
import 'package:weather_project/Services/weather_api_client.dart';
import 'package:weather_project/splash_screen.dart';
import 'package:weather_project/weather_model.dart';

import 'utils/text_style/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherApiClient weatherApiClient = WeatherApiClient();

  WeatherModel? weatherData;

  TextEditingController inputController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  // }

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
        child: ListView(children: [
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
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Divider(color: Colors.grey)
            ],
          ),
          const SizedBox(height: 15),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ]),
        ]),
      ),
    );
  }

  currentweather() {
    return Center(
      child: Column(children: [
        const Icon(
          Icons.wb_sunny_rounded,
          color: Colors.orange,
          size: 50,
        ),
        const SizedBox(height: 10),
        Text(
          weatherData?.currentTemp.toString() ?? 'Hi! I am not available',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weatherData?.cityName ?? "Sorry, I don't know now where am I",
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  updateUI(var decodedData) {
    if (decodedData == null) {
    } else {}
  }

  String getHumidity() {
    if (weatherData != null && weatherData!.humidity != null) {
      return weatherData!.humidity.toString();
    } else {
      return 'unaware';
    }
  }
}
