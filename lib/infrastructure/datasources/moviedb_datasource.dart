import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDBKey,
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);
    // where si es true lo deja pasar
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Peticion http | dio ( es similar a axios ) | paquetes
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    // where si es true lo deja pasar
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    // Peticion http | dio ( es similar a axios ) | paquetes
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
        // top_rated
        // upcoming

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    // Peticion http | dio ( es similar a axios ) | paquetes
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
        // top_rated
        // upcoming

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    // Peticion http | dio ( es similar a axios ) | paquetes
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
        // top_rated
        // upcoming

    return _jsonToMovies(response.data);
  }
}
