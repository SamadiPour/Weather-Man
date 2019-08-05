import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';

class SliderData {
    var _bodyTexts = [
        'It can use your device GPS to show your city weather',
        'We use cute charts to show rain in a better way',
        'You can search in a large database of cities names',
        'Check the weather and keep yourself dry ;)',
    ];
    var _titleTexts = [
        'Location',
        'Charts',
        'Cities',
        'Rain',
    ];
    var _mainImages = [
        'asset/image/intro_image/gps.png',
        'asset/image/intro_image/graph.png',
        'asset/image/intro_image/city.png',
        'asset/image/intro_image/dry.png',
    ];
    var _pageColors = [
//        const Color(0xFF60a917),
//        const Color(0xFF9c27b0),
//        const Color(0xFF009688),
//        const Color(0xFF03a9f4),
        Colors.grey[50],
        Colors.grey[50],
        Colors.grey[50],
        Colors.grey[50],
    ];

    List<Slide> getPages() {
        List<Slide> pages = [];

        for (int i = 0; i < _titleTexts.length; i++) {
            pages.add(
                Slide(
                    backgroundColor: _pageColors[i],
                    description: _bodyTexts[i],
                    title: _titleTexts[i],
                    styleTitle: TextStyle(
                        color: Color(0xff3da4ab),
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                    ),
                    styleDescription: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                    ),
                    pathImage: _mainImages[i],
                ),
            );
        }

        return pages;
    }


    List<Widget> renderListCustomTabs(slides) {
        List<Widget> tabs = new List();
        for (int i = 0; i < _titleTexts.length; i++) {
            Slide currentSlide = slides[i];
            tabs.add(
                Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                            horizontal: 65, vertical: 15),
                                    child: Image.asset(
                                        currentSlide.pathImage,
                                    ),
                                ),
                                Container(
                                    child: Text(
                                        currentSlide.title,
                                        style: currentSlide.styleTitle,
                                        textAlign: TextAlign.center,
                                    ),
                                    margin: EdgeInsets.only(top: 20.0),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 17,),
                                    child: Text(
                                        currentSlide.description,
                                        style: currentSlide.styleDescription,
                                        textAlign: TextAlign.center,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                    margin: EdgeInsets.only(top: 20.0),
                                ),
                            ],
                        ),
                    ),
                ),
            );
        }
        return tabs;
    }
}