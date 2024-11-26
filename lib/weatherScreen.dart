import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String content = "";

  Future<Position> getGeoLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void printWeatherData() async {
    Position position = await getGeoLocation();
    var API_KEY = "85e6c9e663d9e061f1848e4a41cd66a7";
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude.toString()}&lon=${position.longitude.toString()}&appid=${API_KEY}");

    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data["main"]["sea_level"]);
    print(data["coord"]["lat"]);
    print(data["weather"][0]["description"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(content),
            FilledButton(
              onPressed: () {
                printWeatherData();
              },
              child: const Text("Click One"),
            )
          ],
        ),
      ),
    );
  }
}
