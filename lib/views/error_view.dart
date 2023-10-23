
import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/error_model.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorModel});

  final ErrorModel errorModel;

  @override
  Widget build(BuildContext context) {
    var errorMessage = errorModel.getErrorMessage(); // Here because error image assign in getErrorMessage
    return Center(
      child: Column(
        children: [
            const SizedBox(height: 100,),
            Image.asset(errorModel.errorImage ?? "assets/location_error.png", width: 175),
            const SizedBox(height: 36,),
            const Text("Error", style: const TextStyle(fontSize: 24, color: Colors.amber),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(errorMessage, style: const TextStyle(fontSize: 24, color: Colors.grey),textAlign: TextAlign.center,),
            ),
        ],
      ),
    );
  }
}