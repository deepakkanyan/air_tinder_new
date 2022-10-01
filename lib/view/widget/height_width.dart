import 'package:flutter/widgets.dart';

height(double height, BuildContext context) {
  return MediaQuery.of(context).size.height * height;
}

width(double width, BuildContext context) {
  return MediaQuery.of(context).size.width * width;
}
