import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';

class ThemeManager {

    static ThemeData getTheme(_currentTheme) {
        if (_currentTheme == Brightness.light) {
            return ThemeData.light().copyWith(
                textTheme: ThemeData
                        .light()
                        .textTheme
                        .merge(kTextTheme),
                brightness: Brightness.light,
                primaryColor: Color(0xff1EA3EB),
            );
        } else {
            return ThemeData.dark().copyWith(
                textTheme: ThemeData
                        .dark()
                        .textTheme
                        .merge(kTextTheme),
                brightness: Brightness.dark,
                primaryColor: Color(0xff16006B),
            );
        }
    }

    static LinearGradient getGradient(_currentTheme) {
        var colors = _currentTheme == Brightness.light ? [kLightStart, kLightEnd]
                : [kDarkStart, kDarkEnd];

        return LinearGradient(
            colors: colors,
            tileMode: TileMode.clamp,
            begin: Alignment(0, 0.5),
            end: Alignment(0, -0.5),
        );
    }

    static List<Color> getChartGradient(BuildContext context) {
        return Theme
                .of(context)
                .brightness == Brightness.light ? [
//            Color(0xff23b6e6),
            Colors.blue[200],
            Color(0xff02d39a),
        ] : [
            Color(0xff5023D9),
            Color(0xffD923BD),
        ];
    }

    static Color getBoxColor(BuildContext context) {
        return Theme
                .of(context)
                .brightness == Brightness.light ? kGreyLightColor : kGreyDarkColor;
    }
}