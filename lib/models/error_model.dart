
enum ErrorType {
  location, network
}

class ErrorModel {
  final ErrorType errorType;
  final int? code;
  String? errorImage;

  ErrorModel({required this.errorType, this.code});

  String getErrorMessage() {
    switch (errorType) {
      case ErrorType.location:
        errorImage = "assets/location_error.png";
        return "Cannot get your location. Please check your location permissions. \n You can search with city name";
      case ErrorType.network:
        switch (code) {
          case 1002:
          case 2006:
          case 2007:
          case 2008:
          case 2009:
            errorImage = "assets/network_error.png";
            return "API key has a problem. Please contact developer.";
          case 1005:
            errorImage = "assets/network_error.png";
            return "Your request has a problem.Please contact developer";
          case 1006:
            errorImage = "assets/search_error.png";
            return "No location found. Please check typo.";
          case 7000:
            errorImage = "assets/network_error.png";
            return "Somting bad on your side. Please try again later";
          case 8000:
            errorImage = "assets/network_error.png";
            return "Somting bad on server side. Please try again later";
          default:
            errorImage = "assets/network_error.png";
            return "Somthing bad happen";

        }
    }

  }

}