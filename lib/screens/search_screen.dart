import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netflux/components/cards/card.dart';
import 'package:netflux/models/show_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/shows_model.dart';
import '../services/theme_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int index = 0;
  String search = '';
  late Future<List> shows;
  bool searchProcessing = true;

  Future<List> fetchShow() async {
    String url = 'https://api.tvmaze.com/shows';
    if (search != '') {
      url = 'https://api.tvmaze.com/search/shows?q=' + search;
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      searchProcessing = false;
      if (search != '') {
        return parsed.map<Shows>((json) => Shows.fromMap(json)).toList();
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
        title: const Text('Search'),
        actions: [
          IconButton(
            onPressed: () {
              ThemeBuilder.of(context)?.changeTheme();
            },
            icon: const Icon(Icons.dark_mode)
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (String? value) => setState(() {
                    // ignore: unnecessary_null_comparison
                      searchProcessing = true;
                    if (value == null || value == '') {
                      search = '';
                      shows = fetchShow();
                    } else if (value.isNotEmpty) {
                      search = value;
                      shows = fetchShow();
                    }
                  }),
                  style: const TextStyle(color: Colors.white, fontSize: 14.5),
                  decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 45),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white60, fontSize: 14.5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: Colors.white38)
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:  const BorderSide(color: Colors.white70)
                    )
                  ),
                ),
              ),
              const SizedBox(height: 25),
              FutureBuilder<List>(
                future: shows,
                builder: (context, snapshot) {
                  if (snapshot.hasData && !searchProcessing) {
                    return SizedBox(
                      height: 415,
                      child: PageView.builder(
                        itemCount: snapshot.data!.length > 10 ? 10 : snapshot.data!.length,
                        onPageChanged: (int i) => setState(() => index = i),
                        controller: PageController(viewportFraction: 0.7),
                        itemBuilder: (_, i) {
                          if (snapshot.data![i] != null) {                            
                            return Transform.scale(
                              scale: i == index ? 1 : 0.9,
                              child: ShowCard(data: snapshot.data![i], search: search)
                            );
                          } else {
                            return Container();
                          }
                        }
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              )
            ],
          ),
        ),
      )
    );

  }
}
