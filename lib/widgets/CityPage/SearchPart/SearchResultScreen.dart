import 'package:flutter/material.dart';
import 'package:weather_man/module/City.dart';
import 'package:weather_man/module/SearchData.dart';
import 'package:weather_man/widgets/CityPage/SearchPart/BoldText.dart';
import 'package:weather_man/widgets/CityPage/SearchPart/NoResult.dart';
import 'package:weather_man/widgets/ImageHolder.dart';

class SearchResultScreen extends StatefulWidget {
    final _searchFieldController;

    SearchResultScreen(this._searchFieldController);

    @override
    _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
    @override
    Widget build(BuildContext context) {
        var dataList = SearchData().data;
        return dataList.isEmpty? NoResult() :
        ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        widget._searchFieldController.clear();

                        Navigator.pushNamed(
                            context, '/WeatherPage',
                            arguments: City(
                                dataList[index]['name'],
                                dataList[index]['lat'],
                                dataList[index]['lon'],
                                dataList[index]['country'],
                                null,
                                null,
                            ),
                        );
                    },
                    child: Column(
                        children: <Widget>[
                            SizedBox(height: 12,),
                            Container(
                                child: Row(
                                    children: <Widget>[
                                        LimitedBox(
                                            maxWidth: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 10,
                                            child: ImageHolder(
                                                'asset/image/flag_image/${dataList[index]['country']
                                                        .toString()
                                                        .toLowerCase()}.png',
                                                width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 10,
                                                aspectRatio: 69 / 51,
                                                onErrorPath: 'asset/image/flag_image/ww.png',
                                            ),
                                        ),
                                        SizedBox(width: 40,),
                                        Expanded(
                                            child: BoldText(
                                                mainText: dataList[index]['name'],
                                                boldText: widget._searchFieldController.text.trim(),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            SizedBox(height: 12,),
                        ],
                    ),
                );
            },
        );
    }
}
