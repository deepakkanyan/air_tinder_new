import 'package:air_tinder/config/routes_config/routes_config.dart';
import 'package:air_tinder/config/theme_config/light_theme.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; 
//1958
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
      ],
      child: MyApp(),
    ),
  );
}
//+Hello


//
var uuid = Uuid();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Jetlatch',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppLinks.splashScreen,
      routes: Routes.routes,
    );
  }
}
