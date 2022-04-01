import 'package:flutter/material.dart';
import 'package:netflux/screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => const HomeScreen(title: 'Netflux')
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflux',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/home',
    );
  }
}
