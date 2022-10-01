import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar transparentAppBar({
  BuildContext? context,
  bool? haveBackButton = true,
}) {
  final provider = Provider.of<AuthProvider>(context!);
  return AppBar(
    toolbarHeight: 80,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: haveBackButton!
        ? IconButton(
            onPressed: () => provider.previousPage(context),
            icon: Image.asset(
              Assets.imagesArrowBack,
              height: 15.87,
              color: kPrimaryColor,
            ),
          )
        : SizedBox(),
    title: Image.asset(
      Assets.imagesLogo,
      height: 55.65,
    ),
  );
}
