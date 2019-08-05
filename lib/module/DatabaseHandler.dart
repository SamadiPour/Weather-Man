import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_man/module/City.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';


class DatabaseHandler {
    static DatabaseHandler _databaseHandler;
    Database _database;

    DatabaseHandler._createInstance();

    Future<Database> get database async {
        if (_database == null)
            _database = await _initializeDirectory();
        return _database;
    }

    final String _cityDataTable = 'city_data';
    final String _locationTable = 'location';

    final String _nameCol = 'name';
    final String _lanCol = 'lan';
    final String _lonCol = 'lon';
    final String _countryCol = 'country';
    final String _latestDataCol = 'latest_data';
    final String _orderCol = 'order';

    factory DatabaseHandler() {
        if (_databaseHandler == null)
            _databaseHandler = DatabaseHandler._createInstance();
        return _databaseHandler;
    }

    Future<Database> _initializeDirectory() async {
        var databasesPath = await getDatabasesPath();
        var path = join(databasesPath, "asset_db.sqlite");
        var exists = await databaseExists(path);

        if (!exists) {
            try {
                await Directory(dirname(path)).create(recursive: true);
            } catch (_) {}

            ByteData data = await rootBundle.load(join("asset", join("database", "c500.sqlite")));
            List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

            await File(path).writeAsBytes(bytes, flush: true);
        }
        _database = await openDatabase(path, readOnly: true);
        return _database;
    }

    //--------------------------Location--------------------------
    Future<int> getLocationCount() async {
        var db = await database;
        return Sqflite.firstIntValue(
                await db.rawQuery('SELECT COUNT(*) FROM $_locationTable'));
    }

    Future<List<Map<String, dynamic>>> getLocationMap(String name) async {
        Database db = await database;
        List<Map<String, dynamic>> data = [];

        var exactResult = await db.query(
            _locationTable,
            where: "$_nameCol = '$name' COLLATE NOCASE",
            orderBy: 'length($_nameCol) asc',
            limit: 10,
        );

        if (exactResult != null) {
            if (exactResult.length == 10)
                return exactResult;
            else if (exactResult.length > 0)
                data.addAll(exactResult);
        }

        var semiExact = await db.query(
            _locationTable,
            where: "$_nameCol LIKE '$name%' COLLATE NOCASE",
            orderBy: 'length($_nameCol) asc',
            limit: 10,
        );


        if (semiExact != null) {
            if (semiExact.length > 0)
                _trimList(data, semiExact);
            if (data.length == 10)
                return data;
        }

        var notExact = await db.query(
            _locationTable,
            where: "$_nameCol LIKE '%$name%' COLLATE NOCASE",
            orderBy: 'length($_nameCol) asc',
            limit: 10,
        );
        if (notExact != null) {
            if (notExact.length > 0)
                data = _trimList(data, notExact);
        }

        return data;
        }


    //--------------------------CITY DATA--------------------------
    Future<int> getCityCount() async {
        var dbClient = await database;
        return Sqflite.firstIntValue(
                await dbClient.rawQuery('SELECT COUNT(*) FROM $_cityDataTable'));
    }

    Future<List<Map<String, dynamic>>> getCityMap() async {
        Database db = await database;
        return await db.query(_cityDataTable, orderBy: '$_orderCol asc',);
    }

    Future<int> insertToCityMap(City city) async {
        Database db = await database;
        return await db.insert(_cityDataTable, city.toMap());
    }

    Future<int> updateCity(City city) async {
        Database db = await database;
        return db.update(
            _cityDataTable,
            city.toMap(),
            where: '$_nameCol = ? and $_lanCol = ? and $_lonCol = ?',
            whereArgs: [city.name, city.lat, city.lon],
        );
    }

    Future<int> deleteCity(City city) async {
        Database db = await this.database;
        return db.delete(
            _cityDataTable,
            where: '$_nameCol = ? and $_lanCol = ? and $_lonCol = ? and $_orderCol',
            whereArgs: [city.name, city.lat, city.lon, city.order],
        );
    }

    List<Map<String, dynamic>> _trimList(List<Map<String, dynamic>> main, List<Map<String, dynamic>> second) {
        outter: for (var temp in second) {
            for (var o in main){
                if (DeepCollectionEquality.unordered().equals(o, temp))
                    continue outter;
            }
            main.add(temp);
        }

        return main.take(10).toList();
    }
}