import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:weather_man/module/SettingData.dart';
import 'package:weather_man/widgets/SettingPage/NiceSwitch.dart';

class SettingPage extends StatefulWidget {

    @override
    _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
    bool _darkThemeValue = SettingData.isDark;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                            SizedBox(height: 35,),
                            _settingText(context, 'Setting'),
                            SizedBox(height: 30,),
                            _weatherOptions(),
                            SizedBox(height: 60,),
                            _settingText(context, 'Theme'),
                            SizedBox(height: 30,),
                            _darkMode()
                        ],
                    )
            ),
        );
    }

    _darkMode() {
        return NiceSwitch(
            text: 'Dark Theme',
            value: _darkThemeValue,
            onChange: (value) {
                setState(() {
                    _darkThemeValue = value;
                    DynamicTheme.of(context).setBrightness(
                        Theme
                                .of(context)
                                .brightness == Brightness.dark ? Brightness.light : Brightness.dark,
                    );
                });
            },
            activeColor: Colors.black87,
        );
    }

    _weatherOptions() {
        return Column(
            children: <Widget>[
                NiceSwitch(
                    text: 'Weather Details',
                    value: SettingData.get(Settings.ShowWeatherDetails),
                    onChange: (_) {
                        setState(() {
                            SettingData.changeValue(Settings.ShowWeatherDetails);
                        });
                    },
                ),
                NiceSwitch(
                    text: 'Next 24 Hours',
                    value: SettingData.get(Settings.Show24Hours),
                    onChange: (_) {
                        setState(() {
                            SettingData.changeValue(Settings.Show24Hours);
                        });
                    },
                ),
                NiceSwitch(
                    text: 'Next 7 Days',
                    value: SettingData.get(Settings.Show7Days),
                    onChange: (_) {
                        setState(() {
                            SettingData.changeValue(Settings.Show7Days);
                        });
                    },
                ),
                NiceSwitch(
                    text: 'Chance of Precipitation',
                    value: SettingData.get(Settings.ShowRainChart),
                    onChange: (_) {
                        setState(() {
                            SettingData.changeValue(Settings.ShowRainChart);
                        });
                    },
                ),
                NiceSwitch(
                    text: 'Map',
                    value: SettingData.get(Settings.ShowMap),
                    onChange: (_) {
                        setState(() {
                            SettingData.changeValue(Settings.ShowMap);
                        });
                    },
                ),
            ],

        );
    }

    _settingText(BuildContext context, String text) {
        return Text(
            text,
            style: Theme
                    .of(context)
                    .textTheme
                    .body1
                    .merge(TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
            )),
        );
    }
}
