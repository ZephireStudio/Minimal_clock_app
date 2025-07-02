import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minimal_clock/pages/Pomodoro.dart';
import 'package:minimal_clock/pages/other_themes/theme1.dart';
import 'package:minimal_clock/pages/other_themes/theme4.dart';
import 'package:minimal_clock/pages/other_themes/theme2.dart';
import 'package:minimal_clock/pages/other_themes/theme3.dart';
import 'package:minimal_clock/pages/othertheme.dart';
import 'package:minimal_clock/pages/timer.dart';
import 'package:minimal_clock/services/settings_provider.dart';
import 'package:minimal_clock/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_clock/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Colors specifically for Mobiles
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );

  runApp(
    ScreenUtilInit(
      designSize: const Size(2560, 1440),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.themeData.brightness == Brightness.dark;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData, // Use the theme from provider
            // Defining Routes
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/other-themes': (context) => OtherThemesPage(),
              '/Theme1': (context) => const Theme1(),
              '/Theme2': (context) => const Theme2(),
              '/Theme3': (context) => const Theme3(),
              '/Theme4': (context) => const Theme4(),
              '/Timer': (context) => const CustomTimer(),
              '/Pomo': (context) => Pomodoro(),
            },
          ),
        );
      },
    );
  }
}
