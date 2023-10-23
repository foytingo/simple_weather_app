import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/models/error_model.dart';

class NetworkService {
  
  NetworkService({required this.url}); 

  final String url;

  Future<WeatherModel> getData() async {

    http.Response response = await http.get(Uri.parse(url));

   
    if (response.statusCode == 200) {

      final weatherData = jsonDecode(response.body) as Map<String,dynamic>;
      
      final weather = WeatherModel.fromJson(weatherData);

      return weather;
    } else {
        if(response.statusCode >= 400 && response.statusCode <500) {
          var errorData = jsonDecode(response.body) as Map<String,dynamic>;
          var errorCode = errorData["error"]["code"];
          var error = ErrorModel(errorType: ErrorType.network, code: errorCode);
          return Future.error(error);
        } else if (response.statusCode >= 500 && response.statusCode <600){
          var error = ErrorModel(errorType: ErrorType.network, code: 7000);
          return Future.error(error);
        } else {
          var error = ErrorModel(errorType: ErrorType.network, code: 8000);
          return Future.error(error);
        }
      
    }


  }

}