import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netflux/components/cards/card.dart';
import 'package:netflux/models/show_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int index = 0;
  String search = '';
  late Future<List<Show>> shows;

  Future<List<Show>> fetchShow() async {
    String url = 'https://api.tvmaze.com/shows';
    if (search != '') {
      url = 'https://api.tvmaze.com/search/shows?q=' + search;
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      if (search != '') {
        return parsed.map<Show>((json) => Show.fromMap(json.show)).toList();  
      }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: (String? value) => setState(() {
                search = value!;
                shows = fetchShow();
              }),
            ),
            FutureBuilder<List<Show>>(
              future: shows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
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
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container();
                }
              }
            )
          ],
        )
      ),
    );

  }
}
