import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_man/module/SettingData.dart';
import 'package:weather_man/pages/CityPage.dart';
import 'module/City.dart';
import 'module/ThemeManager.dart';
import 'pages/intro/IntorSlider.dart';
import 'pages/WeatherPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
    bool seen = await _getRightInitialPage();
    seen ? await SettingData.initialAll() : await SettingData.setAllInSP();
    runApp(MyApp(seen));
}

class MyApp extends StatelessWidget {
    final bool _seen;

    MyApp(this._seen);

    @override
    Widget build(BuildContext context) {
        return DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (brightness) => ThemeManager.getTheme(brightness),
            themedWidgetBuilder: (context, theme) {
                return MaterialApp(
                    theme: theme,
                    debugShowCheckedModeBanner: false,
                    title: 'Weather Man',
                    initialRoute: _seen ? '/' : '/intro',
                    onGenerateRoute: (RouteSettings settings) {
                        switch (settings.name) {
                            case '/WeatherPage':
                                return MaterialPageRoute(builder: (_) =>
                                        WeatherPage(
                                            city: settings.arguments as City,
                                        ),
                                );
                                break;
                            case '/':
                                return MaterialPageRoute(builder: (_) => CityPage());
                                break;
                            case '/intro':
                                return MaterialPageRoute(builder: (_) => IntroSlider());
                                break;
                            default:
                                return MaterialPageRoute(
                                        builder: (_) =>
                                                Scaffold(body: Center(child: Text('OOPS'),),)
                                );
                        }
                    },
                );
            },
        );
    }
}

Future<bool> _getRightInitialPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool('INTRO_SEEN');
    if (result == null)
        return false;
    return (result);
}