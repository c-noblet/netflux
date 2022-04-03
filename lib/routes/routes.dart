import 'package:flutter/material.dart';
import 'package:netflux/screens/app.dart';
import 'package:netflux/screens/login_screen.dart';
import 'package:netflux/screens/register_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const AppScreen(title: 'Netflux',),
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
};