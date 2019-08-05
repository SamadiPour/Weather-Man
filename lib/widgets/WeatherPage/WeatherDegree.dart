import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';
import 'package:weather_man/module/WeatherApiHandler.dart';

class WeatherDegree extends StatelessWidget {
    final WeatherApiHandler _weatherApiHandler;

    WeatherDegree(this._weatherApiHandler);

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(
                    '${_weatherApiHandler
                            .getCurrentWeather()
                            .temperature
                            .round()}℃',
                    style: kMainTemp,
                ),
                Text(
                    '${_weatherApiHandler
                            .getTodayWeather()
                            .temperatureMax
                            .round()}℃/'
                            +
                            '${_weatherApiHandler
                                    .getTodayWeather()
                                    .temperatureMin
                                    .round()}℃',
                    style: kTitleTextStyle.copyWith(
                        color: Colors.white.withAlpha(180),
                    ),
                ),
            ],
        );
    }
}
