class CalculatorState {
  String output;
  String input;
  double num1;
  String operand;
  bool newNumber;

  CalculatorState({
    this.output = '0',
    this.input = '',
    this.num1 = 0,
    this.operand = '',
    this.newNumber = true,
  });

  CalculatorState copyWith({
    String? output,
    String? input,
    double? num1,
    String? operand,
    bool? newNumber,
  }) {
    return CalculatorState(
      output: output ?? this.output,
      input: input ?? this.input,
      num1: num1 ?? this.num1,
      operand: operand ?? this.operand,
      newNumber: newNumber ?? this.newNumber,
    );
  }
} 