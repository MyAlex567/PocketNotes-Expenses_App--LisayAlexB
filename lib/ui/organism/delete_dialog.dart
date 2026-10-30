import 'package:flutter/material.dart';
import '../../model/expenses.dart';

class DeleteExpenseDialog extends StatelessWidget {
  final Expenses expense;

  const DeleteExpenseDialog({
    super.key, 
    required this.expense
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete expense?'),
      content: Text('"${expense.item}" will be removed permanently.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
