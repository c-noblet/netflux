import 'package:netflux/models/country_model.dart';

class Network {
  Network({
    required this.id,
    required this.name,
    this.country,
    this.officialSite,
  });

  int id;
  String name;
  Country? country;
  String? officialSite;

  factory Network.fromMap(Map<String, dynamic> json) => Network(
    id: json["id"],
    name: json["name"],
    country: Country.fromMap(json["country"]),
    officialSite: json["officialSite"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "country": country?.toMap(),
    "officialSite": officialSite,
  };
}