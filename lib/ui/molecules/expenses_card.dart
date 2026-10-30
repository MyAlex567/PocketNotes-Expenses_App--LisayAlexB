import 'package:flutter/material.dart';
import '../../model/expenses.dart';

class ExpensesCard extends StatelessWidget {
  final Expenses expenses;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpensesCard({
    super.key,
    required this.expenses,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.payments_outlined),),
        title: Text(expenses.item),
        subtitle: Text("₱ ${expenses.amount.toStringAsFixed(2)}"),
        onTap: onEdit,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Edit', 
              onPressed: onEdit, 
              icon: Icon(Icons.edit_outlined),
              color: Colors.blue,
            ),
            IconButton(
              tooltip: 'Delete', 
              onPressed: onDelete, 
              icon: Icon(Icons.delete_outline),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      )
    );
  }
}