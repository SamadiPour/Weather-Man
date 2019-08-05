import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_man/pages/intro/IntroSliderPages.dart';
import 'package:intro_slider/intro_slider.dart' as Intro;


class IntroSlider extends StatelessWidget {
    Widget build(BuildContext context) {
        var data = SliderData();
        var pages = data.getPages();
        return Scaffold(
            body: SafeArea(
                child: Intro.IntroSlider(
                    slides: pages,
                    renderNextBtn: Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        size: 25.0,
                    ),
                    renderDoneBtn: Icon(
                        Icons.done,
                        color: Colors.black,
                        size: 25.0,
                    ),
                    renderSkipBtn: Text(
                        'SKIP',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    onDonePress: () async {
                        await (await SharedPreferences.getInstance())
                                .setBool('INTRO_SEEN', true);
                        Navigator.pushReplacementNamed(context, '/');
                    },
                    backgroundColorAllSlides: Colors.grey[50],
                    listCustomTabs: data.renderListCustomTabs(pages),
                ),
            ),
        );
    }
}