import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/theme_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  String errorMessage = '';

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
        title: const Text('Netflux'),
        actions: [
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
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 48,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User')
        ],
      ),
    );
  }
}
