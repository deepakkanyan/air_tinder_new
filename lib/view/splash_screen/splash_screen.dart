import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/provider/splash_screen_provider/splash_screen_provider.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final SplashScreenProvider provider = SplashScreenProvider();
      provider.checkIfLoggedIn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        height: height(1.0, context),
        width: width(1.0, context),
        decoration: bgImage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                Assets.imagesLogo,
                height: 76.65,
              ),
            ),
            MyText(
              paddingTop: 25,
              text:
                  'Once upon a time they were traveling and they found love on a layover',
              size: 16,
              weight: FontWeight.w700,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
