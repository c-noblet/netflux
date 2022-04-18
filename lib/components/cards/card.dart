import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflux/models/show_model.dart';
import 'package:intl/intl.dart';

class ShowCard extends StatefulWidget {
  const ShowCard({Key? key, required this.data, this.search = ''}) : super(key: key);

  final data;
  final String search;
  
  @override
  State<ShowCard> createState() => _ShowCardState(data: this.data, search: this.search);
}

class _ShowCardState extends State<ShowCard> {
  _ShowCardState({Key? key, required this.data, this.search = ''});

  final data;
  final String search;

  @override
  Widget build(BuildContext context) {
    var show = this.search == '' ? this.data : this.data.show;
    List<Widget> genres = [];
    for (var genre in show.genres) {
      genres.add(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(genre),
        )
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: show.id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
            children: [
              (show.image != null) ? Image.network(show.image!.medium) : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  show.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              const SizedBox(height: 10),
              Text(DateFormat("dd/MM/yyyy").format(show.premiered)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: genres
              )
            ],
          ),
          )
        ),
      ),
    );
  }
}
