class Country {
  Country({
    required this.name,
    this.code,
    this.timezone,
  });

  String name;
  String? code;
  String? timezone;

  factory Country.fromMap(Map<String, dynamic> json) => Country(
    name: json["name"],
    code: json["code"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "code": code,
    "timezone": timezone,
  };
}