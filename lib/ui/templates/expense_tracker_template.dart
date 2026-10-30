import 'package:flutter/material.dart';


class ExpenseTrackerTemplate extends StatelessWidget {
  final PreferredSizeWidget appbar;
  final Widget expensesList;
  final Widget floatingActionButton;

  const ExpenseTrackerTemplate({
    super.key,
    required this.appbar,
    required this.expensesList,
    required this.floatingActionButton 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          Expanded(
            child: expensesList
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}