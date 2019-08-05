import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';
import 'package:weather_man/module/City.dart';
import 'package:weather_man/module/CityApiHandler.dart';
import 'package:weather_man/module/LocationManager.dart';
import 'package:weather_man/module/ThemeManager.dart';
import 'package:weather_man/widgets/CityPage/NiceAlert.dart';

class LocationButton extends StatelessWidget {
    bool tapped = false;
    BuildContext _context;

    @override
    Widget build(BuildContext context) {
        return Builder(
            builder: (context) {
                _context = context;
                return Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeManager.getBoxColor(context),
                    ),
                    child: IconButton(
                        icon: Icon(
                            Icons.my_location,
                            color: kIconOnGreyColor,
                        ),
                        onPressed: () => _handleLocationButtonPress(context),
                    ),
                );
            },
        );
    }

    _handleLocationButtonPress(BuildContext context) async {
        //for preventing multi touch on location button
        if (tapped)
            return;
        tapped = true;

        var location = LocationManager();
        if (!await location.getPermission()) {
            tapped = false;
            _showSnackBar(context, 'You Denied Accessing ME :(((');
            return;
        }

        try {
            //for not loading weather page if user cancelled it
            bool shouldShow = true;

            final title = new ValueNotifier('Locating...');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                    return NiceAlert(
                        alertTitle: title,
                        alertSubtitle: 'Please Wait',
                        onCancel: () {
                            tapped = false;
                            shouldShow = false;
                            Scaffold.of(_context).showSnackBar(
                                SnackBar(
                                    content: Text('You Have Cancelled Locating Request!'),
                                    duration: Duration(seconds: 2),
                                ),
                            );
                        },
                    );
                },
            );

            var currentLocation = await location.getLocation();

            if (currentLocation != null) {
                if (!shouldShow) {
                    tapped = false;
                    return;
                }

                //we found location so lets change title
                title.value = 'Finding Geo Info';

                //fetch city name from api
                String cityName = await CityApiHandler().getLocationName(
                    lat: currentLocation.latitude,
                    lon: currentLocation.longitude,
                );

                if (cityName != null) {
                    City city = City(
                        cityName,
                        currentLocation.latitude,
                        currentLocation.longitude,
                        null,
                        null,
                        null,
                    );

                    if (city != null) {
                        if (!shouldShow) {
                            tapped = false;
                            return;
                        }

                        tapped = false;
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, '/WeatherPage',
                            arguments: city,
                        );
                    } else {
                        tapped = false;
                        Navigator.pop(context);
                        _showSnackBar(context, 'Something went wrong! Try Again');
                        return;
                    }
                } else {
                    tapped = false;
                    Navigator.pop(context);
                    _showSnackBar(context, 'Connection Failed! Try Again');
                    return;
                }
            } else {
                tapped = false;
                Navigator.pop(context);
                _showSnackBar(context, 'You Denied Accessing ME :(((');
                return;
            }
        } catch (e) {
            print(e);
        }
        tapped = false;
    }

    _showSnackBar(BuildContext context, String text) {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text(text,),
                duration: Duration(seconds: 2),
            ),
        );
    }
}
