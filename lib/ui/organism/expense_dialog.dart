import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/expenses.dart';

class ExpenseDialog extends StatefulWidget {
  final Expenses? expenses;

  const ExpenseDialog({
    super.key,
    this.expenses,
  });

  @override
  State<ExpenseDialog> createState() => _ExpenseDialogState();
} 

class _ExpenseDialogState extends State<ExpenseDialog> {
  final _formkey = GlobalKey<FormState>();
  late final _itemCtrl = TextEditingController(text: widget.expenses?.item ?? '');
  late final _amountCtrl = TextEditingController(text: widget.expenses?.amount.toStringAsFixed(2) ?? '');

  bool get _isEditing => widget.expenses != null;

  @override
  void dispose() {
    _itemCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  double? _parseAmount(String text){
    final value = double.tryParse(text.trim());
    if(value == null || !value.isFinite) return null;
    return value;
  }

  void _save() {
    if (!_formkey.currentState!.validate()) return;
    final amount = _parseAmount(_amountCtrl.text);
    if (amount == null) return;

    Navigator.pop(
      context,
      Expenses(
        id: widget.expenses?.id,
        item: _itemCtrl.text.trim(),
        amount: amount,
      ),
    );
  }  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? "Edit Expense" : "Add Expense"),
      content: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _itemCtrl,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Item",
                hintText: 'e.g Launch - Your Name'
              ),
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter an item' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: 'e.g. 85.50',                
              ),
              validator: (value){
                final amount = _parseAmount(value ?? '');
                if (amount == null) return 'Enter a valid number, e.g. 85.50';
                if (amount <= 0) return 'Amount must be greater than 0';
                return null;                
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(_isEditing ? 'Save' : 'Add'),
        ),
      ],      
    );
  }
}