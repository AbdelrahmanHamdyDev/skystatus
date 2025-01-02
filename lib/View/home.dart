import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:skystatus/Controller/fetch.dart';
import 'package:redacted/redacted.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import 'package:skystatus/Models/weather.dart';
import 'package:skystatus/View/home_widget.dart';
import 'package:skystatus/main.dart';

final current_Hour = DateTime.now().hour;

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Future<Weather> _weatherFuture;

  void _refreshData() {
    setState(() {
      _weatherFuture = feathWeather();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    double _offsetToArmed = 80.h;
    return Scaffold(
      body: FutureBuilder(
        future: _weatherFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: home_Widget(
                weatherData: const Weather(
                    cityName: "Cairo", temp: 2000, mainCondition: "load"),
              ).redacted(context: context, redact: true),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text("Something Wrong....\nTry Again Later"),
            );
          }
          final weather_Data = snapshot.data!;
          return CustomRefreshIndicator(
            onRefresh: () async {
              _refreshData();
            },
            offsetToArmed: _offsetToArmed,
            builder: (ctx, child, controller) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    child: Lottie.asset(
                      "assets/refresh2.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      0.0,
                      _offsetToArmed * controller.value,
                    ),
                    child: child,
                  )
                ],
              );
            },
            child: Center(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: home_Widget(weatherData: weather_Data),
              ),
            ),
          );
        },
      ),
    );
  }
}
