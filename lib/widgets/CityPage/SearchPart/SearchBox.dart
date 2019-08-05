import 'package:flutter/material.dart';
import 'package:weather_man/Utilities/Constants.dart';
import 'package:weather_man/module/ThemeManager.dart';

class SearchBox extends StatefulWidget {
    final _searchFieldController;
    bool _isEmpty;

    SearchBox(this._searchFieldController, this._isEmpty);

    @override
    _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 45,
            decoration: BoxDecoration(
                color: ThemeManager.getBoxColor(context),
                borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: TextField(
                            textInputAction: TextInputAction.search,
                            style: TextStyle(
                                color: kIconOnGreyColor,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                    Icons.search,
                                ),
                                focusColor: Theme
                                        .of(context)
                                        .primaryColor,
                                fillColor: Theme
                                        .of(context)
                                        .primaryColor,
                                hoverColor: Theme
                                        .of(context)
                                        .primaryColor,
                            ),
                            maxLines: 1,
                            controller: widget._searchFieldController,
                            autocorrect: false,
                        ),
                    ),
                    SizedBox(width: 8,),
                    _clearButton(),
                    SizedBox(width: 8,),
                ],
            ),
        );
    }

    _clearButton() {
        if (!widget._isEmpty) {
            return GestureDetector(
                child: Icon(
                    Icons.clear,
                    color: kSearchGreyColor,
                    size: 22,
                ),
                onTap: () {
                    widget._searchFieldController.clear();
                },
            );
        } else {
            return SizedBox();
        }
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    void initState() {
        super.initState();
    }
}