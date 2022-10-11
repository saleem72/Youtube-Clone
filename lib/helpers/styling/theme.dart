//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styling.dart';

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

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    primaryColor: Pallet.primaryColor,
    scaffoldBackgroundColor: Pallet.bodyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark,
      ),
    ),
    textTheme: ThemeData.light()
        .textTheme
        // .copyWith(
        //   displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(
        //         color: Pallet.primaryTextColor,
        //       ),
        //   headline6: const TextStyle(
        //     fontFamily: 'OpenSans',
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // )
        .apply(
          bodyColor: Pallet.primaryTextColor,
          displayColor: Pallet.primaryTextColor,
        ),
  );
}

ThemeData darkTheme() {
  return ThemeData.light().copyWith(
    primaryColor: Pallet.primaryColor,
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
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Pallet.primaryTextColor,
          displayColor: Pallet.primaryTextColor,
        ),
  );
}
