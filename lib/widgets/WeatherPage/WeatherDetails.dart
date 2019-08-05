import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';
import 'package:weather_man/module/WeatherApiHandler.dart';

class WeatherDetails extends StatelessWidget {
    final WeatherApiHandler _weatherApiHandler;

    WeatherDetails(this._weatherApiHandler);

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                InfoContainer('${_weatherApiHandler
                        .getCurrentWeather()
                        .windSpeed
                        .round()}km/h', 'Wind'),
                InfoContainer('${_weatherApiHandler
                        .getCurrentWeather()
                        .humidity
                        .round()}%', 'Humidity'),
                InfoContainer('${_weatherApiHandler
                        .getCurrentWeather()
                        .pressure
                        .round()}hPa', 'Pressure'),
            ],
        );
    }
}

class InfoContainer extends StatelessWidget {
    final String value;
    final String info;

    InfoContainer(this.value, this.info);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
                children: <Widget>[
                    Text(
                        value,
                        style: kDetailsText,
                    ),
                    SizedBox(height: 7,),
                    Text(
                        info,
                        style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                    ),
                ],
            ),
        );
    }
}
