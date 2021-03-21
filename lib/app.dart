import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/game.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Game(),
    );
  }
}
