import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Expense.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();

  static Database? _database; Future<Database?> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ExpenseDB2.db");
    return await openDatabase(
        path, version: 1, onOpen:(db){}, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Expense (""id INTEGER PRIMARY KEY," "amount REAL," "date TEXT," "category TEXT"")");
      await db.execute("INSERT INTO Expense ('id', 'amount', 'date', 'category')values (?, ?, ?, ?)",
          [1, 1000, '2019-04-01 10:00:00', "Food"]
      );
      }
    );
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    List<Map> results = await db!.query(
        "Planet", columns: Expense.columns, orderBy: "id ASC"
    );
    List<Expense> expenses = [];
    var result;
    for (result in results){
      Expense expense = Expense.fromMap(result);
      expenses.add(expense);
    };
    return expenses;
  }
  Future<Expense?> getExpenseById(int id) async {
    final db = await database;
    var result = await db!.query("Expense", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Expense.fromMap(result.first) : null;
  }
  Future<double> getTotalExpense() async {
    final db = await database;
    List<Map> list = await db!.rawQuery(
        "Select SUM(amount) as amount from expense"
    );
    return list.isNotEmpty ? list[0]["amount"] : null;
  }
  Future<Expense> insert(Expense expense) async {
    final db = await database;
    var maxIdResult = await db!.rawQuery(
        "SELECT MAX(id)+1 as last_inserted_id FROM Expense"
    );
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Expense (id, amount, date, category)"
            " VALUES (?, ?, ?, ?)", [
      id, expense.amount, expense.date.toString(), expense.category
    ]
    );
    return Expense(int.parse(id.toString()), expense.amount, expense.date, expense.category);
  }
  update(Expense product) async {
    final db = await database;
    var result = await db!.update(
        "Expense", product.toMap(), where: "id = ?", whereArgs: [product.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db!.delete("Expense", where: "id = ?", whereArgs: [id]);
  }
}
