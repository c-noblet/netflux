import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.firstname,
    required this.lastname,
    required this.country,
    required this.city,
    required this.birthdate,
    required this.image
  });

  String firstname;
  String lastname;
  String country;
  String city;
  String birthdate;
  String image;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    country: json["country"],
    city: json["city"],
    birthdate: json["birthdate"],
    image: json["image"],
  );

  factory UserModel.fromSnapshot(DocumentSnapshot<Object?>? object) => UserModel(
    firstname: object!["firstname"],
    lastname: object["lastname"],
    country: object["country"],
    city: object["city"],
    birthdate: object["birthdate"],
    image: object["image"],
  );

  Map<String, dynamic> toMap() => {
    "firstname": firstname,
    "lastname": lastname,
    "country": country,
    "city": city,
    "birthdate": birthdate,
    "image": image
  };
}
