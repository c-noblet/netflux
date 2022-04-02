class Previousepisode {
  Previousepisode({
    required this.href,
  });

  String href;

  factory Previousepisode.fromMap(Map<String, dynamic> json) => Previousepisode(
    href: json["href"],
  );

  Map<String, dynamic> toMap() => {
    "href": href,
  };
}