import 'package:skystatus/Controller/service.dart';
import 'package:skystatus/Models/weather.dart';

final _weatherService = weatherService();

Future<Weather> feathWeather() async {
  print(
      "=================================== Enter to feath data =================================== ");
  Weather curr_Weather;
  List<double> position = await _weatherService.getCity();
  print(
      "====================================================== Current Positions: $position ======================================================");
  curr_Weather = await _weatherService.getWeather(position);

  return curr_Weather;
}
