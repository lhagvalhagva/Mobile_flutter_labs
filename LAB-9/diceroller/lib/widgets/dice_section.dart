import 'package:flutter/material.dart';

class DiceSection extends StatelessWidget {
  final int currentDiceRoll;
  final VoidCallback onRoll;

  const DiceSection({
    super.key,
    required this.currentDiceRoll,
    required this.onRoll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              'assets/images/dice-$currentDiceRoll.png',
              width: 150,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRoll,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Шоог орхих',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 