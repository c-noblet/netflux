import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflux/models/show_model.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/detail', arguments: this.data.id);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              (this.data.image != null) ? Image.network(this.data.image!.medium) : Container(),
              Text(this.data.name)
            ],
          ),
        ),
      ),
    );
  }
}