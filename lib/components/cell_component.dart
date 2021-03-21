import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellComponent extends StatefulWidget {
  final int number;
  final Function onTap;

  CellComponent({@required this.number, this.onTap});

  @override
  State<StatefulWidget> createState() => _CellComponentState();
}

class _CellComponentState extends State<CellComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.amber,
        child: Center(child: Text(widget.number.toString())),
      ),
      onTap: () => widget.onTap(widget.number),
    );
  }
}
