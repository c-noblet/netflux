class Image {
  Image({
    required this.medium,
    required this.original,
  });

  String medium;
  String original;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
    medium: json["medium"],
    original: json["original"],
  );

  Map<String, dynamic> toMap() => {
    "medium": medium,
    "original": original,
  };
}