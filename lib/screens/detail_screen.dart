import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:netflux/models/show_model.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Show> show;

  Future<Show> fetchShow(id) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows/' + id.toString()));
  
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return Show.fromMap(parsed);
    } else {
      throw Exception('Failed to load show');
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    show = fetchShow(id);

    return FutureBuilder<Show>(
      future: show,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.name),
            ),
            body: SafeArea(
              child: Html(data: snapshot.data!.summary.toString()),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
