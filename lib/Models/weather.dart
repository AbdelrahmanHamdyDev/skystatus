String weatherAnimation(String condition, bool is_Day) {
  switch (condition.toLowerCase()) {
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return "assets/cloudy.json";
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      //6AM --> 5PM
      return (is_Day) ? "assets/DayRain.json" : "assets/nightRain.json";
    case 'thunderstorm':
      return "assets/thunder.json";
    case 'clear':
      //6AM --> 5PM
      return (is_Day) ? "assets/sunny.json" : "assets/night.json";
    default:
      return "assets/loading.json";
  }
}

class Weather {
  const Weather({
    required this.cityName,
    required this.temp,
    required this.mainCondition,
  });

  final String cityName;
  final double temp;
  final String mainCondition;

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      cityName: data['name'],
      temp: data['main']['temp'],
      mainCondition: data['weather'][0]['main'],
    );
  }
}
