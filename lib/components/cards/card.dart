import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflux/models/show_model.dart';
import 'package:intl/intl.dart';

class ShowCard extends StatefulWidget {
  const ShowCard({Key? key, required this.data}) : super(key: key);

  final Show data;
  
  @override
  State<ShowCard> createState() => _ShowCardState(data: this.data);
}

class _ShowCardState extends State<ShowCard> {
  _ShowCardState({Key? key, required this.data});

  final Show data;

  @override
  Widget build(BuildContext context) {
    var show = this.data;
    List<Widget> genres = [];
    for (var genre in show.genres) {
      genres.add(
        Padding(
          padding: EdgeInsets.all(3.0),
          child: Text(genre),
        )
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: this.data.id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
            children: [
              (show.image != null) ? Image.network(show.image!.medium) : Container(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  show.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
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
