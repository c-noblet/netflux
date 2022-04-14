import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:netflux/models/show_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../services/theme_builder.dart';

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
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade600
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    genre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.white
                    ),
                  ),
                ),
              )
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(show.name),
              actions: [
                IconButton(
                  onPressed: () {
                    ThemeBuilder.of(context)?.changeTheme();
                  },
                  icon: const Icon(Icons.dark_mode)
                )
              ]
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).brightness == Brightness.light ? Colors.blue.shade800 : Colors.black, 
                    Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100 : Colors.grey
                  ]
                )
              ),
              child: SafeArea(
                minimum: const EdgeInsets.all(5),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  show.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )
                                ),
                              ),
                              Text(
                                show.language,
                                style: const TextStyle(
                                  color: Colors.white
                                )
                              ),
                              Text(
                                DateFormat("dd/MM/yyyy").format(show.premiered),
                                style: const TextStyle(
                                  color: Colors.white
                                )
                              ),
                              Text(
                                show.status,
                                style: const TextStyle(
                                  color: Colors.white
                                )
                              ),
                              Text(
                                show.averageRuntime.toString() + 'min',
                                style: const TextStyle(
                                  color: Colors.white
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: genres
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Html(
                          data: show.summary.toString(),
                          style: {
                            "html": Style(
                              color: Colors.white
                            )
                          }
                        )
                      ],
                    )
                  ],
                )
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
