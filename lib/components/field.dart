import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'cell_component.dart';

class Field extends StatefulWidget {
  final int fieldSize;
  final Function back;

  Field({@required this.fieldSize, @required this.back});

  @override
  State<StatefulWidget> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  List<List<int>> cells;
  List<int> numbers;
  List<int> sortedNumbers;
  bool isGameOver;

  @override
  void initState() {
    super.initState();
    isGameOver = false;
    sortedNumbers = <int>[];
    _initFieldCells(size: widget.fieldSize);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isGameOver)
          Container(
            child: Text(
              'Победа!!!',
              style: TextStyle(fontSize: 25, color: Colors.indigo),
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: widget.back,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo)),
                child: Text('Назад'),
              ),
            ],
          ),
        ),
        Container(
          height: 75.0 * widget.fieldSize,
          width: 75.0 * widget.fieldSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.indigo, spreadRadius: 3),
            ],
          ),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.fieldSize,
              ),
              itemCount: widget.fieldSize * widget.fieldSize,
              itemBuilder: (BuildContext context, int index) {
                return numbers[index] != 0
                    ? CellComponent(
                        number: numbers[index],
                        onTap: _onCellTap,
                      )
                    : Container();
              }),
        ),
      ],
    );
  }

  void _initFieldCells({@required int size}) {
    cells = <List<int>>[];
    numbers = <int>[];
    var rng = new Random();
    for (int i = 0; i < size; i++) {
      cells.add(<int>[]);
      for (int j = 0; j < size; j++) {
        while (true) {
          if (numbers.length == size * size - 1) break;
          int number = rng.nextInt(size * size - 1) + 1;
          if (!numbers.contains(number)) {
            numbers.add(number);
            cells[i].add(number);
            break;
          }
        }
      }
    }
    cells[size - 1].add(0);
    sortedNumbers
      ..addAll(numbers)
      ..sort();
    numbers.add(0);
  }

  void _onCellTap(int number) {
    if (!isGameOver) {
      for (int i = 0; i < widget.fieldSize; i++) {
        for (int j = 0; j < widget.fieldSize; j++) {
          if (cells[i][j] == number) {
            _moveCellIfPossible(i, j, number: number);
            setState(() {});
            return;
          }
        }
      }
    }
  }

  void _moveCellIfPossible(int i, j, {int number}) {
    int iStart = i - 1 >= 0 ? i - 1 : i;
    int iEnd = i + 1 < widget.fieldSize ? i + 1 : i;
    int jStart = j - 1 >= 0 ? j - 1 : j;
    int jEnd = j + 1 < widget.fieldSize ? j + 1 : j;

    for (int k = iStart; k <= iEnd; k++) {
      for (int f = jStart; f <= jEnd; f++) {
        if ((i == k || j == f) && cells[k][f] == 0) {
          cells[k][f] = number;
          cells[i][j] = 0;
          _copyFieldToList();
          return;
        }
      }
    }
  }

  void _copyFieldToList() {
    numbers.clear();
    for (int i = 0; i < widget.fieldSize; i++) {
      for (int j = 0; j < widget.fieldSize; j++) {
        numbers.add(cells[i][j]);
      }
    }
    _checkGameResult();
  }

  void _checkGameResult() {
    if (IterableEquality()
        .equals(numbers.take(numbers.length - 1), sortedNumbers)) {
      isGameOver = true;
    }
  }
}
