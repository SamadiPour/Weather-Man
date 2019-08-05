import 'package:flutter_svg/flutter_svg.dart';


//---------to read from files locally
class _WeatherIconsSVG {
    static SvgPicture clearDay = SvgPicture.asset('asset/image/weather_icon/day.svg');
    static SvgPicture clearNight = SvgPicture.asset('asset/image/weather_icon/night.svg');

    static SvgPicture fewCloudsDay = SvgPicture.asset('asset/image/weather_icon/cloudy-day.svg');
    static SvgPicture fewCloudsNight = SvgPicture.asset(
            'asset/image/weather_icon/cloudy-night.svg');

    static SvgPicture cloudy = SvgPicture.asset('asset/image/weather_icon/cloudy.svg');

    static SvgPicture rain = SvgPicture.asset('asset/image/weather_icon/rainy.svg');

    static SvgPicture sleet = SvgPicture.asset('asset/image/weather_icon/sleet.svg');

    static SvgPicture snow = SvgPicture.asset('asset/image/weather_icon/snowy.svg');

    static SvgPicture windy = SvgPicture.asset('asset/image/weather_icon/windy.svg');

    static SvgPicture mist = SvgPicture.asset('asset/image/weather_icon/mist.svg');
}

//--------DarkSky Api Coding
SvgPicture getSVGIcon(String description) {
    switch (description) {
        case 'clear-day':
            return _WeatherIconsSVG.clearDay;
        case 'clear-night':
            return _WeatherIconsSVG.clearNight;
        case 'rain':
            return _WeatherIconsSVG.rain;
        case 'sleet':
            return _WeatherIconsSVG.sleet;
        case 'snow':
            return _WeatherIconsSVG.snow;
        case 'wind':
            return _WeatherIconsSVG.windy;
        case 'fog':
            return _WeatherIconsSVG.mist;
        case 'cloudy':
            return _WeatherIconsSVG.cloudy;
        case 'partly-cloudy-day':
            return _WeatherIconsSVG.fewCloudsDay;
        case 'partly-cloudy-night':
            return _WeatherIconsSVG.fewCloudsNight;
        default:
            return _WeatherIconsSVG.clearDay;
    }
}