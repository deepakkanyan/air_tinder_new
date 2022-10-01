import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/layover_radar_dialog.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/ripple_animation.dart';
import 'package:flutter/material.dart';

class LayoverSurround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackLogoAppBar(),
      body: Center(
        child: RippleAnimation(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: kPrimaryColor,
        splashColor: kSecondaryColor.withOpacity(0.03),
        disabledElevation: 0.0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return LayoverRadarDialog();
            },
          );
        },
        child: Image.asset(
          Assets.imagesInfo,
          height: 50,
        ),
      ),
    );
  }
}
