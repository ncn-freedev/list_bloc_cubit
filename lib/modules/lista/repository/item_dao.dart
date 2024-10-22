import 'package:list_bloc_cubit/modules/lista/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ItemDao {
  static const String tableSql = 'CREATE TABLE $_tablename(' '$_item TEXT )';
  static const String _tablename = 'itensTable';
  static const String _item = 'itemColumn';

  Future<List<String>> getAll() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> result = await db.query(_tablename);

      return List.generate(result.length, (i) {
        return result[i][_item] as String;
      });
    } catch (e) {
      return [];
    }
  }

  Future<bool> insertItem(String newItem) async {
    try {
      final Database db = await getDatabase();
      await db.insert(
        _tablename,
        {_item: newItem},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> findItem(String itemWanted) async {
    try {
      final Database db = await getDatabase();
      final List<Map<String, dynamic>> result = await db
          .query(_tablename, where: '$_item = ?', whereArgs: [itemWanted]);
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String itemDeleted) async {
    try {
      final Database db = await getDatabase();
      await db
          .delete(_tablename, where: '$_item = ?', whereArgs: [itemDeleted]);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<String> toList(List<Map<String, dynamic>> itensMap) {
    final List<String> itensReceived = [];
    for (Map<String, dynamic> line in itensMap) {
      itensReceived.add(line[_item]);
    }
    return itensReceived;
  }

  Map<String, dynamic> toMap(String item) {
    Map<String, dynamic> itensMap = {};
    itensMap[_item] = item;
    return itensMap;
  }
}
