import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/TimeUtil.dart';
import 'package:weather_man/module/WeatherIcon.dart' as WeatherIcon;
import 'dart:math';

class FutureHours extends StatefulWidget {
    final List<HourlyDataPoint> data;
    final int count;

    FutureHours(this.data, {this.count});

    @override
    _FutureHoursState createState() => _FutureHoursState();
}

class _FutureHoursState extends State<FutureHours> {

    final GlobalKey<AnimatedListState> _listKey = GlobalKey();
    List<HourlyDataPoint> _data;
    TimeUtil _timeUtil;
    var _currentTime;

    @override
    Widget build(BuildContext context) {
        _data = _getCorrectDataInTime();
        return Container(
            height: 140,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: AnimatedList(
                itemBuilder: (context, index, animation) =>
                        _futureHourContent(
                            _data[index].icon,
                            DateTime
                                    .fromMillisecondsSinceEpoch(_data[index].time * 1000)
                                    .hour,
                            _data[index].temperature,
                            animation,
                        ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                initialItemCount: min(widget.count ?? _data.length, _data.length),
                key: _listKey,
            ),
        );
    }

    Widget _futureHourContent(String icon, int time, double temp, Animation animation) {
        var _portraitSize = (MediaQuery
                .of(context)
                .size
                .width / 9).roundToDouble();

        var _landscapeSize = (MediaQuery
                .of(context)
                .size
                .width / 16).roundToDouble();


        return FadeTransition(
            opacity: animation,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
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
                        SizedBox(height: 9,),
                        Text(
                            '${temp.round()}℃',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                color: Colors.white,
                            ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                            '$time:00',
                            style: TextStyle(
                                color: Colors.white.withAlpha(180),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    _getCorrectDataInTime() {
        int baseIndex = 0;
        for (var i = 0; i < widget.data.length; ++i) {
            var temp = DateTime.fromMillisecondsSinceEpoch(widget.data[i].time * 1000);
            if (_currentTime.hour == temp.hour && _currentTime.day == temp.day) {
                baseIndex = i + 1;
                break;
            }
        }
        return widget.data.sublist(baseIndex);
    }

    @override
    void initState() {
        _currentTime = DateTime.now();
        super.initState();
        _timeUtil = TimeUtil(() {
            setState(() {
                _currentTime = DateTime.now();
                var index = 0;
                AnimatedListRemovedItemBuilder builder = (context, animation) {
                    return _futureHourContent(_data[index].icon,
                        DateTime
                                .fromMillisecondsSinceEpoch(_data[index].time * 1000)
                                .hour,
                        _data[index].temperature,
                        animation,
                    );
                };
                _data.removeAt(0);
                _listKey.currentState.removeItem(index, builder);
            });
        });
        _timeUtil.addExactOneHourListener();
    }

    @override
    void dispose() {
        super.dispose();
        _timeUtil?.cancelListener();
    }
}
