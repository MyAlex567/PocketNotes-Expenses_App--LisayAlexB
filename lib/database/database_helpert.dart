import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
  Future<int> insertExpense(String item, double amount) async{
    final expenseDb = await database;
    return expenseDb.insert('expenses', {
      'item': item,
      'amount': amount
    });
  }

  /*  
    Get the list of Expenses starting from the newest
  */ 
  Future<List<Map<String, dynamic>>> getExpenses() async{
    final expensesDb = await database;
    return expensesDb.query('expenses', orderBy: 'id DESC');
  }

  /*  
    Update the specific Expenses record
  */
  Future<int> updateExpenses(int id, String item, double amount) async{
    final expensesDb = await database;
    return expensesDb.update('expenses',
      {
        'item': item,
        'amount': amount
      },
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  /*  
    Delete a row from expenses table or a record
  */
  Future<int> deleteExpenses(int id) async{
    final expensesDb = await database;
    return expensesDb.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}