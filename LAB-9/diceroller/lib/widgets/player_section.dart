import 'package:flutter/material.dart';

class PlayerSection extends StatelessWidget {
  final int playerNumber;
  final int? playerGuess;
  final Function(int, int) onGuess;
  final bool isRotated;

  const PlayerSection({
    super.key,
    required this.playerNumber,
    required this.playerGuess,
    required this.onGuess,
    required this.isRotated,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Text(
          'Тоглогч $playerNumber',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 45,
              height: 45,
              child: ElevatedButton(
                onPressed: () => onGuess(playerNumber, index + 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      playerGuess == index + 1 ? Colors.green : Colors.white,
                  foregroundColor:
                      playerGuess == index + 1 ? Colors.white : Colors.black,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (isRotated) {
      content = Transform.rotate(
        angle: 3.141592,
        child: content,
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: content,
    );
  }
} 