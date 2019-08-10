import 'dart:convert';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/ApiKey.dart';
import 'package:weather_man/module/City.dart';

class WeatherApiHandler {

    Forecast _forecast;

    Forecast get forecast => _forecast;

    WeatherApiHandler._(this._forecast);

    static Future<WeatherApiHandler> initial(
            {@required double lat, @required double lon, @required String cityName,
                List<Exclude> excludes = const [Exclude.Minutely, Exclude.Flags],
                Units unit = Units.CA,
            }) async {
        var darksky = new DarkSkyWeather(
            ApiKey.DARK_SKY_API,
            language: Language.English,
            units: unit,
        );

        var _forecast = await darksky.getForecast(
            lat,
            lon,
            excludes: excludes,
        );

        return WeatherApiHandler._(_forecast);
    }

    static Future<WeatherApiHandler> fromJson(String data) async {
        var _forecast = Forecast.fromJson(
            json.decode(data),
        );

        return WeatherApiHandler._(_forecast);
    }

    static Future<WeatherApiHandler> fromDatabase(City city) async {

    }

    List<DailyDataPoint> getFutureDaysWeatherList(int dayCount) {
        var _daily = _forecast.daily.data;
        assert(dayCount <= _daily.length);
        //we don't take 0 because it's the day that we are in it!
        return _daily.sublist(1, dayCount + 1);
    }

    List<HourlyDataPoint> getFutureHoursWeatherList(int hourCount) {
        var _hourly = _forecast.hourly.data;
        assert(hourCount <= _hourly.length);
        //we don't take 0 because it's the hour that we are in it!
        return _hourly.sublist(1, hourCount + 1);
    }

    CurrentlyDataPoint getCurrentWeather() {
        return _forecast.currently;
    }

    DailyDataPoint getTodayWeather() {
        return _forecast.daily.data[0];
    }

//    saveLastWeather() async {
//        if (_sharedPreferences == null) {
//            _sharedPreferences = await SharedPreferences.getInstance();
//        }
//
//        await _sharedPreferences.setString("LAST_${cityName}_WEATHER", json.encode(_forecast));
//    }
//
//    deleteLastWeather(String cityName) async {
//        if (_sharedPreferences == null) {
//            _sharedPreferences = await SharedPreferences.getInstance();
//        }
//
//        _sharedPreferences.remove("LAST_${cityName}_WEATHER");
//    }
//
//    static Future<WeatherApiHandler> fromSP(String cityName) async {
//        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//        var data = sharedPreferences.getString("LAST_${cityName}_WEATHER");
//        if (data == null)
//            return null;
//
//        var forecast = Forecast.fromJson(
//            json.decode(data),
//        );
//        return WeatherApiHandler._(cityName, forecast, sharedPreferences: sharedPreferences);
//    }

}