import 'package:air_tinder/config/routes_config/routes_config.dart';
import 'package:air_tinder/config/theme_config/light_theme.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/provider/splash_screen_provider/splash_screen_provider.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GlobalProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Air Tinder',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppLinks.splashScreen,
      routes: Routes.routes,
    );
  }
}
