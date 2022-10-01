import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

AppBar simpleAppBar({
  BuildContext? context,
  String? title,
}) {
  return AppBar(
    elevation: 3,
    leadingWidth: 30,
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: () => Navigator.pop(context!),
          icon: Image.asset(
            Assets.imagesArrowBack,
            height: 15.87,
          ),
        ),
      ],
    ),
    title: MyText(
      text: '$title',
      size: 16,
    ),
  );
}