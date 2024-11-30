import 'package:flutter/material.dart';
import '../components/calculator_display.dart';
import '../components/calculator_keypad.dart';
import '../models/calculator_state.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late CalculatorState _state;

  @override
  void initState() {
    super.initState();
    _state = CalculatorState();
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (number == '.' && _state.output.contains('.')) {
        return;
      }
      
      if (_state.newNumber) {
        _state = _state.copyWith(
          output: number,
          newNumber: false,
        );
      } else {
        if (number == '00' && _state.output == '0') {
          return;
        }
        _state = _state.copyWith(output: _state.output + number);
      }
    });
  }

    void _onOperatorPressed(String operand) {
        setState(() {
            _state = _state.copyWith(
            num1: double.parse(_state.output), // Эхний тоог хадгалах
            operand: operand,                  // Үйлдлийг хадгалах
            newNumber: true,                   // Дараагийн тоо шинэ байна
            );
        });
    }

  void _onEqualPressed() {
    setState(() {
      double num2 = double.parse(_state.output);
      double result = 0;

      switch (_state.operand) {
        case '+':
          result = _state.num1 + num2;
          break;
        case '-':
          result = _state.num1 - num2;
          break;
        case '×':
          result = _state.num1 * num2;
          break;
        case '÷':
          result = _state.num1 / num2;
          break;
        case '%':
          result = _state.num1 % num2;
          break;
      }

      _state = _state.copyWith(
        output: result.toString(),
        newNumber: true,
      );
    });
  }

  void _onClearPressed() {
    setState(() {
      _state = CalculatorState();
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_state.output.length > 1) {
        _state = _state.copyWith(
          output: _state.output.substring(0, _state.output.length - 1),
        );
      } else {
        _state = _state.copyWith(
          output: '0',
          newNumber: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тооны машин'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          CalculatorDisplay(output: _state.output),
          CalculatorKeypad(
            onNumberPressed: _onNumberPressed,
            onOperatorPressed: _onOperatorPressed,
            onEqualPressed: _onEqualPressed,
            onClearPressed: _onClearPressed,
            onBackspacePressed: _onBackspacePressed,
          ),
        ],
      ),
    );
  }
} 