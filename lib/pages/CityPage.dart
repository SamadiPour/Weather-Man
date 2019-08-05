import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:weather_man/module/SearchData.dart';
import 'package:weather_man/pages/SettingPage.dart';
import 'package:weather_man/widgets/CityPage/SearchPart/EmptyList.dart';
import 'package:weather_man/widgets/CityPage/SearchPart/SearchResultScreen.dart';
import 'package:weather_man/widgets/CityPage/TopBar.dart';

class CityPage extends StatefulWidget {
    @override
    _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
    final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
    final _searchFieldController = TextEditingController();
    DateTime currentBackPressTime;
    BuildContext _context;
    bool _isEmpty = true;
    bool opened = false;

    @override
    Widget build(BuildContext context) {
        return InnerDrawer(
            key: _innerDrawerKey,
            child: SettingPage(),
            animationType: InnerDrawerAnimation.quadratic,
            position: InnerDrawerPosition.start,
            offset: 0.75,
            innerDrawerCallback: (value) => opened = value,
            swipe: true,
            onTapClose: true,
            scaffold: _mainScaffoldContent(),
        );
    }


    @override
    void initState() {
        super.initState();
        _searchFieldController.addListener(() async {
            if (_searchFieldController.text != '') {
                if (_isEmpty) {
                    setState(() {
                        _isEmpty = false;
                    });
                }
                await SearchData().updateData(_searchFieldController.text);
                setState(() {});
            } else {
                if (!_isEmpty) {
                    setState(() {
                        _isEmpty = true;
                    });
                }
            }
        });
    }

    @override
    void dispose() {
        super.dispose();
        _searchFieldController.clear();
        _searchFieldController.dispose();
    }

    Future<bool> _popFunction(BuildContext context) {
        if (opened) {
            _innerDrawerKey.currentState.close();
            return Future.value(false);
        } else {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                    now.difference(currentBackPressTime) > Duration(seconds: 2)) {
                currentBackPressTime = now;
                Scaffold.of(_context).showSnackBar(
                    SnackBar(
                        content: Text('Press Again to Exit App',),
                        duration: Duration(seconds: 2),
                    ),
                );
                return Future.value(false);
            }
            return Future.value(true);
        }
    }

    _mainScaffoldContent() {
        return WillPopScope(
            onWillPop: () => _popFunction(context),
            child: Scaffold(
                body: Builder(
                    builder: (context) {
                        _context = context;
                        return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: SafeArea(
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                        children: <Widget>[
                                            TopBar(_searchFieldController, _isEmpty),
                                            SizedBox(height: 20,),
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    child: _isEmpty ? EmptyList()
                                                            : SearchResultScreen(
                                                            _searchFieldController),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        );
                    },
                ),
            ),
        );
    }
}
