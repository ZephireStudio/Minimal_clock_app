import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: const Color.fromARGB(255, 82, 81, 81),
    secondary: const Color.fromARGB(255, 82, 81, 81),
    // Add this to control text color
    onSurface: Colors.black,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color.fromARGB(255, 82, 81, 81);
      }
      return null;
    }),
    trackColor: WidgetStateProperty.resolveWith((states){
      if (states.contains(WidgetState.selected)){
        const Color.fromARGB(255,82,81,81).withOpacity(0.5);
      }return null;
      }),
  ),

  // Add this to ensure text colors are applied
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: const Color.fromARGB(255, 210, 210, 210),
    secondary: const Color.fromARGB(255, 210, 210, 210),
    // Add this to control text color
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states){
      if (states.contains(WidgetState.selected)){
        return const Color.fromARGB(255,210,210,210);
      }
      return null;
    })
  ),
  // Add this to ensure text colors are applied
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
  ),
);