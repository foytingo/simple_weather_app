
import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key, required this.weatherData});

  final WeatherModel weatherData;

  @override
  Widget build(BuildContext context) {
    
    var date = DateTime.fromMillisecondsSinceEpoch(weatherData.localTimeEpoch! * 1000);
    return  
     Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weatherData.city!, style: Theme.of(context).textTheme.displaySmall,),
                  Text(DateFormat('yMMMMEEEEd').format(date), style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey)),
              ]),
            ),
            const SizedBox(height: 12,),
            Image.asset("assets/${weatherData.conditionCode}.png", width: 150),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${weatherData.currentTemp}", style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 48, fontWeight: FontWeight.w300),),
                Text("°C", style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 30, fontWeight: FontWeight.w300),)

              ],
            ),
            const SizedBox(height: 12,),
            Text("${weatherData.condition}", style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 48,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text("${weatherData.wind}km/h", style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),),
                  Text("Wind", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey)),
                ],),
                Column(children: [
                  Text("${weatherData.humudity}%", style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),),
                  Text("Humidity", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey)),
                ],),
                 Column(children: [
                  Text("${weatherData.feelsLike}°", style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),),
                  Text("Feels like", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey)),
                ],),

            ]),
            const SizedBox(height: 48,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(weatherData.nextFiveDayForecase!.length-1, 
              (index) => OtherDays(
                dayEpoc: weatherData.nextFiveDayForecase![index+1].dateEpoch!, 
                conditionCode: weatherData.nextFiveDayForecase![index+1].conditionCode!, 
                value: weatherData.nextFiveDayForecase![index+1].temp!)
              )
            
            ),
          ],
        ),
      );
  }
}

class OtherDays extends StatelessWidget {
  const OtherDays({
    super.key,
    required this.dayEpoc,
    required this.conditionCode,
    required this.value
  });

  final int dayEpoc;
  final int conditionCode;
  final double value;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(dayEpoc * 1000);
    /// e.g Thursday
    return Column(
      children: [
        Text( DateFormat('EEE').format(date), style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 12,),
        Image.asset("assets/$conditionCode.png", width: 32),
        const SizedBox(height: 12,),
        Text("$value°", style: Theme.of(context).textTheme.labelLarge), 
      ],
    );
  }
}