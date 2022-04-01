import 'package:flutter/material.dart';
import 'package:netflux/screens/HomeScreen.dart';
import 'package:netflux/theme/AdaptativeTheme.dart';

void main() {
  runApp(const MyApp());
}

final Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => const HomeScreen(title: 'Netflux')
};

class MyApp extends StatelessWidget {

  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflux',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: routes,
      initialRoute: '/home',
    );
  }
}
