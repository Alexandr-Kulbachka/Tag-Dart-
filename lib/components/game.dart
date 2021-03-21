import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectdart/components/field.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<Game> {
  Map<String, int> fieldSizes;
  String selectedSize;
  bool isGameStarted;

  @override
  void initState() {
    super.initState();
    isGameStarted = false;
    fieldSizes = {'3x3': 3, '4x4': 4, '5x5': 5, '6x6': 6};
    selectedSize = fieldSizes.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.indigo,
              centerTitle: true,
              title: Text(
                'Пятнашки',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: isGameStarted
                    ? Field(
                        fieldSize: fieldSizes[selectedSize],
                        back: () {
                          setState(() {
                            isGameStarted = false;
                          });
                        })
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Выберите размер поля: '),
                              DropdownButton<String>(
                                items: fieldSizes.keys.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (selectedValue) {
                                  setState(() {
                                    selectedSize = selectedValue;
                                  });
                                },
                                value: selectedSize,
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isGameStarted = true;
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.indigo)),
                            child: Text('Начать игру'),
                          ),
                        ],
                      ),
              ),
            )));
  }
}
