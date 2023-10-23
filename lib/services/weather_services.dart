import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/services/location_services.dart';
import 'package:simple_weather_app/services/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiKey = ""; // API KEY HERE
const baseUrl = "http://api.weatherapi.com/v1/forecast.json";

class WeatherService {

  Future<dynamic> getCityWeather(String cityName) async {
    String url = "$baseUrl?key=$apiKey&q=$cityName&days=6&aqi=no&alerts=no";
    NetworkService networkService = NetworkService(url: url);
    try {
      final data = await networkService.getData();
      final prefs = await SharedPreferences.getInstance();
      final List<String> items = prefs.getStringList('items') ?? [];
      if (items.length > 8) {
          items.removeLast();
      };
      if (!items.contains(cityName)) {
        items.insert(0,cityName);
      }

      await prefs.setStringList('items', items);
     
      return data;
      
    } catch(error) {
      return Future.error(error);
    }
  }

  Future<dynamic> getCurrentLocationWeather() async {
    try {
      Position position = await LocationService().getLocation();
      String url = "$baseUrl?key=$apiKey&q=${position.latitude},${position.longitude}&days=6&aqi=no&alerts=no";
      NetworkService networkService = NetworkService(url: url);
      try {
        return await networkService.getData();
      } catch (error) {
        return Future.error(error);
      }
    } catch(error) {
      return Future.error(error);
    }
  
  }


}