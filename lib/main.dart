import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bootcamp/screens/splash_screen.dart';

import 'controller/items_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ItemProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
