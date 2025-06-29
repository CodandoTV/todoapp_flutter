import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/data/model/checklist.dart';

@LazySingleton()
class ChecklistDAO {
  static const tableName = 'Checklist';
  static const idKey = 'id';
  static const titleKey = 'title';

  static const createTableQuery = 'CREATE TABLE ${ChecklistDAO.tableName} ('
      '${ChecklistDAO.idKey} INTEGER PRIMARY KEY, '
      '${ChecklistDAO.titleKey} TEXT)';

  late Database _database;

  ChecklistDAO(Database database) {
    _database = database;
  }

  Future<List<Checklist>> getAll() async {
    final result = await _database.query(
      tableName,
    );
    return result
        .map(
          (e) => Checklist(
            id: e[idKey] as int,
            title: e[titleKey] as String,
          ),
        )
        .toList();
  }

  _checklistToValues(Checklist checklist) {
    return {
      idKey: checklist.id,
      titleKey: checklist.title,
    };
  }

  Future<bool> delete(List<Checklist> checklists) async {
    final result = await _database.delete(tableName,
        where: '$idKey IN (${checklists.map((e) => e.id).join(',')})');
    return result == 1 ? true : false;
  }

  Future<bool> add(Checklist checklist) async {
    final result = await _database.insert(tableName, _checklistToValues(checklist));
    return result == 1 ? true : false;
  }
}
