class Rating {
  Rating({
    required this.average,
  });

  double average;

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
    average: json["average"] != null ? json["average"].toDouble() : 0.0,
  );

  Map<String, dynamic> toMap() => {
    "average": average,
  };
}