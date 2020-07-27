import 'package:dev_to/core/news_provider.dart';
import 'package:dev_to/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NewsProvider())
        ],
        child: LoadingProvider(child: MyApp()),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      builder: (ThemeMode themeMode) {
        return MaterialApp(
          title: 'Dev2 News',
          themeMode: themeMode,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
      defaultTheme: ThemeMode.light, 
      manager: MyManager(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      backgroundColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          bodyText1: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Nexa',
                ),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 18,
          color: Color(0xffea5e3d),
          fontWeight: FontWeight.w700,
          fontFamily: 'Nexa',
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: Color(0xffea5e3d),
          fontWeight: FontWeight.w400,
          fontFamily: 'Nexa',
        ),
      ),
      brightness: Brightness.light,
    );
  }

  ThemeData darkTheme() {
    const background = Color(0xFF222831);
    //const color1 = Color(0xFF30475e);
    //const color2 = Color(0xFFf2a365);
    const color3 = Color(0xFFececec);
    //darkTheme
    return ThemeData(
      backgroundColor: background,
      primaryIconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Nexa',
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 18,
          color: color3,
          fontWeight: FontWeight.w700,
          fontFamily: 'Nexa',
        ),
        headline3: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: 'Nexa',
        ),
      ),
      brightness: Brightness.dark,
    );
  }
}

class MyManager implements IThemeModeManager {
  static const _key = 'example_theme_mode';

  @override
  Future<String> loadThemeMode() async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getString(_key);
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.setString(_key, value);
  }
}