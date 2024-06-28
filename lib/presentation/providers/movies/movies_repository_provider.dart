import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/respositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Solo lectura , es inmutable, su objetivo es proporcionar la info para consutlar la implementacion, aqui le estoy mandando el getNOwPlaying que viene del MoviedbDatasource
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
