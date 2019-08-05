import 'dart:math';

import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/TimeUtil.dart';
import 'package:weather_man/module/WeatherIcon.dart' as WeatherIcon;
import 'package:weather_man/Utilities/DateUtil.dart' as DateUtil;

class FutureDays extends StatefulWidget {
    final List<DailyDataPoint> data;
    final int count;

    FutureDays(this.data, {this.count});

    @override
    _FutureDaysState createState() => _FutureDaysState();
}

class _FutureDaysState extends State<FutureDays> {
    DateTime currentDate;
    TimeUtil _timeUtil;

    @override
    Widget build(BuildContext context) {
        return Column(
            children: _getFilledList(),
        );
    }

    @override
    void initState() {
        super.initState();
        currentDate = DateTime.now();
        _timeUtil = TimeUtil(() {
            setState(() {
                currentDate = DateTime.now();
            });
        });
        _timeUtil.addExactOneDayListener();
    }

    List<Widget> _getFilledList() {
        int baseIndex = 0;
        for (var i = 0; i < widget.data.length; ++i) {
            var temp = DateTime.fromMillisecondsSinceEpoch(widget.data[i].time * 1000);
            if (currentDate.day == temp.day) {
                baseIndex = i + 1;
                break;
            }
        }

        var data = widget.data.sublist(baseIndex).toList();
        int count = min(widget.count ?? data.length, data.length);

        List<Widget> widgetList = [];
        for (var i = 0; i < count; ++i) {
            widgetList.add(
                _futureDayContent(
                    DateUtil.getDayNameEpoch(data[i].time),
                    data[i].icon,
                    data[i].temperatureMin.round(),
                    data[i].temperatureMax.round(),
                ),
            );
        }
        return widgetList;
    }

    _futureDayContent(String day, String icon, int maxTemp, int minTemp) {
        var _portraitSize = (MediaQuery
                .of(context)
                .size
                .width / 13).roundToDouble();

        var _landscapeSize = (MediaQuery
                .of(context)
                .size
                .width / 18).roundToDouble();

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                Text(
                                    day,
                                    style: Theme
                                            .of(context)
                                            .textTheme
                                            .display1,
                                ),
                            ],
                        ),
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                Container(
                                    child: WeatherIcon.getSVGIcon(icon),
                                    height: MediaQuery
                                            .of(context)
                                            .orientation == Orientation.portrait
                                            ? _portraitSize
                                            : _landscapeSize,
                                    width: MediaQuery
                                            .of(context)
                                            .orientation == Orientation.portrait
                                            ? _portraitSize
                                            : _landscapeSize,
                                ),
                                SizedBox(width: 12,),
                                Text(
                                    minTemp.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                    ),
                                ),
                                Text(
                                    '/$maxTemp',
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    void dispose() {
        super.dispose();
        _timeUtil.cancelListener();
    }
}
