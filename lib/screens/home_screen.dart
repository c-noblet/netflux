import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflux/models/show_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  String errorMessage = '';
  late Future<List<Show>> shows;

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut()
      .then((value) => Navigator.of(context).pushReplacementNamed('/login'));
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<List<Show>> fetchShow() async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/shows'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Show>((json) => Show.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load show');
    }
  }

  @override
  void initState() {
    super.initState();
    shows = fetchShow();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Show>>(
      future: shows,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                // TODO : redirect to show details page
              },
              child: Column(
                children: [
                  (snapshot.data![index].image != null) ? Image.network(snapshot.data![index].image!.medium) : Container(),
                  Text(snapshot.data![index].name)
                ],
              )
            )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
