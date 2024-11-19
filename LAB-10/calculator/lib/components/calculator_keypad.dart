import 'package:flutter/material.dart';
import 'calculator_button.dart';

class CalculatorKeypad extends StatelessWidget {
  final Function(String) onNumberPressed;
  final Function(String) onOperatorPressed;
  final VoidCallback onEqualPressed;
  final VoidCallback onClearPressed;
  final VoidCallback onBackspacePressed;

  const CalculatorKeypad({
    super.key,
    required this.onNumberPressed,
    required this.onOperatorPressed,
    required this.onEqualPressed,
    required this.onClearPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        CalculatorButton(
          text: 'C',
          isClear: true,
          onPressed: onClearPressed,
        ),
        CalculatorButton(
          text: '%',
          isOperator: true,
          onPressed: () => onOperatorPressed('%'),
        ),
        CalculatorButton(
          text: '⌫',
          isBackspace: true,
          onPressed: onBackspacePressed,
        ),
        CalculatorButton(
          text: '÷',
          isOperator: true,
          onPressed: () => onOperatorPressed('÷'),
        ),
        CalculatorButton(text: '7', onPressed: () => onNumberPressed('7')),
        CalculatorButton(text: '8', onPressed: () => onNumberPressed('8')),
        CalculatorButton(text: '9', onPressed: () => onNumberPressed('9')),
        CalculatorButton(
          text: '×',
          isOperator: true,
          onPressed: () => onOperatorPressed('×'),
        ),
        CalculatorButton(text: '4', onPressed: () => onNumberPressed('4')),
        CalculatorButton(text: '5', onPressed: () => onNumberPressed('5')),
        CalculatorButton(text: '6', onPressed: () => onNumberPressed('6')),
        CalculatorButton(
          text: '-',
          isOperator: true,
          onPressed: () => onOperatorPressed('-'),
        ),
        CalculatorButton(text: '1', onPressed: () => onNumberPressed('1')),
        CalculatorButton(text: '2', onPressed: () => onNumberPressed('2')),
        CalculatorButton(text: '3', onPressed: () => onNumberPressed('3')),
        CalculatorButton(
          text: '+',
          isOperator: true,
          onPressed: () => onOperatorPressed('+'),
        ),
        CalculatorButton(text: '0', onPressed: () => onNumberPressed('0')),
        CalculatorButton(text: '00', onPressed: () => onNumberPressed('00')),
        CalculatorButton(text: '.', onPressed: () => onNumberPressed('.')),
        CalculatorButton(
          text: '=',
          isEqual: true,
          onPressed: onEqualPressed,
        ),
      ],
    );
  }
} 