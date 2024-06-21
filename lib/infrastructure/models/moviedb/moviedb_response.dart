import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieDbResponse {
  final Dates? dates;
  final int page;
  final List<MovieMovieDB> MovieMovieDBs;
  final int totalPages;
  final int totalMovieMovieDBs;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.MovieMovieDBs,
    required this.totalPages,
    required this.totalMovieMovieDBs,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        dates: json['dates'] ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        MovieMovieDBs:
            List<MovieMovieDB>.from(json["MovieMovieDBs"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovieMovieDBs: json["total_MovieMovieDBs"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates == null ? {} : dates?.toJson(),
        "page": page,
        "MovieMovieDBs": List<dynamic>.from(MovieMovieDBs.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_MovieMovieDBs": totalMovieMovieDBs,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}

