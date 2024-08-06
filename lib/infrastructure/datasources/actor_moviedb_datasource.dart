import 'package:cinemapedia/config/constans/environment.dart';
import 'package:cinemapedia/domain/datasources/actores_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActormovieDbDatasource extends ActorsDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.movieDBKey,
  }));
  @override
  Future<List<Actor>> gertActorsByMovie(String movieid) async {
    final response = await dio.get('/movie/$movieid/credits');
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
        
    return actors;
  }
}
