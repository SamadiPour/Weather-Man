import 'package:intl/intl.dart';

String getDate() {
    return DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
}

List<String> getFutureDays(int count) {
    List<String> _days = [];
    for (int i = 1; i <= count; i++) {
        _days.add(
            DateFormat('EEEE').format(DateTime.now().add(Duration(days: i))),
        );
    }

    return _days;
}

String getDayName(DateTime dateTime){
    return DateFormat('EEEE').format(dateTime);
}

String getDayNameEpoch(int time){
    return DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
}