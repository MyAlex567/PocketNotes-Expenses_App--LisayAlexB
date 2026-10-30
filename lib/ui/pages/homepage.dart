import 'dart:math';

import 'package:flutter/material.dart';
import '../../database/database_helpert.dart';
import '../../model/expenses.dart';
import '../organism/app_barr.dart';
import '../organism/expenses_list.dart';
import '../organism/expense_dialog.dart';

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

  Future<void> _loadExpenses() async{
    final expenses = await _db.getExpenses();
    if(!mounted) return;
    setState(() {
      _expenses = expenses;
      _isloading = false;
    });
  }

  Future<void> _editExpenses(Expenses expense) async{
    final update = await _showExpenseDialog(expense: expense);
    if(update == null) return;
    await _db.updateExpenses(expense);
  }

  Future<Expenses?> _showExpenseDialog({Expenses? expense}){
    return showDialog<Expenses>(
      context: context,
      builder: (context) => ExpenseDialog(expenses: expense,)
    );
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
          ExpensesList(
            expensesList: _expenses, 
            isloading: _isloading, 
            onEdit: onEdit, 
            onDelete: onDelete
          )
        ],
      ),
    );
  }
}