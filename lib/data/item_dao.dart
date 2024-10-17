
import 'package:list_bloc_cubit/data/database.dart';
import 'package:sqflite/sqflite.dart';

class ItemDao {
  static const String tableSql = 'CREATE TABLE $_tablename(' '$_item TEXT )';
  static const String _tablename = 'itensTable';
  static const String _item = 'itemColumn';

  insertItem(String newItem) async {
    final Database db = await getDatabase();
    // var itemExists = await find(newItem);
    // Map<String, dynamic> newItemMap = toMap(newItem);
    // if(itemExists.isEmpty){
    //   return await db.insert(_tablename, newItemMap);
    // }else{
    //   return await db.update(_tablename, newItemMap, where: '$_item = ?', whereArgs: [newItem]);
    // }

    await db.insert(
      _tablename,
      {_item: newItem},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablename);
    await Future.delayed(const Duration(seconds: 5));
    return List.generate(result.length, (i) {
      return result[i][_item] as String;
    });
  }

  Future<bool> findItem(String itemWanted) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db
        .query(_tablename, where: '$_item = ?', whereArgs: [itemWanted]);
    return result.isNotEmpty;
  }

  delete(String itemDeleted) async {
    final Database db = await getDatabase();
    return db.delete(_tablename, where: '$_item = ?', whereArgs: [itemDeleted]);
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
