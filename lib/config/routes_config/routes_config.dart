import 'package:air_tinder/view/auth/complete_profile/add_photos.dart';
import 'package:air_tinder/view/auth/login.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:air_tinder/view/chat/chat_heads.dart';
import 'package:air_tinder/view/home/home.dart';
import 'package:air_tinder/view/layover_surround/layover_surround.dart';
import 'package:air_tinder/view/settings/settings.dart';
import 'package:air_tinder/view/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    AppLinks.splashScreen: (_) => SplashScreen(),
    AppLinks.login: (_) => Login(),
    AppLinks.addPhotos: (_) => AddPhotos(),
    AppLinks.bottomNavBar: (_) => BottomNavBar(),
    AppLinks.chatHeads: (_) => ChatHeads(),
    AppLinks.settings: (_) => Settings(),
    AppLinks.home: (_) => Home(),
    AppLinks.layoverSurround: (_) => LayoverSurround(),
  };
}

class AppLinks {
  static const splashScreen = '/splash_screen';
  static const login = '/login';
  static const signUp = '/signup';
  static const addPhotos = '/add_photos';
  static const bottomNavBar = '/bottom_nav_bar';
  static const chatHeads = '/chat_heads';
  static const settings = '/settings';
  static const home = '/home';
  static const layoverSurround = '/layover_surround';
}
