import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NiceAlert extends StatefulWidget {
    final ValueListenable<String> alertTitle;
    final String alertSubtitle;
    final Function onCancel;

    NiceAlert({
        Key key,
        @required this.alertTitle,
        @required this.alertSubtitle,
        this.onCancel,
    }) : super(key: key);

    createState() => _NiceAlertState();
}

class _NiceAlertState extends State<NiceAlert> {

    double deviceWidth;
    double deviceHeight;
    double dialogHeight;

    sto(){}

    @override
    Widget build(BuildContext context) {
        Orientation orientation = MediaQuery
                .of(context)
                .orientation;
        Size screenSize = MediaQuery
                .of(context)
                .size;

        deviceWidth = orientation == Orientation.portrait
                ? screenSize.width
                : screenSize.height;
        deviceHeight = orientation == Orientation.portrait
                ? screenSize.height
                : screenSize.width;
        dialogHeight = deviceHeight * (2 / 5);

        return WillPopScope(
            onWillPop: () {
                widget.onCancel();
                return Future.value(true);
            },
            child: MediaQuery(
                data: MediaQueryData(),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 3.0,
                        sigmaY: 3.0,
                    ),
                    child: GestureDetector(
                        onTap: () {
                            widget.onCancel();
                            Navigator.pop(context);
                        },
                        child: Container(
                            height: deviceHeight,
                            color: Theme
                                    .of(context)
                                    .cardColor
                                    .withOpacity(0.3),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    Expanded(
                                        child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: <Widget>[
                                                Positioned(
                                                    bottom: 0.0,
                                                    child: Container(
                                                        height: dialogHeight,
                                                        width: deviceWidth * 0.9,
                                                        child: GestureDetector(
                                                            onTap: () {},
                                                            child: _mainCard(context),
                                                        ),
                                                    ),
                                                ),
                                                Positioned(
                                                    bottom: dialogHeight - 50,
                                                    child: _defaultIcon(),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    Image _defaultIcon() {
        return Image.asset(
            'asset/image/map.png',
            width: deviceHeight / 7,
            height: deviceHeight / 7,
        );
    }

    Container _defaultAction(BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: FlatButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                    ),
                ),
                child: Text(
                    "CANCEL",
                    style: TextStyle(
                        color: Colors.red,
                    ),
                ),
                onPressed: () {
                    widget.onCancel();
                    Navigator.pop(context);
                },
            ),
        );
    }

    _mainCard(BuildContext context) {
        return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                ),
            ),
            color: Theme
                    .of(context)
                    .cardColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(height: dialogHeight / 4),
                    ValueListenableBuilder<String>(
                        valueListenable: widget.alertTitle,
                        builder: (context, value, child) {
                            return Text(
                                widget.alertTitle.value,
                                style: TextStyle(fontSize: 28.0),
                            );
                        },
                    ),
                    SizedBox(height: dialogHeight / 13),
                    Text(
                        widget.alertSubtitle,
                        style: TextStyle(
                            color: Colors.grey,
                        ),
                    ),
                    SizedBox(height: dialogHeight / 10),
                    _defaultAction(context)
                ],
            ),
        );
    }
}