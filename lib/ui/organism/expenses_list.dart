import 'package:flutter/material.dart';
import '../../model/expenses.dart';
import '../molecules/text_message.dart';
import '../molecules/expenses_card.dart'; 

class ExpensesList extends StatelessWidget {
  final List<Expenses> expensesList;
  final bool isloading;
  final ValueChanged<Expenses> onEdit;
  final ValueChanged<Expenses> onDelete;  

  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.isloading,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if(isloading){
      return const Center(child: CircularProgressIndicator());
    }

    return expensesList.isNotEmpty ? 
      ListView.builder(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 88),
        itemCount: expensesList.length,
        itemBuilder: (context, index){
          final expenses = expensesList[index];
          return ExpensesCard(
            expenses: expenses, 
            onEdit: () => onEdit(expenses), 
            onDelete: () => onDelete(expenses)
          );
        },
      ) 
      : const TextMessage(
        icon: Icons.receipt_long, 
        text: 'No expenses yet.\nTap "Add expense" to add your first one.',
      );
  }
}