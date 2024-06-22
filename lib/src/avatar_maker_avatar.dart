import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import './avatar_maker_controller.dart';

/// This widget renders the avatar of the user on screen
///
/// Accepts a [radius] which defaults to 75.0
/// and a [backgroundColor] which defaults to blueAccent
///
/// Advice the users to set up their avatar first to avoid unexpected issues.
class AvatarMakerAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  AvatarMakerAvatar({Key? key, this.radius = 75.0, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null)
      CircleAvatar(radius: radius, child: buildGetX());
    return CircleAvatar(
        radius: radius, backgroundColor: backgroundColor, child: buildGetX());
  }

  GetX<AvatarMakerController> buildGetX() {
    return GetX<AvatarMakerController>(
        init: AvatarMakerController(),
        autoRemove: false,
        builder: (snapshot) {
          if (snapshot.avatarmaker.value.isEmpty) {
            return CupertinoActivityIndicator();
          }
          return SvgPicture.string(
            snapshot.avatarmaker.value,
            height: radius * 1.6,
            semanticsLabel: "Your avatar",
            placeholderBuilder: (context) => Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
  }
}
