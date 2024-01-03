import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: const MaterialColor(4280910265, {
      50: Color(0xffeaf4fa),
      100: Color(0xffd5e9f6),
      200: Color(0xffacd3ec),
      300: Color(0xff82bde3),
      400: Color(0xff58a7da),
      500: Color(0xff2e92d1),
      600: Color(0xff2574a7),
      700: Color(0xff1c577d),
      800: Color(0xff133a53),
      900: Color(0xff091d2a)
    }),
    primaryColor: Colors.blue,
    fontFamily: "Roboto",
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.only(left: 16),
      tileColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.black,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue.withOpacity(0.4)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.38),
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    scaffoldBackgroundColor: const Color(0xFFF4F5F7),
  );
}
