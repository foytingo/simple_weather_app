

class WeatherModel {
  final String? city;
  final int? localTimeEpoch;
  final double? currentTemp;
  final int? conditionCode;
  final String? condition;
  final double? wind;
  final int? humudity;
  final double? feelsLike;
  final List<DayWeatherModel>? nextFiveDayForecase;

  WeatherModel({this.city, this.localTimeEpoch, this.currentTemp, this.conditionCode, this.condition, this.wind, this.humudity, this.feelsLike, this.nextFiveDayForecase});

  
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final nextFiveDays = json["forecast"]["forecastday"] as List<dynamic>;
  
    return WeatherModel(
      city: json["location"]["name"] as String, 
      localTimeEpoch: json["location"]["localtime_epoch"] as int,
      currentTemp: json["current"]["temp_c"] as double,
      conditionCode: json["current"]["condition"]["code"] as int,
      condition: json["current"]["condition"]["text"] as String,
      wind: json["current"]["wind_kph"] as double,
      humudity: json["current"]["humidity"] as int,
      feelsLike: json["current"]["feelslike_c"] as double,
      nextFiveDayForecase: nextFiveDays.map((data) => DayWeatherModel.fromJson(data as Map<String,dynamic>)).toList(),
      );
  }

}

class DayWeatherModel {
  final int? dateEpoch;
  final int? conditionCode;
  final double? temp;

  DayWeatherModel({this.dateEpoch, this.conditionCode, this.temp});

  factory DayWeatherModel.fromJson(Map<String, dynamic> json) {
    return DayWeatherModel(
      dateEpoch: json["date_epoch"] as int, 
      conditionCode: json["day"]["condition"]["code"] as int,
      temp: json["day"]["avgtemp_c"] as double
      );
  }

}