import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Center(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                        Image.asset(
                            'asset/image/no_result.png',
                            width: MediaQuery
                                    .of(context)
                                    .orientation == Orientation.portrait ? MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.2 : MediaQuery
                                    .of(context)
                                    .size
                                    .height / 1.9,
                        ),
                        SizedBox(height: 50,),
                        Text(
                            'No Result Fonud!',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                            ),
                        ),
                        SizedBox(height: 80,),
                    ],
                ),
            ),
        );
    }
}
