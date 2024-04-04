import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(SnakeAndLadderApp());
}

class SnakeAndLadderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake and Ladder',
      home: Scaffold(
        appBar: AppBar(title: Text('Snake and Ladder')),
        body: SnakeAndLadderGame(),
      ),
    );
  }
}

class SnakeAndLadderGame extends StatefulWidget {
  @override
  _SnakeAndLadderGameState createState() => _SnakeAndLadderGameState();
}

class _SnakeAndLadderGameState extends State<SnakeAndLadderGame> {
  int currentPlayer = 0;
  int diceValue = 1;
  int currentPosition = 0;
  final int finalSquare = 100;
  List<int> playerPositions = [0, 0, 0, 0]; // Positions of each player
  final Random random = Random();

  void rollDice() {
    setState(() {
      diceValue = random.nextInt(6) + 1;
      movePlayer(diceValue);
    });
  }

  void movePlayer(int steps) {
    setState(() {
      int nextPosition = currentPosition + steps;
      if (nextPosition <= finalSquare) {
        currentPosition = nextPosition;
        // Check for snakes and ladders
        switch (currentPosition) {
        // Add logic for snakes and ladders
          default:
          // No snake or ladder, move as usual
            playerPositions[currentPlayer] = currentPosition;
            break;
        }
        // Switch to next player
        currentPlayer = (currentPlayer + 1) % 4;
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Player ${currentPlayer + 1}\'s turn'),
          SizedBox(height: 20),
          Text('Dice value: $diceValue'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: rollDice,
            child: Text('Roll Dice'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
              ),
              itemCount: finalSquare,
              itemBuilder: (context, index) {
                int row = index ~/ 10; // Integer division to get the row number
                int col = index % 10; // Remainder to get the column number
                int position = (row % 2 == 0) ? index + 1 : (row + 1) * 10 - col;
                bool isOccupied = playerPositions.contains(position);
                return GridTile(
                  child: Container(
                    color: isOccupied ? Colors.blue : Colors.white,
                    child: Center(
                      child: Text(
                        position.toString(),
                        style: TextStyle(
                          color: isOccupied ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
