import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final VoidCallback onAdd;
  final VoidCallback onMinus;
  final int count;

  const Counter({
    super.key,
    required this.onAdd,
    required this.onMinus,
    required this.count,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.count}",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            IconButton.filled(
              onPressed: widget.count != 0 ? widget.onMinus : null, 
              icon: const Icon(Icons.remove)
            ),
            const SizedBox(height: 8,),
            IconButton.filled(
              onPressed: widget.onAdd, 
              icon: const Icon(Icons.add)
            ),            
          ]
        ),
      ],

    );
  }
}