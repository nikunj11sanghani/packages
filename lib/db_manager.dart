import 'package:flutter_packages/model/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBManager {
  static const int _version = 1;
  static const String _dbName = "dbNotes.db";

  static Future<Database> _getData() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Employee(id INTEGER PRIMARY KEY,name TEXT NOT NULL,age INTEGER NOT NULL);"),
        version: _version);
  }

  static Future<int> addEmployee(Employee employee) async {
    final db = await _getData();
    return db.insert("Employee", employee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateEmployee(Employee employee) async {
    final db = await _getData();
    return db.update("Employee", employee.toJson(),
        where: 'id = ?',
        whereArgs: [employee.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteEmployee(Employee employee) async {
    final db = await _getData();
    return db.delete(
      "Employee",
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  static Future<List<Employee>?> getAllData() async {
    final db = await _getData();
    final List<Map<String, dynamic>> maps = await db.query("Employee");

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Employee.frmJson(maps[index]));
  }
}
