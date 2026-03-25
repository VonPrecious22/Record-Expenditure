import 'package:flutter/material.dart';
import 'package:recordexpenditure/Screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recordexpenditure/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  ThemeMode _themeMode = ThemeMode.light;
  // void toggle(){
  //   setState(() {
  //     _themeMode = _themeMode == ThemeMode.light ?
  //    ThemeMode.dark : 
  //    ThemeMode.light;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          
          seedColor: Colors.white,
          brightness: Brightness.light
          )
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,
        brightness: Brightness.dark,
        )
      ),
      themeMode: ThemeMode.system,

    );
  }
}