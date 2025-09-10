import 'package:flutter/material.dart';
import 'package:remote_mouse/presentation/views/home_screen.dart';
import 'package:remote_mouse/remote_control.dart';
import 'package:remote_mouse/services/dep_injection/injection_container.dart';

Future<void> main() async{

  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen()
    );
  }
}

