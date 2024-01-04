import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'text_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme.textTheme,
    scaffoldBackgroundColor: lightColorScheme.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        textStyle: lightTextTheme.textTheme.labelLarge!
            .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
        shape: const StadiumBorder(),
        elevation: 0,
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.secondaryContainer,
      iconTheme: IconThemeData(color: lightColorScheme.onSecondaryContainer),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: lightColorScheme.onSecondaryContainer,
      labelColor: lightColorScheme.onSecondaryContainer,
      unselectedLabelColor:
          lightColorScheme.onSecondaryContainer.withOpacity(0.5),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5,
      enableFeedback: true,
      backgroundColor: lightColorScheme.primary,
      selectedLabelStyle: lightTextTheme.textTheme.bodyLarge!
          .copyWith(fontWeight: FontWeight.w600),
      selectedItemColor: lightColorScheme.onPrimary,
      unselectedItemColor: lightColorScheme.onPrimary.withOpacity(0.5),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        elevation: 2,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)))),
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: Color(0xffDDE3EA)),
    listTileTheme: ListTileThemeData(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      iconColor: lightColorScheme.onSecondaryContainer,
      tileColor: lightColorScheme.secondaryContainer,
      textColor: lightColorScheme.onSecondaryContainer,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.secondaryContainer,
      foregroundColor: lightColorScheme.onSecondaryContainer,
      hoverColor: lightColorScheme.onPrimaryContainer,
    ),
  );

  //*
  //
  //! dark Theme
  //
  //*
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: darkColorScheme.surface,
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme.textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 0,
            backgroundColor: darkColorScheme.primary,
            foregroundColor: darkColorScheme.onPrimary)),
    appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.secondaryContainer,
        iconTheme: IconThemeData(color: darkColorScheme.onSecondaryContainer)),
    tabBarTheme: TabBarTheme(
        indicatorColor: darkColorScheme.onSecondaryContainer,
        labelColor: darkColorScheme.onSecondaryContainer,
        unselectedLabelColor:
            darkColorScheme.onSecondaryContainer.withOpacity(0.5)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      enableFeedback: true,
      selectedItemColor: darkColorScheme.onSecondaryContainer,
      unselectedItemColor:
          darkColorScheme.onSecondaryContainer.withOpacity(0.5),
    ),
    listTileTheme: ListTileThemeData(
        shape: const StadiumBorder(),
        iconColor: darkColorScheme.onPrimaryContainer,
        tileColor: darkColorScheme.primaryContainer,
        textColor: darkColorScheme.onPrimaryContainer),
  );
}
