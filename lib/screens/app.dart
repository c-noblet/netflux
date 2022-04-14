import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflux/models/show_model.dart';
import 'package:netflux/screens/home_screen.dart';
import 'package:netflux/screens/profile_screen.dart';
import '../services/theme_builder.dart';
import 'package:http/http.dart' as http;

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int index = 0;
  String errorMessage = '';

  List<Widget> list = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut()
      .then((value) => Navigator.of(context).pushReplacementNamed('/login'));
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Netflux'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          IconButton(
            onPressed: () {
              ThemeBuilder.of(context)?.changeTheme();
            },
            icon: const Icon(Icons.dark_mode)
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: list[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}
