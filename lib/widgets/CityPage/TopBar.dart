import 'package:flutter/material.dart';
import 'package:weather_man/widgets/CityPage/LocationButtton.dart';
import 'package:weather_man/widgets/CityPage/SearchPart/SearchBox.dart';

class TopBar extends StatelessWidget {

    final _searchFieldController;
    bool _isEmpty;

    TopBar(this._searchFieldController, this._isEmpty);

    @override
    Widget build(BuildContext context) {
        return LimitedBox(
            maxHeight: 100,
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SearchBox(_searchFieldController, _isEmpty),
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LocationButton(),
                    ),
                ],
            ),
        );
    }
}
