import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
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
                            'asset/image/empty.png',
                            width: MediaQuery
                                    .of(context)
                                    .orientation == Orientation.portrait ? MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.6 : MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2.2,
                        ),
                        SizedBox(height: 50,),
                        Text(
                            'Search for City',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                            ),
                        ),
                        Text(
                            'or Use Location Button',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                            ),
                        ),
                        SizedBox(height: 80,),
                    ],
                ),
            ),
        );
    }
}
