import 'package:shared_preferences/shared_preferences.dart';

enum Settings { ShowWeatherDetails, Show24Hours, Show7Days, ShowRainChart, ShowMap }

class SettingData {
    static SharedPreferences _prefs;
    static bool isDark;
    static bool _showWeatherDetails;
    static bool _show24Hours;
    static bool _show7Days;
    static bool _showRainChart;
    static bool _showMap;

    static initialAll() async {
        if (_prefs == null)
            _prefs = await SharedPreferences.getInstance();
        isDark = _prefs.getBool('isDark') ?? false;
        _showWeatherDetails = _prefs.getBool('WEATHER_DETAILS') ?? true;
        _show24Hours = _prefs.getBool('24_HOURS') ?? true;
        _show7Days = _prefs.getBool('7_DAYS') ?? true;
        _showRainChart = _prefs.getBool('RAIN_CHART') ?? true;
        _showMap = _prefs.getBool('MAP') ?? true;
    }

    static setAllInSP() async {
        if (_prefs == null)
            _prefs = await SharedPreferences.getInstance();
        _prefs.setBool('WEATHER_DETAILS', true);
        _prefs.setBool('24_HOURS', true);
        _prefs.setBool('7_DAYS', true);
        _prefs.setBool('RAIN_CHART', true);
        _prefs.setBool('MAP', true);
        await initialAll();
    }

    static bool get(Settings settings) {
        switch (settings) {
            case Settings.ShowWeatherDetails:
                return _showWeatherDetails;
                break;
            case Settings.Show24Hours:
                return _show24Hours;
                break;
            case Settings.Show7Days:
                return _show7Days;
                break;
            case Settings.ShowRainChart:
                return _showRainChart;
                break;
            case Settings.ShowMap:
                return _showMap;
                break;
        }
    }

    static changeValue(Settings settings) async {
        if (_prefs == null)
            _prefs = await SharedPreferences.getInstance();

        switch (settings) {
            case Settings.ShowWeatherDetails:
                _showWeatherDetails = !_showWeatherDetails;
                await _prefs.setBool('WEATHER_DETAILS', _showWeatherDetails);
                break;
            case Settings.Show24Hours:
                _show24Hours = !_show24Hours;
                await _prefs.setBool('24_HOURS', _show24Hours);
                break;
            case Settings.Show7Days:
                _show7Days = !_show7Days;
                await _prefs.setBool('7_DAYS', _show7Days);
                break;
            case Settings.ShowRainChart:
                _showRainChart = !_showRainChart;
                await _prefs.setBool('RAIN_CHART', _showRainChart);
                break;
            case Settings.ShowMap:
                _showMap = !_showMap;
                await _prefs.setBool('MAP', _showMap);
                break;
        }
    }
}