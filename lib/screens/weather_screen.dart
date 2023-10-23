import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/error_model.dart';
import 'package:simple_weather_app/screens/search_screen.dart';

import 'package:simple_weather_app/services/weather_services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/views/weather_view.dart';
import 'package:simple_weather_app/views/error_view.dart';




class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();

}
class _WeatherScreenState extends State<WeatherScreen> {
  final SearchController controller = SearchController();
  String searchText = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.amber,size: 30),
        leading: IconButton(
          onPressed: (){setState(() {
            searchText = "";
          });}, 
          icon: const Icon(Icons.near_me_outlined)
        ),
        actions: [
          IconButton(
            onPressed: () async {
             var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
             if(cityName != null) {
              setState(() {
                searchText = cityName;
              });
             }
            }, 
            icon: const Icon(Icons.search)
          ),
      ]),
      body: FutureBuilder(
        future: searchText == "" ? WeatherService().getCurrentLocationWeather() : WeatherService().getCityWeather(searchText),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                var error = snapshot.error as ErrorModel;
                return ErrorView(errorModel: error);
              } else {
                var weatherData = snapshot.data as WeatherModel;
                return WeatherView(weatherData: weatherData);
              }

           } else {
              return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.amber, size: 150));
           }

        },
      ),
    );
  }
}