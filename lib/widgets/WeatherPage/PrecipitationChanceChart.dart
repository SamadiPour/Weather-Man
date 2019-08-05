import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/TimeUtil.dart';
import 'package:weather_man/module/ThemeManager.dart';

class PrecipitationChanceChart extends StatefulWidget {
    final List<HourlyDataPoint> data;

    PrecipitationChanceChart(this.data);

    @override
    _PrecipitationChanceChartState createState() => _PrecipitationChanceChartState();
}

class _PrecipitationChanceChartState extends State<PrecipitationChanceChart> {
    List<HourlyDataPoint> _data = [];
    List<FlSpot> _dataPoints = [];
    List<String> _clocks = [];
    TimeUtil _timeUtil;
    var _currentTime;
    double _width;

    @override
    Widget build(BuildContext context) {
        _width = MediaQuery
                .of(context)
                .size
                .width;
        _data = _getCorrectDataInTime();
        _clocks = _getTitlesList();
        _dataPoints = _getDataPoints();

        return Column(
            children: <Widget>[
                Text(
                    'CHANCE OF PRECIPITATION',
                    style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                ),
                SizedBox(height: 15,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: AspectRatio(
                        aspectRatio: 2.2,
                        child: _chart(context),
                    ),
                ),
            ],
        );
    }

    _chart(BuildContext context) {
        return FlChart(
            chart: LineChart(
                LineChartData(
                    gridData: FlGridData(
                        show: false,
                        drawHorizontalGrid: false,
                    ),
                    titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                            ),
                            getTitles: (value) => _clocks[value.toInt()],
                            margin: 8,
                        ),
                        leftTitles: SideTitles(
                            showTitles: true,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                            ),
                            getTitles: (value) => _getLeftTitles(value.toInt()),
                            reservedSize: 28,
                            margin: 12,
                        ),
                    ),
                    borderData: FlBorderData(
                        show: false,
                    ),
                    minX: 0,
                    maxX: 24,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                        LineChartBarData(
                            spots: _dataPoints,
                            isCurved: true,
                            colors: ThemeManager.getChartGradient(context),
                            colorStops: [0, 1],
                            barWidth: 3,
                            isStrokeCapRound: false,
                            dotData: FlDotData(
                                show: false,
                            ),
                            preventCurveOverShooting: false,
                            belowBarData: BelowBarData(
                                show: true,
                                colors: ThemeManager.getChartGradient(context).map((color) =>
                                        color.withOpacity(0.3)).toList(),
                                gradientColorStops: [0, 1],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    _getTitlesList() {
        List<String> _clocks = [];
        var counter = 25 ~/ (_width ~/ 80);
        var temp = counter;
        for (var i = 0; i < 25; ++i, temp++) {
            if (temp == counter) {
                temp = 0;
                _clocks.add(
                    '${DateTime
                            .fromMillisecondsSinceEpoch(_data[i].time * 1000)
                            .hour
                            .toString()}:00',
                );
                continue;
            }
            _clocks.add('');
        }
        return _clocks;
    }

    _getLeftTitles(int i) {
        switch (i) {
            case 0:
                return '0%';
            case 5:
                return '50%';
            case 10:
                return '100%';
        }
        return '';
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
                _data.removeAt(0);
            });
        });
        _timeUtil.addExactOneHourListener();
    }

    @override
    void dispose() {
        super.dispose();
        _timeUtil?.cancelListener();
    }

    List<FlSpot> _getDataPoints() {
        List<FlSpot> _temp = [];
        for (var i = 0; i < 25; ++i) {
            _temp.add(
                FlSpot(i.toDouble(), _data[i].precipProbability * 10),
            );
        }
        return _temp;
    }
}
