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
  late Future<Show> futureShow;

  Future<Show> fetchShow(id) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows/' + id.toString()));
  
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String, dynamic>();
      return Show.fromMap(parsed);
    } else {
      throw Exception('Failed to load futureShow');
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    futureShow = fetchShow(id);

    return FutureBuilder<Show>(
      future: futureShow,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var show = snapshot.data!;
          List<Widget> genres = [];
          for (var genre in show.genres) {
            genres.add(
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Text(genre),
              )
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(show.name),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(show.image!.medium),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              show.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(show.language),
                            Text(show.status),
                            Text(show.averageRuntime.toString() + 'min')
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(children: genres),
                      Html(data: show.summary.toString())
                    ],
                  )
                ],
              )
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
