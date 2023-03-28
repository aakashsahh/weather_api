import 'package:flutter/material.dart';
import 'package:weather_project/splash_screen.dart';

import 'utils/text_style/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  debugPrint("help button was clicked");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const splash()));
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
                  decoration: InputDecoration(
                      label: const Text("Your location"),
                      hintText: "Enter your location",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(width: 2, color: Colors.red),
                ),
                onPressed: () {},
                child: const Text('Update'),
              ),
              const SizedBox(height: 8),
              currentweather(Icons.wb_sunny_rounded, "36.4", "Kathmandu"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Humidity", style: textStyle),
                  SizedBox(height: 10),
                  Text(
                    "Pressure",
                    style: textStyle,
                  ),
                  SizedBox(height: 10),
                  Text("Wind", style: textStyle),
                  SizedBox(height: 10),
                  Text("Feels Like", style: textStyle)
                ],
              ),
              Column(
                children: const [
                  Text("900", style: textStyle),
                  SizedBox(height: 10),
                  Text("980", style: textStyle),
                  SizedBox(height: 10),
                  Text("90", style: textStyle),
                  SizedBox(height: 10),
                  Text("200", style: textStyle),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  currentweather(IconData icon, String temp, String location) {
    return Center(
      child: Column(children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 50,
        ),
        const SizedBox(height: 10),
        Text(
          temp,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  additionalInformation() {}
}
