import 'package:flutter/material.dart';
import 'package:twitched_minesweeper/models/game_interface.dart';
import 'package:twitched_minesweeper/models/game_manager.dart';
import 'package:twitched_minesweeper/models/minesweeper_theme.dart';
import 'package:twitched_minesweeper/widgets/sweeper_tile.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({
    super.key,
    required this.gameInterface,
    required this.tileSize,
  });

  final GameInterface gameInterface;
  final double tileSize;

  @override
  Widget build(BuildContext context) {
    final textSize = tileSize * 3 / 4;
    final gm = gameInterface.gameManager;

    return SizedBox(
      width: (gm.nbCols + 1) * tileSize,
      child: GridView.count(
        crossAxisCount: gm.nbCols + 1,
        children: List.generate(
            gm.nbRows * gm.nbCols + gm.nbRows + gm.nbCols + 1, (index) {
          // We have to construct the grid alongside the name of the
          // rows and cols. So every row and col being 0 is the name, otherwise
          // it is the grid (with its index offset by 1)
          final row = gridRow(index, gm.nbCols + 1);
          final col = gridCol(index, gm.nbCols + 1);

          // Starting tile
          if (row == 0 && col == 0) {
            return SweeperTile(
              gameManager: gm,
              tileIndex: -1,
              tileSize: tileSize,
              textSize: textSize,
            );
          }

          // Header of SweeperTile
          if (row == 0 || col == 0) {
            return Container(
              decoration: BoxDecoration(
                  color: ThemeColor.conceiledContrast,
                  border: Border.all(width: tileSize * 0.02)),
              child: Center(
                  child: Text(
                '${col == 0 ? String.fromCharCode('A'.codeUnits[0] + row - 1) : col}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize * 0.75, fontWeight: FontWeight.bold),
              )),
            );
          }

          final tileIndex = gridIndex(row - 1, col - 1, gm.nbCols);
          return SweeperTile(
            gameManager: gm,
            tileIndex: tileIndex,
            tileSize: tileSize,
            textSize: textSize,
          );
        }, growable: false),
      ),
    );
  }
}
