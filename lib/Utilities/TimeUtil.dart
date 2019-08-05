import 'dart:async';

class TimeUtil {
    Timer _timer;
    final dynamic Function() function;

    TimeUtil(this.function);

    addExactOneDayListener() {
        var sec = 62 - DateTime
                .now()
                .second;
        _timer = Timer(Duration(seconds: sec), () {
            var min = 60 - DateTime
                    .now()
                    .minute;
            _timer = Timer(Duration(minutes: min), () {
                var hour = 60 - DateTime
                        .now()
                        .hour;
                _timer = Timer(Duration(hours: hour), () {
                    function();
                    _timer = Timer.periodic(Duration(days: 1), (_) {
                        function();
                    });
                });
            });
        });
    }

    addExactOneHourListener() {
        var sec = 62 - DateTime
                .now()
                .second;
        _timer = Timer(Duration(seconds: sec), () {
            var min = 60 - DateTime
                    .now()
                    .minute;
            _timer = Timer(Duration(minutes: min), () {
                function();
                _timer = Timer.periodic(Duration(hours: 1), (_) {
                    function();
                });
            });
        });
    }

    addExactOneMinuteListener() {
        var sec = 62 - DateTime
                .now()
                .second;
        _timer = Timer(Duration(seconds: sec), () {
            function();
            _timer = Timer.periodic(Duration(minutes: 1), (_) {
                function();
            });
        });
    }

    addUpdateListener(Duration duration) {
        _timer = Timer.periodic(duration, (_){
            function();
        });
    }

    cancelListener() {
        _timer?.cancel();
    }
}