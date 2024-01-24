import 'package:salesman/app/helper/log.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../views/schadule/models/schadule_model.dart';

class MeetingDB {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'meeting_data.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE meeting_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eventName TEXT,
        fromDateTime TEXT,
        toDateTime TEXT,
        backgroundColor INTEGER,
        isAllDay INTEGER
      )
    ''');
    logError('Meeting Database created');
  }

  Future<int> insertMeeting(Meeting meeting) async {
    Database db = await database;
    int index = await db.insert('meeting_data', meeting.toMap());
    logError('Meeting inserted at index $index');
    return index;
  }

  Future<List<Meeting>> getAllMeetings() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('meeting_data');
    List<Meeting> meetings = List.generate(maps.length, (index) {
      return Meeting(
        maps[index]['eventName'],
        DateTime.parse(maps[index]['fromDateTime']),
        DateTime.parse(maps[index]['toDateTime']),
        Color(maps[index]['backgroundColor']),
        maps[index]['isAllDay'] == 1,
      );
    });
    logError('Fetched ${meetings.length} meetings');
    return meetings;
  }

  Future<void> closeDatabase() async {
    await _database?.close();
  }
}
