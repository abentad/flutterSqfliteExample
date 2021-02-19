import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqfliteExample/amount_model.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._instance();
  static Database _db;

  DbHelper._instance();

  String amountTable = "amount_table";
  String colId = "id";
  String colDate = "date";
  String colAmount = "amount";
  //amount_table
  // | id  |  date  |  amoount  |
  // | 0   | 2,2,10 |    200    |

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, '$amountTable.db');
    final amountDb = await openDatabase(path, version: 1, onCreate: createDb);
    return amountDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $amountTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDate TEXT, $colAmount INTEGER)");
  }

  //returns all of our row in our table as list of maps
  Future<List<Map<String, dynamic>>> getAmountMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(amountTable);
    return result;
  }

  Future<List<AmountModel>> getAmountList() async {
    final List<Map<String, dynamic>> amountMapList = await getAmountMapList();
    final List<AmountModel> amountList = [];
    amountMapList.forEach((element) {
      amountList.add(AmountModel.fromMap(element));
    });
    return amountList;
  }

  Future<int> insertAmount(AmountModel amount) async {
    Database db = await this.db;
    final int result = await db.insert(amountTable, amount.toMap());
    return result;
  }

  Future<int> updateAmount(AmountModel amount) async {
    Database db = await this.db;
    final int result = await db.update(
      amountTable,
      amount.toMap(),
      where: "$colId = ?",
      whereArgs: [amount.id],
    );
    return result;
  }

  Future<int> deleteAmount(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      amountTable,
      where: "$colId = ?",
      whereArgs: [id],
    );
    return result;
  }
}
