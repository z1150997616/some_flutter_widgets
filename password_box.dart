import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordBox extends StatefulWidget {
  const PasswordBox({
    Key key,
    this.maxLength,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);
  final int maxLength;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  _PasswordBoxState createState() => new _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  int _inputTextCount = 0;
  bool _isGlint = true;
  Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(new Duration(milliseconds: 500), (timer) {
      setState(() {
       _isGlint = !_isGlint; 
      });
      });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Stack(
      children: <Widget>[
        new GridView.count(
          crossAxisCount: widget.maxLength,
          children: new List.generate(widget.maxLength, (index) {
            return new Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Color(0xffcccccc)),
                        ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4,top: 10,bottom: 10),
                            child: Offstage(
                              offstage: _inputTextCount != index || _isGlint,
                              child: Container(
                                width: 2,color: Colors.blue,
                                ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right:4.0),
                              child: Center(
                                child: Container(
                                  height: 12.0,
                                  width: 12.0,
                                  decoration: BoxDecoration(
                                  color: _inputTextCount > index
                                      ? Colors.black
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                )),
              ],
            );
          }),
        ),
        Center(
          child: TextField(
            decoration: InputDecoration(border: InputBorder.none),
            obscureText: true,
            keyboardType: TextInputType.number,
            focusNode: widget.focusNode,
            style: TextStyle(color: Colors.transparent),
            cursorColor: Colors.transparent,
            onChanged: (text) {
              if (this.mounted) {
                setState(() {
                  _inputTextCount = text.length;
                });
              }
              widget.onChanged(text);
            },
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.maxLength)
            ],
          ),
        ),
      ],
    ));
  }
}
