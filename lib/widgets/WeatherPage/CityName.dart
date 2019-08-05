import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CityName extends StatelessWidget {
    final String name;

    CityName(this.name);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(left: 5),
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xaffDDEF8).withAlpha(70),
                    borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Icon(
                            Icons.location_on,
                            color: ThemeData
                                    .dark()
                                    .iconTheme
                                    .color,
                        ),
                        SizedBox(width: 6,),
                        LimitedBox(
                            maxWidth: 100,
                            child: AutoSizeText(
                                name,
                                textAlign: TextAlign.center,
                                style: Theme
                                        .of(context)
                                        .textTheme
                                        .title,
                                maxLines: 2,
                                minFontSize: Theme
                                        .of(context)
                                        .textTheme
                                        .title
                                        .fontSize,
                                overflow: TextOverflow.ellipsis,
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
