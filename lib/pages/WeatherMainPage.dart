import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/Services/weather_services.dart';
import 'package:minimal_weather_app/models/weather.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({super.key});

  @override
  State<WeatherMainPage> createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> {
  //add you openweathermap api key below
  final _weatherService = WeatherService('api key goes here');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getWeatherAnimation(String? condition, String? icon) {
    if (condition == null) {
      return 'assets/foggy_sunny_default.json';
    } else if (condition == 'Clear') {
      if (icon == '01d') {
        return 'assets/clear_sunny.json';
      }
      if (icon == '01n') {
        return 'assets/clear_night.json';
      }
    }
    else if (condition == 'Clouds') {
      if (icon == '02d' || icon == '03d') {
        return 'assets/partial_clouds.json';
      }
      else if (icon == '02n' || icon == '03n') {
        return 'assets/partial_clouds_night.json';
      }
      else {
        return 'assets/cloudy.json';
      }
    }
    switch (condition.toLowerCase()) {
      case 'mist':
        return 'assets/foggy.json';
      case 'haze':
        return 'assets/foggy.json';
      case 'fog':
        return 'assets/foggy.json';
      case 'rain':
        return 'assets/drizzle.json';
      case 'drizzle':
        return 'assets/drizzle.json';
      case 'shower rain':
        return 'assets/drizzle.json';
      case 'thunderstorm':
        return 'assets/thunder_storm.json';
      default:
        return 'assets/foggy_sunny_default.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor;

    if (brightness == Brightness.dark) {
      backgroundColor = const Color.fromARGB(255, 48, 48, 48);
    } else {
      backgroundColor = const Color.fromARGB(255, 255, 255, 255);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Icon(Icons.location_pin, color: Color.fromARGB(255, 122, 122, 122), size: 35),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                _weather?.cityName ?? "Loading City...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 122, 122, 122),
                    fontFamily: 'BebasNeue'),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Lottie.asset(
                getWeatherAnimation(_weather?.condition, _weather?.icon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0), // Bottom padding
            child: Column(
              children: [
                Text(
                  '${_weather?.temperature.round()}°C',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 122, 122, 122),
                      fontFamily: 'BebasNeue'),
                ),
                Text(
                  _weather?.condition ?? "",
                  style: const TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 122, 122, 122),
                      fontFamily: 'BebasNeue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
