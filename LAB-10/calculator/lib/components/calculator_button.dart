import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final bool isOperator;
  final bool isEqual;
  final bool isClear;
  final bool isBackspace;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.text,
    this.isOperator = false,
    this.isEqual = false,
    this.isClear = false,
    this.isBackspace = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOperator 
              ? Colors.orange 
              : isEqual 
                  ? Colors.blue 
                  : isClear || isBackspace
                      ? Colors.red 
                      : Colors.grey[200],
          foregroundColor: isOperator || isEqual || isClear || isBackspace 
              ? Colors.white 
              : Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 