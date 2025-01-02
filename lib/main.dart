import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:skystatus/Theme.dart';
import 'package:skystatus/View/home.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: LightTheme,
          darkTheme: DarkTheme,
          home: const homeScreen(),
        );
      },
    ),
  );
}
