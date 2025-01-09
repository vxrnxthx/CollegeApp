import 'package:flutter/material.dart';

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  static const int maxAttempts = 6;
  final List<String> wordList = ['flutter', 'hangman', 'dart', 'neon'];
  late String selectedWord;
  late List<String> guessedLetters;
  late int remainingAttempts;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      selectedWord = (wordList..shuffle()).first;
      guessedLetters = [];
      remainingAttempts = maxAttempts;
    });
  }

  void guessLetter(String letter) {
    setState(() {
      if (selectedWord.contains(letter)) {
        guessedLetters.add(letter);
      } else {
        remainingAttempts--;
      }
    });
  }

  String getDisplayedWord() {
    return selectedWord
        .split('')
        .map((letter) => guessedLetters.contains(letter) ? letter : '_')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.purple[300]!, Colors.deepPurple[400]!],
          ).createShader(bounds),
          child: Text(
            "Can you save the dying man?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: CustomPaint(
              size: Size(120, 160), // Slightly smaller stick figure
              painter: NeonHangmanPainter(maxAttempts - remainingAttempts),
            ),
          ),
          Text(
            getDisplayedWord(),
            style: TextStyle(
              fontSize: 32,
              letterSpacing: 4,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.purple[400]!,
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          Text(
            "Attempts Remaining: $remainingAttempts",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.purple[400]!,
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 10,
              children: 'abcdefghijklmnopqrstuvwxyz'
                  .split('')
                  .map((letter) => GestureDetector(
                onTap: guessedLetters.contains(letter) ||
                    remainingAttempts == 0
                    ? null
                    : () => guessLetter(letter),
                child: Container(
                  width: 50,  // Fixed width for square buttons
                  height: 50, // Fixed height for square buttons
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple[400]!.withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.purple[400]!,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(4), // Adjust padding for smaller buttons
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.purple[300]!,
                          Colors.deepPurple[300]!,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        letter.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12, // Adjust font size to fit the smaller buttons
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.purple[300]!,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          if (remainingAttempts == 0 ||
              getDisplayedWord().replaceAll(' ', '') == selectedWord)
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.purple[400]!, width: 2),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.purple[300]!, Colors.deepPurple[300]!],
                ).createShader(bounds),
                child: Text(
                  "Play Again",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NeonHangmanPainter extends CustomPainter {
  final int incorrectGuesses;

  NeonHangmanPainter(this.incorrectGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple[400]!
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 2); // Sharper glow effect

    // Base
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.9),
      Offset(size.width * 0.8, size.height * 0.9),
      paint,
    );

    // Vertical pole
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.5, size.height * 0.9),
      paint,
    );

    // Horizontal beam
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.1),
      paint,
    );

    // Rope
    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.2),
      paint,
    );

    // Stick figure parts
    if (incorrectGuesses > 0) {
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.3),
        size.width * 0.08,
        paint,
      );
    }
    if (incorrectGuesses > 1) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.35),
        Offset(size.width * 0.8, size.height * 0.55),
        paint,
      );
    }
    if (incorrectGuesses > 2) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.4),
        Offset(size.width * 0.75, size.height * 0.45),
        paint,
      );
    }
    if (incorrectGuesses > 3) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.4),
        Offset(size.width * 0.85, size.height * 0.45),
        paint,
      );
    }
    if (incorrectGuesses > 4) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.55),
        Offset(size.width * 0.75, size.height * 0.65),
        paint,
      );
    }
    if (incorrectGuesses > 5) {
      canvas.drawLine(
        Offset(size.width * 0.8, size.height * 0.55),
        Offset(size.width * 0.85, size.height * 0.65),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
