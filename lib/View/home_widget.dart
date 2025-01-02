import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:skystatus/Models/weather.dart';

final current_Hour = DateTime.now().hour;

class home_Widget extends StatelessWidget {
  home_Widget({super.key, required this.weatherData});

  final Weather weatherData;
  final bool is_Day = (current_Hour >= 6 && current_Hour <= 18);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              offset: const Offset(10, 10),
              blurRadius: 20,
            )
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weatherData.cityName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Lottie.asset(
                weatherAnimation(weatherData.mainCondition, is_Day),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${weatherData.temp.round().toString()} ℃",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 10.w),
                Text(
                  weatherData.mainCondition,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
