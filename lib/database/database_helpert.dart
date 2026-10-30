import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/expenses.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  // initialize the database on the first run
  Future<Database> get database async{
    _database ??= await _initDatabase();
    return _database!;
  }

  /* 
    Create the Database in the local storage of the phone
    and create the table of expenses  
  */
  Future<Database> _initDatabase() async{
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'expenses_notes.db');

    return openDatabase(path, version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item TEXT NOT NULL,
            amount REAL NOT NULL
          )
        ''');
      }
    );
  }

  /*   
    Insert in the expenses table with 
    a key value pair of item and amount 
  */
  Future<int> insertExpense(Expenses expenses) async{
    final expenseDb = await database;
    return expenseDb.insert('expenses', expenses.toMap());
  }

  /*  
    Get the list of Expenses starting from the newest
  */ 
  Future<List<Expenses>> getExpenses() async{
    final expensesDb = await database;
    final rows = await expensesDb.query('expenses', orderBy: 'id DESC');
    return rows.map(Expenses.fromMap).toList();
  }

  /*  
    Update the specific Expenses record
  */
  Future<int> updateExpenses(Expenses expense) async{
    final expensesDb = await database;
    return expensesDb.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id]
    );
  }

  /*  
    Delete a row from expenses table or a record
  */
  Future<int> deleteExpenses(Expenses expense) async{
    final expensesDb = await database;
    return expensesDb.delete('expenses', where: 'id = ?', whereArgs: [expense.id]);
  }
}