class Expenses {
  final int? id;
  final String item;
  final double amount;

  const Expenses({
    this.id,
    required this.item,
    required this.amount
  });

  Map<String, dynamic> toMap(){
    return {
      if (id != null) 'id': id,
      'item': item,
      'amount': amount
    };
  }

  factory Expenses.fromMap(Map<String, Object?> map){
    return Expenses(
      id: map['id'] as int?,
      item: map['item'] as String, 
      amount: map['amount'] as double,
    );
  }

  Expenses copyWith({int? id, String? item, double? amount}){
    return Expenses(
      id: id ?? this.id,
      item: item ?? this.item, 
      amount: amount ?? this.amount,
    );
  }
}