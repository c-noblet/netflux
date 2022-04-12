import 'dart:js';

import 'package:flutter/material.dart';
import 'package:netflux/screens/app.dart';
import 'package:netflux/screens/detail_screen.dart';
import 'package:netflux/screens/login_screen.dart';
import 'package:netflux/screens/register_screen.dart';
import 'package:netflux/screens/search_screen.dart';
import 'package:netflux/screens/splash_screen.dart';
import 'package:netflux/screens/user_update_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (context) => const SplashScreen(),
  '/': (context) => const AppScreen(title: 'Netflux'),
  '/register': (context) => const RegisterScreen(),
  '/login': (context) => const LoginScreen(),
  '/detail': (context) => const DetailScreen(),
  '/profile': (context) => const UserUpdateScreen(),
  '/screen': (context) => const SearchScreen()
};
