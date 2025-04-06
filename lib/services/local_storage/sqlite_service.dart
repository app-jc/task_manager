import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/tasks/data/models/task.dart';

class SqfliteService {
  static final SqfliteService _instance = SqfliteService._internal();
  factory SqfliteService() => _instance;
  static const String TABLE_APPCONFIG = "app_config";

  SqfliteService._internal();

  Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "task_manager_db.db");

    var exists = await databaseExists(path);
    if (!exists) {
      debugPrint("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data =
          await rootBundle.load(url.join("assets/db/", "task_manager_db.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint("Opening existing database");
    }
    return await openDatabase(path);
  }

  /// Theme Mode
  Future<String?> getCurrentThemeMode() async {
    final db = await database;
    List<Map> maps = await db.query(
      TABLE_APPCONFIG,
    );
    if (maps.isNotEmpty) {
      return maps.first['theme_mode'];
    }
    return null;
  }

  Future<void> updateThemeMode(String themeMode) async {
    final db = await database;

    final List<Map<String, dynamic>> rows =
        await db.query(TABLE_APPCONFIG, limit: 1);

    if (rows.isNotEmpty) {
      final int firstId = rows.first['id'];
      await db.update(TABLE_APPCONFIG, {'theme_mode': themeMode},
          where: 'id = ?', whereArgs: [firstId]);
    } else {
      await db.insert(TABLE_APPCONFIG, {'theme_mode': themeMode});
    }
  }

  Future<int> createTask(Task task) async {
    try {
      final db = await database;
      return await db.insert('tasks', task.toJson());
    } catch (e) {
      debugPrint('SQFLITE: Fail to create task: $e');
      return -1;
    }
  }

  Future<List<Task>> getAllTasks() async {
    try {
      final db = await database;
      final result = await db.query('tasks');
      return result.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      debugPrint('SQFLITE: Fail to update task $e');
      return [];
    }
  }

  Future<int> updateTask(Task task) async {
    try {
      final db = await database;
      return await db.update(
        'tasks',
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      debugPrint('SQFLITE: Fail to update $e');
      return -1;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint('SQFLITE: Fail to delete $e');
      return -1;
    }
  }
}
