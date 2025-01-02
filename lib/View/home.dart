import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skystatus/Controller/fetch.dart';
import 'package:redacted/redacted.dart';

import 'package:skystatus/Models/weather.dart';
import 'package:skystatus/View/home_widget.dart';

final current_Hour = DateTime.now().hour;

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: feathWeather(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return home_Widget(
              weatherData: const Weather(
                  cityName: "Cairo", temp: 2000, mainCondition: "load"),
            ).redacted(context: context, redact: true);
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text("Something Wrong....\nTry Again Later"),
            );
          }
          final weather_Data = snapshot.data!;
          return home_Widget(weatherData: weather_Data);
        },
      ),
    );
  }
}
