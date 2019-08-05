import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/*
* https://www.2dimensions.com/a/SamadiPour/files/flare/weather-flat-icons/preview
*/

class WeatherAnimation extends StatelessWidget {
    final String icon;

    WeatherAnimation({@required this.icon});

    @override
    Widget build(BuildContext context) {
        var _portraitHeightSize = MediaQuery
                .of(context)
                .size
                .height / 3 + 20;

        var _portraitWidthSize = MediaQuery
                .of(context)
                .size
                .width;

        var _landscapeHeightSize = MediaQuery
                .of(context)
                .size
                .height / 1.3;

        var _landscapeWidthSize = MediaQuery
                .of(context)
                .size
                .width / 3 + 20;


        return LimitedBox(
            maxWidth: MediaQuery
                    .of(context)
                    .orientation == Orientation.portrait
                    ? _portraitWidthSize
                    : _landscapeWidthSize,
            maxHeight: MediaQuery
                    .of(context)
                    .orientation == Orientation.portrait
                    ? _portraitHeightSize
                    : _landscapeHeightSize,
            child: FlareActor(
                'asset/animation/weather.flr',
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                animation: _iconToCode(icon),
            ),
        );
    }

    _iconToCode(String icon) {
        switch (icon) {
            case 'clear-day':
                return '01d';
                break;
            case 'clear-night':
                return '01n';
                break;
            case 'rain':
            case 'sleet':
                return '09d';
                break;
            case 'snow':
                return '13d';
                break;
            case 'wind':
                return 'wind';
                break;
            case 'fog':
                return '50d';
                break;
            case 'cloudy':
                return '03d';
                break;
            case 'partly-cloudy-day':
                return '02d';
                break;
            case 'partly-cloudy-night':
                return '02n';
                break;
            default:
                return '01d';
        }
    }
}