import 'package:flutter/material.dart';
import 'package:netflux/screens/home_screen.dart';
import 'package:netflux/screens/login_screen.dart';
import 'package:netflux/screens/register_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/home': (context) => const HomeScreen(title: 'Netflux'),
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
};