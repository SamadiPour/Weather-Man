import 'dart:convert';
import 'package:http/http.dart';

class CityApiHandler {
    static const String baseURL = 'http://api.geonames.org/findNearbyJSON?formatted=true&fclass=P&fcode=PPLA&fcode=PPL&fcode=PPLC&username=YOUR_API_KEY&style=SHORT';
    var json;

    getLocationName({double lat, double lon}) async {
        Response response = await get(baseURL + '&lat=$lat&lng=$lon');
        if (response.statusCode == 200){
            String data = response.body;
            json = await jsonDecode(data);
            var cityName = json['geonames'][0]['toponymName'];
            return cityName;
        } else {
            return null;
        }
    }
}