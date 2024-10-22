import 'package:list_bloc_cubit/modules/lista/repository/item_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'itens.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ItemDao.tableSql);
  }, version: 1,);
}
