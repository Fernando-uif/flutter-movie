import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDBKey,
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Peticion http | dio ( es similar a axios ) | paquetes
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];
    
    return movies;
  }
}
