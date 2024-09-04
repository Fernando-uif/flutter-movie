// no quiero crear instancias de esta
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});


  Future<List<Movie>> getUpComing({int page = 1});
  Future<Movie> getMovieById(String id);
  
  Future<List<Movie>> searchMoviews(String query);
}
