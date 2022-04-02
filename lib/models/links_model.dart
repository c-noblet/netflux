import 'package:netflux/models/previous_episode_model.dart';

class Links {
  Links({
    required this.self,
    this.previousepisode,
  });

  Previousepisode self;
  Previousepisode? previousepisode;

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    self: Previousepisode.fromMap(json["self"]),
    previousepisode: Previousepisode.fromMap(json["previousepisode"]),
  );

  Map<String, dynamic> toMap() => {
    "self": self.toMap(),
    "previousepisode": previousepisode?.toMap(),
  };
}