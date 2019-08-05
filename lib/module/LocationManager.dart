import 'package:location/location.dart';

class LocationManager {
    Location location;

    LocationManager() {
        location = new Location();
        location.changeSettings(accuracy: LocationAccuracy.BALANCED);
    }

    Future<bool> getPermission() async {
        bool permission = true;

        if (!await location.hasPermission())
            permission &= await location.requestPermission();

        if (!await location.serviceEnabled())
            permission &= await location.requestService();

        return permission;
    }

    getLocation() async {
        var currentLocation;
        try {
            currentLocation = await location.getLocation();
        } catch (e) {
            currentLocation = null;
        }

        return currentLocation;
    }
}