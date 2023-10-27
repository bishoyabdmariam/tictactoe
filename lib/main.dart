import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ohTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

  void tapped(int index) {
    setState(() {
      if (displayXO[index] == "") {
        if (ohTurn) {
          displayXO[index] = "o"; // Update ohPositions
        } else {
          displayXO[index] = "x"; // Update exPositions
        }
        ohTurn = !ohTurn;
      }
    });
    checkWinner();

    if (!(displayXO.contains(""))) {
      showDrawDialog();
    }
  }

  void checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[1] == displayXO[2] &&
        displayXO[0] != "") {
      showWinDialog(displayXO[0]);
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[4] == displayXO[5] &&
        displayXO[3] != "") {
      showWinDialog(displayXO[3]);
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[7] == displayXO[8] &&
        displayXO[6] != "") {
      showWinDialog(displayXO[6]);
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[3] == displayXO[6] &&
        displayXO[0] != "") {
      showWinDialog(displayXO[0]);
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[4] == displayXO[7] &&
        displayXO[1] != "") {
      showWinDialog(displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[5] == displayXO[8] &&
        displayXO[2] != "") {
      showWinDialog(displayXO[2]);
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[4] == displayXO[8] &&
        displayXO[0] != "") {
      showWinDialog(displayXO[0]);
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[2] != "") {
      showWinDialog(displayXO[2]);
    }
    // Define the winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];
  }

  int xScore = 0;
  int oScore = 0;

  void showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is : $winner"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    displayXO = ['', '', '', '', '', '', '', '', ''];
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Play Again",
                ),
              ),
            ],
          );
        });
    if (winner == "o") {
      setState(() {
        oScore++;
        ohTurn = false;
      });
    } else {
      setState(() {
        xScore++;
        ohTurn = true;
      });
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("There is no Winner"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    displayXO = ['', '', '', '', '', '', '', '', ''];
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Play Again",
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          SafeArea(
            child: Text(
              ohTurn ? "This is O Turn !" : "This is X Turn !",
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      "Player O",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      oScore.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      "Player X",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      xScore.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
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
