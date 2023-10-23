import 'package:flutter/material.dart';
import 'package:simple_weather_app/screens/weather_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true,),
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
    );
  }
}
