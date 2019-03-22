import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatefulWidget {
  const AvatarImage({ 
    Key key,
    this.avatar,
    this.gender,
    this.width,
    this.height,
  }) : super(key: key);
  final String avatar;
  final int gender;//默认头像 0未知（无性别图片） 1女性默认头像 2男性默认头像
  final double width;
  final double height;

  _AvatarImageState createState() => new _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {

  int curCount = 0; 
  @override
  Widget build(BuildContext context) {
    String defalue = "assets/images/avatar_default.png";
    if (widget.gender != null && widget.gender == 1) {
      defalue = "assets/images/avatar_female_default.png";
    }else if (widget.gender != null && widget.gender == 2) {
      defalue = "assets/images/avatar_male_default.png";
    }

    if (widget.avatar != null && widget.avatar.length > 0) {
      if (widget.avatar.indexOf("https") == 0 || widget.avatar.indexOf("http") == 0){
        return CachedNetworkImage(
        imageUrl: widget.avatar,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.width,

        placeholder: Image.asset(
          defalue,
          fit: BoxFit.cover,
        width: widget.width,
        height: widget.width,
        ),
        errorWidget: Image.asset(
          defalue,
          fit: BoxFit.cover,
        width: widget.width,
        height: widget.width,
        ),
      );
      }
      
    }
    return Image.asset(
          defalue,
          fit: BoxFit.cover,
        width: widget.width,
        height: widget.width,
        );
  }
}