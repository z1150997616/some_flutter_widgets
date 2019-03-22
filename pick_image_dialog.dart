import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageDialog extends Dialog {

  @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){
              Navigator.of(context).pop("");
            },
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: buildDialog(context),
          ),
        ),
      );
    }

    Widget buildDialog(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 30,left: 30),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(bottom: BorderSide(width: 1.0,color: Colors.blue))
              ),
              child: Text("设置头像",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0,color: Colors.blue,fontWeight: FontWeight.w600),),
            ),
            GestureDetector(
              onTap: (){
                getImagePicker(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                border: Border(bottom: BorderSide(width: 1.0,color: Color(0xffdddddd)))
              ),
                padding: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              height: 60,
                child: Text("拍摄",style: TextStyle(fontSize: 16.0,color: Colors.black),),
              ),
            ),
            GestureDetector(
              onTap: (){
                getImage(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              height: 60,
                child: Text("从手机相册选择",style: TextStyle(fontSize: 16.0,color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.of(context).pop(image.uri.path);
  }

  Future getImagePicker(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.of(context).pop(image.uri.path);
  }
}