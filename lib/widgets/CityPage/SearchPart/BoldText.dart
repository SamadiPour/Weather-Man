import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';

class BoldText extends StatelessWidget {
    final String mainText;
    final String boldText;

    BoldText({@required this.mainText, @required this.boldText});

    @override
    Widget build(BuildContext context) {
        return RichText(
            text: TextSpan(
                style: Theme
                        .of(context)
                        .textTheme
                        .body1.merge(kCityText),
                children: _getTextList(),
            ),
            softWrap: true,
        );
    }

    List<TextSpan> _getTextList() {
        var pos = mainText.toLowerCase().indexOf(boldText.toLowerCase());

        if (pos == -1)
            return [TextSpan(text: mainText)];

        if (mainText == boldText)
            return [TextSpan(text: mainText, style: kCityTextBold)];
        else if (pos == 0 || mainText.length - pos - boldText.length == 0) {
            if (pos == 0)
                return [
                    TextSpan(
                        text: mainText.substring(0, boldText.length),
                        style: kCityTextBold,
                    ),
                    TextSpan(
                        text: mainText.substring(pos + boldText.length),
                    ),
                ];
            else {
                return [
                    TextSpan(
                        text: mainText.substring(0, pos),
                    ),
                    TextSpan(
                        text: mainText.substring(pos),
                        style: kCityTextBold,
                    ),
                ];
            }
        } else {
            return [
                TextSpan(
                    text: mainText.substring(0, pos),
                ),
                TextSpan(
                    text: mainText.substring(pos, pos + boldText.length),
                    style: kCityTextBold,
                ),
                TextSpan(
                    text: mainText.substring(pos + boldText.length),
                )
            ];
        }
    }
}
