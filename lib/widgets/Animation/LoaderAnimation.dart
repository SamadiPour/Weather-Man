import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

/*
* https://www.2dimensions.com/a/SamadiPour/files/flare/liquid-loader/preview
*/

class LoaderAnimation extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MediaQuery
                .of(context)
                .orientation == Orientation.portrait ?
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _innerContext(context),
        ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _innerContext(context),
        );
    }

    List<Widget> _innerContext(BuildContext context) {
        var _width = MediaQuery
                .of(context)
                .size
                .width;

        var _height = MediaQuery
                .of(context)
                .size
                .height;

        return [
            LimitedBox(
                maxWidth: MediaQuery
                        .of(context)
                        .orientation == Orientation.portrait ? _width : _height,
                maxHeight: MediaQuery
                        .of(context)
                        .orientation == Orientation.portrait ? _width : _height,
                child: FlareActor(
                    'asset/animation/liquid_loader.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: 'Untitled',
                ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Text(
                        'LOADING WEATHER FOR YOU...',
                        style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                    ),
                    Text(
                        'ONE SEC PLEASE',
                        style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                    ),
                ],
            ),
        ];
    }
}
