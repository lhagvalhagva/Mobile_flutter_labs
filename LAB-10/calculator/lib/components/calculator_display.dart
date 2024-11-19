import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String output;

  const CalculatorDisplay({
    super.key,
    required this.output,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomRight,
        child: Text(
          output,
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
} 