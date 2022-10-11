//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pallet {
  Pallet._();

  static const Color primaryTextColor = Color(0xffE6E7EF);
  static const Color primaryColor = Color(0xffDF0F50);
  static const Color secondaryTextColor = Color(0xff9DA1B1);
  static const Color bodyColor = Color(0xff16171A);
  static const Color headerColor = Color(0xff212226);
  static const Color headerIconColor = Color(0xffD3D6E0);
  static const Color iconColor = Color(0xff6F7285);

  static const AppBarTheme appBarTheme = AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ));
/*
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Pallet.bodyColor,
    textTheme: Typography.whiteCupertino,
  );
  */

  static final ThemeData aaaa = ThemeData(
    fontFamily: '',
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Pallet.primaryColor,
    // fontFamily: '',
    scaffoldBackgroundColor: Pallet.bodyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith().apply(
          bodyColor: Pallet.primaryTextColor,
          displayColor: Pallet.primaryTextColor,
        ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
