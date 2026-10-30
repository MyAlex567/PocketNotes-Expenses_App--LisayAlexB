import 'dart:math';
import 'package:flutter/material.dart';
import '../../database/database_helpert.dart';
import '../../model/expenses.dart';
import '../organism/app_barr.dart';
import '../organism/expenses_list.dart';
import '../organism/expense_dialog.dart';
import '../organism/delete_dialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _db = DatabaseHelper.instance;

  List<Expenses> _expenses = [];
  bool _isloading = true;

  // For loading the records of expenses
  Future<void> _loadExpenses() async{
    final expenses = await _db.getExpenses();
    if(!mounted) return;
    setState(() {
      _expenses = expenses;
      _isloading = false;
    });
  }

  // Editing an expenses
  Future<void> _editExpenses(Expenses expense) async{
    final update = await _showExpenseDialog(expense: expense);
    if(update == null) return;
    await _db.updateExpenses(update);
    await _loadExpenses();
  }

  // Deleting an expenses
  Future<void> _deleteExpenses(Expenses expense) async{
    // ask first for confirmation
    final confirmation = await showDialog<bool>(
      context: context, 
      builder: (context) => DeleteExpenseDialog(expense: expense) ,
    );
    if(confirmation != true) return;

    await _db.deleteExpenses(expense);
    // Load again or fetch the updated current expenses record
    await _loadExpenses();
    if(!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted "${expense.item}"')),
    );    
  }

  Future<void> _addExpenses() async{
    final expense = await _showExpenseDialog();
    if(expense == null) return;
    await _db.insertExpense(expense);
    await _loadExpenses();
  }

  // To show the same Dialog that update and add uses
  Future<Expenses?> _showExpenseDialog({Expenses? expense}){
    return showDialog<Expenses>(
      context: context,
      builder: (context) => ExpenseDialog(expenses: expense,)
    );
  }

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        text: "Expenses App", 
        isDarkMode: widget.isDarkMode, 
        onThemeChanged: widget.onThemeChanged
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(
              expensesList: _expenses, 
              isloading: _isloading, 
              onEdit: _editExpenses, 
              onDelete: _deleteExpenses,
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addExpenses,
        icon: const Icon(Icons.add),
        label: const Text("Add expense"),
      ),
    );
  }
}