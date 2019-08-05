import 'dart:convert';

import 'package:darksky_weather/darksky_weather_io.dart';

class City {
    String _name;
    double _lat;
    double _lon;
    String _country;
    Forecast _latestData;
    int _order;

    City([this._name, this._lat, this._lon, this._country, this._latestData, this._order]);

    String get name => _name;

    double get lat => _lat;

    double get lon => _lon;

    String get country => _country;

    Forecast get latestData => _latestData;

    int get order => _order;

    set latestData(Forecast value) {
        _latestData = value;
    }

    set order(int order) {
        _order = order;
    }

    Map<String, dynamic> toMap() {
        return <String, dynamic>{
            'name': _name,
            'lat': _lat,
            'lon': _lon,
            'country': _country,
            'latestData': _latestData,
            'order': _order,
        };
    }

    City.fromMap(Map<String, dynamic> map){
        this._name = map['name'];
        this._lat = map['lat'];
        this._lon = map['lon'];
        this._country = map['country'];
        this._latestData = json.decode(map['latestData']);
        this._order = map['order'];
    }

}