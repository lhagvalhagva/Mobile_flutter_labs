import 'dart:math';
import 'package:flutter/material.dart';
import 'player_section.dart';
import 'dice_section.dart';

class ShooOrhilt extends StatefulWidget {
  const ShooOrhilt({super.key});

  @override
  State<ShooOrhilt> createState() => _ShooOrhiltState();
}

class _ShooOrhiltState extends State<ShooOrhilt> {
  final randomizer = Random();
  var currentDiceRoll = 2;
  int? player1Guess;
  int? player2Guess;
  bool canRoll = false;

  void setPlayerGuess(int playerNumber, int guess) {
    setState(() {
      if (playerNumber == 1) {
        player1Guess = guess;
      } else {
        player2Guess = guess;
      }
      canRoll = player1Guess != null && player2Guess != null;
    });
  }

  void rollDice(BuildContext context) {
    if (!canRoll) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Тоглогчид эхлээд тоогоо сонгоно уу!')),
      );
      return;
    }

    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
      
      if (currentDiceRoll == player1Guess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Тоглогч 1 яллаа!')),
        );
      } else if (currentDiceRoll == player2Guess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Тоглогч 2 яллаа!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Хэн ч таасангүй!')),
        );
      }
      
      player1Guess = null;
      player2Guess = null;
      canRoll = false;
    });
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PlayerSection(
              playerNumber: 1,
              playerGuess: player1Guess,
              onGuess: setPlayerGuess,
              isRotated: false,
            ),
            DiceSection(
              currentDiceRoll: currentDiceRoll,
              onRoll: () => rollDice(context),
            ),
            PlayerSection(
              playerNumber: 2,
              playerGuess: player2Guess,
              onGuess: setPlayerGuess,
              isRotated: true,
            ),
          ],
        ),
      ),
    );
  }
} 