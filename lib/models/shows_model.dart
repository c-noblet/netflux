import 'package:netflux/models/show_model.dart';

class Shows {
    Shows({
        required this.score,
        required this.show,
    });

    double score;
    Show show;

    factory Shows.fromMap(Map<String, dynamic> json) => Shows(
        score: json["score"].toDouble(),
        show: Show.fromMap(json["show"]),
    );

    Map<String, dynamic> toMap() => {
        "score": score,
        "show": show.toMap(),
    };
}
