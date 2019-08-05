import 'package:weather_man/module/DatabaseHandler.dart';

class SearchData {
    static final SearchData _searchData = SearchData._();
    List<Map<String, dynamic>> _data = [];
    final _database = DatabaseHandler();

    List<Map<String, dynamic>> get data => _data;

    SearchData._();

    factory SearchData() {
        return _searchData;
    }

    updateData(String text) async {
        _data = await _database.getLocationMap(text);
    }
}