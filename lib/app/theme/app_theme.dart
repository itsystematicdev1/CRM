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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 0,
          backgroundColor: lightColorScheme.primary,
          foregroundColor: lightColorScheme.onPrimary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.onPrimary,
        surfaceTintColor: lightColorScheme.onPrimary,
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
        backgroundColor: lightColorScheme.background,
        selectedLabelStyle: lightTextTheme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600, color: lightColorScheme.primary),
        selectedItemColor: lightColorScheme.primary,
        unselectedItemColor: lightColorScheme.primary.withOpacity(0.5),
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
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        hoverColor: lightColorScheme.onPrimaryContainer,
      ),
      cardTheme: CardTheme(
          color: lightColorScheme.background,
          elevation: 2,
          surfaceTintColor: lightColorScheme.background));

  static final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: darkTextTheme.textTheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          textStyle: lightTextTheme.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 0,
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.background,
        surfaceTintColor: darkColorScheme.background,
        iconTheme: IconThemeData(color: darkColorScheme.onSecondaryContainer),
      ),
      tabBarTheme: TabBarTheme(
        indicatorColor: darkColorScheme.onSecondaryContainer,
        labelColor: darkColorScheme.onSecondaryContainer,
        unselectedLabelColor:
            darkColorScheme.onSecondaryContainer.withOpacity(0.5),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 5,
        enableFeedback: true,
        backgroundColor: darkColorScheme.background,
        selectedLabelStyle: lightTextTheme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600, color: darkColorScheme.primary),
        selectedItemColor: darkColorScheme.primary,
        unselectedItemColor: darkColorScheme.primary.withOpacity(0.5),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          elevation: 2,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)))),
      inputDecorationTheme:
          InputDecorationTheme(fillColor: darkColorScheme.onSecondary),
      listTileTheme: ListTileThemeData(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        iconColor: darkColorScheme.onSecondaryContainer,
        tileColor: darkColorScheme.secondaryContainer,
        textColor: darkColorScheme.onSecondaryContainer,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        hoverColor: darkColorScheme.onPrimaryContainer,
      ),
      cardTheme: CardTheme(
          color: darkColorScheme.surface,
          elevation: 2,
          surfaceTintColor: darkColorScheme.surface));
}
