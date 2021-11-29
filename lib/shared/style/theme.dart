import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/shared/style/colors.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.black),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark)),
    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20));

        ThemeData darkTheme = ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                      backgroundColor: HexColor('333739'),
                      elevation: 0,
                      titleSpacing: 20,
                      titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 20),
                      iconTheme: IconThemeData(color: Colors.white),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('333739'),
                          statusBarIconBrightness: Brightness.light)),
                  primarySwatch: Colors.blue,
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      backgroundColor: HexColor('333739'),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: defaultColor,
                      unselectedItemColor: Colors.grey,
                      elevation: 20));
