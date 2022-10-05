import 'package:air_tinder/generated/assets.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xffFFFFFF);
const kSecondaryColor = Color(0xffED2C23);
const kTertiaryColor = Color(0xff080808);
const kBrownColor = Color(0xffC13300);
var kGreyColor = const Color(0xff080808).withOpacity(0.70);
const kSuccessColor = Color(0xff22BB33);

var bgImage = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      Assets.imagesMainBg,
    ),
    fit: BoxFit.cover,
  ),
);
var loginBg = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      Assets.imagesLoginBg,
    ),
    fit: BoxFit.cover,
  ),
);

var redBg = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      Assets.imagesRedBg,
    ),
    fit: BoxFit.cover,
  ),
);
