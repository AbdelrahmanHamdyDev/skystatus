import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skystatus/Models/weather.dart';

class weatherService {
  static const base_Url = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = dotenv.env['apiKey']!;

  Future<Weather> getWeather(List<double> positionData) async {
    final res = await http.get(Uri.parse(
        '$base_Url?lat=${positionData[0]}&lon=${positionData[1]}&appid=$apiKey&units=metric'));

    if (res.statusCode == 200) {
      print(
          "================================================================  get the data successfully ================================================================ ");
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Failed to Featch Data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
      );
      print(
          "================================================================ can't get the data ================================================================ ");
      throw Exception('Failed to Featch Data');
    }
  }

  Future<List<double>> getCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition();
      print(
          "================================================================  get the location successfully================================================================ ");
      return [position.latitude, position.longitude];
    } catch (e) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg:
            "================================================================  Can't Access the Current Location ================================================================ ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
      );
      print("can't get the location");
      return [44.3, 10.9];
    }
  }
}
