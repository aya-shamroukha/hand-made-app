// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

class Sqflite {
  late Database db;

  //!initDatabase
  initDb() async {
    //CREATE DB
    await openDatabase(
      'location.db',
      version: 1,
      onCreate: (db, version) async {
        //CREATE TABLE Locations
        await db.execute('''
      CREATE TABLE Locations(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      area TEXT,
      street TEXT,
      phone TEXT,
      details TEXT
      )
      ''').then((value) => print('Locations table created'));
      },
      onOpen: (db) {
        print('db open');
      },
      // ignore: body_might_complete_normally_catch_error
    ).then((value) => db = value).catchError((e) {
      print(e.toString());
    });
  }

  //!get
  Future<List<Map<String, Object?>>> getFormDB() async {
    return await db.rawQuery('SELECT * FROM Locations');
  }

  //!insert LocationModel
  Future<int> insertLocation(LocationModel model) async {
    return await db.rawInsert('''
    INSERT INTO Locations(
      area, street, phone, details
    ) VALUES (
      '${model.area}', '${model.street}', '${model.phone}', '${model.details}'
    )
''');
  }

  //!update
  Future<int> updateDB(int id) async {
    return await db.rawUpdate('''
UPDATE Locations
SET isCompleted =  ?
WHERE id = ?
''', [1, id]);
  }

  //!delete Db
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete('''
DELETE FROM Locations WHERE id = ?
''', [id]);
  }
}

// LocationModel class for sqflite insert
class LocationModel {
  final int? id;
  final String? area;
  final String? street;
  final String? phone;
  final String? details;
  LocationModel({
    this.id,
    required this.area,
    required this.street,
    required this.phone,
    required this.details,
  });

  factory LocationModel.fromjson(Map<String, dynamic> jsonData) {
    return LocationModel(
      id: jsonData['id'],
      area: jsonData['area'],
      street: jsonData['street'],
      phone: jsonData['phone'],
      details: jsonData['details'],
    );
  }
}
