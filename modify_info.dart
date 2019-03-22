import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModifyInfoPage extends StatefulWidget {
  const ModifyInfoPage({
    Key key,
    @required this.title,
    @required this.text,
    this.maxLenght,
  }) : super(key: key);
  final String title;
  final String text;
  final int maxLenght;

  @override
  _ModifyInfoPageState createState() => _ModifyInfoPageState();
}

class _ModifyInfoPageState extends State<ModifyInfoPage> {
  TextEditingController _controller;
  FocusNode _focusNode = new FocusNode();
  String inputText;
  bool visible;
  int inputMaxLines = 20;
  @override
  void initState() {
    super.initState();
    inputText = widget.text;
    if (inputText != null || inputText.length > 0) {
      visible = false;
    }
    _controller = TextEditingController.fromValue(TextEditingValue(
        text: inputText, // 设置内容
        // 保持光标在最后
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: inputText.length))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, inputText);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '保存',
                      style: TextStyle(color: Color(0xff276227)),
                    )),
              ),
            ],
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xff54C52D)))),
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: 200),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        onSubmitted: (value) {
                          value += "\n";
                        },
                        focusNode: _focusNode,
                        maxLines: null,
                        onChanged: (text) {
                          setState(() {
                            inputText = text;
                            if (_controller.text.length > 0) {
                              visible = false;
                            } else {
                              visible = true;
                            }
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(widget.maxLenght)
                        ],
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        cursorColor: Colors.blue,
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              right: 20.0, left: 10.0, bottom: 5.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: visible,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.clear();
                      visible = true;
                    });
                  },
                  child: Image.asset(
                    "assets/images/close.png",
                    width: 20,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
