import 'package:geolocator/geolocator.dart';
import 'package:simple_weather_app/models/error_model.dart';

class LocationService {

  Future<dynamic> getLocation() async {

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

     if (!serviceEnabled) {
      var error = ErrorModel(errorType: ErrorType.location);
      return Future.error(error);
    }

    permission = await Geolocator.checkPermission();

     if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          var error = ErrorModel(errorType: ErrorType.location);
          return Future.error(error);
        }
    }

    if (permission == LocationPermission.deniedForever) {
      var error = ErrorModel(errorType: ErrorType.location);
      return Future.error(error);
    } 

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return position;


  }
}