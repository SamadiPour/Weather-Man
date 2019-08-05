import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatelessWidget {
    double lat;
    double lon;

    GoogleMaps(this.lat, this.lon);

    Completer<GoogleMapController> _controller = Completer();

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: LimitedBox(
                maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                maxHeight: 200,
                child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lon),
                        zoom: 9,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                    },
                    markers: <Marker>[
                        Marker(
                            markerId: MarkerId('person'),
                            position: LatLng(lat, lon),
                            infoWindow: InfoWindow(title: "$lat, $lon"),
                            icon: BitmapDescriptor.defaultMarker,
                            flat: true,
                            visible: true,
                        ),
                    ].toSet(),
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: false,
                    mapToolbarEnabled: false,
                ),
            ),
        );
    }
}
