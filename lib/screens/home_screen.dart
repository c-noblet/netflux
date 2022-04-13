import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflux/components/cards/card.dart';
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 415,
                child: PageView.builder(
                  itemCount: 10,
                  onPageChanged: (int i) => setState(() => index = i),
                  controller: PageController(viewportFraction: 0.7),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == index ? 1 : 0.9,
                      child: ShowCard(data: snapshot.data![i])
                    );
                  }
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
