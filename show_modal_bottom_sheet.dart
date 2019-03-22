import 'package:flutter/material.dart';


class ModalBottomSheet extends StatelessWidget {
    const ModalBottomSheet({ 
    Key key,
    @required this.message
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        height: 60.0,
        child: Center(
            child: Text(
          message,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        )));
  }
}
