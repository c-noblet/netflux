// To parse this JSON data, do
//
//     final show = showFromMap(jsonString);

import 'dart:convert';

import 'package:netflux/models/image_model.dart';
import 'package:netflux/models/links_model.dart';
import 'package:netflux/models/network_model.dart';
import 'package:netflux/models/rating_model.dart';

Show showFromMap(String str) => Show.fromMap(json.decode(str));

String showToMap(Show data) => json.encode(data.toMap());

class Show {
  Show({
    required this.id,
    this.url,
    required this.name,
    this.type,
    required this.language,
    required this.genres,
    required this.status,
    this.runtime,
    required this.averageRuntime,
    required this.premiered,
    this.ended,
    this.officialSite,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.dvdCountry,
    this.image,
    this.summary,
    this.updated,
    this.links,
  });

  int id;
  String? url;
  String name;
  String? type;
  String language;
  List<String> genres;
  String status;
  int? runtime;
  int averageRuntime;
  DateTime premiered;
  DateTime? ended;
  String? officialSite;
  Rating? rating;
  int? weight;
  Network? network;
  dynamic webChannel;
  dynamic dvdCountry;
  Image? image;
  String? summary;
  int? updated;
  Links? links;

  factory Show.fromMap(Map<String, dynamic> json) => Show(
    id: json["id"],
    url: json["url"],
    name: json["name"],
    type: json["type"],
    language: json["language"],
    genres: json["genres"] != null ? List<String>.from(json["genres"].map((x) => x)) : [],
    status: json["status"],
    runtime: json["runtime"],
    averageRuntime: json["averageRuntime"],
    premiered: DateTime.parse(json["premiered"]),
    ended: json["ended"] != null ? DateTime.parse(json["ended"]) : null,
    officialSite: json["officialSite"],
    rating: json["rating"] != null ? Rating.fromMap(json["rating"]) : null,
    weight: json["weight"],
    network: json["network"] != null ? Network.fromMap(json["network"]) : null,
    webChannel: json["webChannel"],
    dvdCountry: json["dvdCountry"],
    image: json["image"] != null ? Image.fromMap(json["image"]) : null,
    summary: json["summary"],
    updated: json["updated"],
    links: json["_links"] != null ? Links.fromMap(json["_links"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "url": url,
    "name": name,
    "type": type,
    "language": language,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "status": status,
    "runtime": runtime,
    "averageRuntime": averageRuntime,
    "premiered": "${premiered?.year.toString().padLeft(4, '0')}-${premiered?.month.toString().padLeft(2, '0')}-${premiered?.day.toString().padLeft(2, '0')}",
    "ended": "${ended?.year.toString().padLeft(4, '0')}-${ended?.month.toString().padLeft(2, '0')}-${ended?.day.toString().padLeft(2, '0')}",
    "officialSite": officialSite,
    "rating": rating?.toMap(),
    "weight": weight,
    "network": network?.toMap(),
    "webChannel": webChannel,
    "dvdCountry": dvdCountry,
    "image": image?.toMap(),
    "summary": summary,
    "updated": updated,
    "_links": links?.toMap(),
  };
}
