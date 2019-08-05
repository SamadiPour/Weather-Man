import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_man/module/City.dart';
import 'package:weather_man/module/DatabaseHandler.dart';
import 'package:weather_man/module/SettingData.dart';
import 'package:weather_man/module/ThemeManager.dart';
import 'package:weather_man/Utilities/TimeUtil.dart';
import 'package:weather_man/widgets/WeatherPage/CityName.dart';
import 'package:weather_man/widgets/WeatherPage/FutureDays.dart';
import 'package:weather_man/module/WeatherApiHandler.dart';
import 'package:weather_man/widgets/Animation/LoaderAnimation.dart';
import 'package:weather_man/widgets/Animation/WeatherAnimation.dart';
import 'package:weather_man/widgets/WeatherPage/FutureHours.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weather_man/widgets/WeatherPage/GoogleMaps.dart';
import 'package:weather_man/widgets/WeatherPage/PrecipitationChanceChart.dart';
import 'package:weather_man/widgets/WeatherPage/WeatherDegree.dart';
import 'package:weather_man/widgets/WeatherPage/WeatherDetails.dart';

class WeatherPage extends StatefulWidget {
    final City city;

    WeatherPage({@required this.city});

    @override
    _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
    WeatherApiHandler _weatherApiHandler;
    bool _weatherFetched = false;
    TimeUtil _timeUtil;
    DatabaseHandler databaseHandler;

    @override
    void initState() {
        super.initState();
        databaseHandler = DatabaseHandler();
        _fetchWeatherData();
        _timeUtil = TimeUtil(_fetchWeatherData);
        _timeUtil.addExactOneHourListener();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    gradient: ThemeManager.getGradient(Theme
                            .of(context)
                            .brightness),
                ),
                child: _weatherFetched ? _mainScreen(context)
                        : LoaderAnimation(),
            ),
//            floatingActionButton: Visibility(
//                visible: (_weatherFetched && !widget.added) ? true : false,
//                child: FloatingActionButton.extended(
//                    icon: Icon(Icons.add),
//                    label: Text('Add to List'),
//                    onPressed: () {
//                        setState(() async {
//                            print(await databaseHandler.insertToCityMap(widget.city));
//                            widget.added = true;
//                        });
//                    },
//                ),
//            ),

        );
    }

    @override
    void dispose() {
        super.dispose();
        _timeUtil?.cancelListener();
    }

    _mainScreen(BuildContext context) {
        return SafeArea(
            child: LiquidPullToRefresh(
                backgroundColor: Colors.white,
                color: Theme
                        .of(context)
                        .primaryColor,
                onRefresh: _fetchWeatherData,
                showChildOpacityTransition: false,
                child: ListView(
                    children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                Row(
                                    children: <Widget>[
                                        Expanded(
                                            child: Column(
                                                children: <Widget>[
                                                    SizedBox(height: 65,),
                                                    WeatherDegree(_weatherApiHandler),
                                                    SizedBox(height: 45,),
                                                    CityName(widget.city.name),
                                                ],
                                            ),
                                            flex: 2,
                                        ),
                                        Expanded(
                                            child: WeatherAnimation(
                                                icon: _weatherApiHandler
                                                        .getCurrentWeather()
                                                        .icon,
                                            ),
                                            flex: 3,
                                        ),
                                    ],
                                ),
                                SizedBox(height: 30,),

                                //Weather Details
                                SettingData.get(Settings.ShowWeatherDetails) ?
                                WeatherDetails(_weatherApiHandler) : SizedBox(),
                                SizedBox(
                                    height: SettingData.get(Settings.ShowWeatherDetails) ? 30 : 0,
                                ),

                                //24 Hours
                                SettingData.get(Settings.Show24Hours) ?
                                FutureHours(_weatherApiHandler.forecast.hourly.data, count: 24,)
                                        : SizedBox(),

                                //7 Days
                                SettingData.get(Settings.Show7Days) ?
                                FutureDays(_weatherApiHandler.forecast.daily.data, count: 7)
                                        : SizedBox(),
                                SizedBox(height: SettingData.get(Settings.Show7Days) ? 30 : 0,),

                                //Rain Chart
                                SettingData.get(Settings.ShowRainChart) ?
                                PrecipitationChanceChart(_weatherApiHandler.forecast.hourly.data)
                                        : SizedBox(),
                                SizedBox(height: SettingData.get(Settings.ShowRainChart) ? 30 : 0,),

                                //Map
                                SettingData.get(Settings.ShowMap) ?
                                GoogleMaps(widget.city.lat, widget.city.lon) : SizedBox(),
                                SizedBox(height: SettingData.get(Settings.ShowMap) ? 30 : 0,),

                                //copyright logo
                                LimitedBox(
                                    maxWidth: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 3,
                                    child: Image.asset(
                                        'asset/image/poweredby.png',
                                        color: Colors.white70,
                                        width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 3,
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }


    Future<Null> _fetchWeatherData() async {
        try {
            await WeatherApiHandler.initial(
                lat: widget.city.lat,
                lon: widget.city.lon,
                cityName: widget.city.name,
            ).then((value) {
                if (value != null)
                    setState(() {
                        _weatherApiHandler = value;
                        widget.city.latestData = _weatherApiHandler.forecast;
                        _weatherFetched = true;
                    });
            });
        } catch (e) {

        }
    }

}
