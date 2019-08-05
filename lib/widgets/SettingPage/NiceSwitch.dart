import 'package:flutter/material.dart';
import 'package:xlive_switch/xlive_switch.dart';

class NiceSwitch extends StatelessWidget {
    final String text;
    final double fontSize;
    final Function onChange;
    final bool value;
    final Color unActiveColor;
    final Color activeColor;

    NiceSwitch({@required this.text, @required this.onChange, @required this.value,
        this.fontSize = 16, this.unActiveColor = Colors.grey,
        this.activeColor = const Color(0xFF4CD964)});

    @override
    Widget build(BuildContext context) {
        return ListTile(
            dense: true,
            leading: Text(
                text,
                style: Theme
                        .of(context)
                        .textTheme
                        .body1
                        .merge(TextStyle(fontSize: fontSize),),
            ),
            trailing: XlivSwitch(
                value: value,
                unActiveColor: unActiveColor,
                activeColor: activeColor,
                onChanged: onChange,
            ),
            onTap: () {
                onChange(!value);
            },
        );
    }
}
