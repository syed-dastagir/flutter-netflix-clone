import 'package:flutter/material.dart';
import 'package:watchit/values/text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      primaryIconTheme: const IconThemeData(color: Colors.black),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red.shade900,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
      ),
      textTheme: AppTextStyles.lightTextTheme, // for text color
      iconTheme: const IconThemeData(color: Colors.black),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black)))) // for icons.
      // for icons.
      );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white)),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      scaffoldBackgroundColor: Colors.black,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ),
      textTheme: AppTextStyles.darkTextTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: Colors.black,
                  backgroundColor: Colors.white)))) // for icons.
      );
}
